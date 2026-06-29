
-- Drop and recreate contact_overrides policies to properly support upsert for admins
DROP POLICY IF EXISTS "select_overrides_public" ON contact_overrides;
DROP POLICY IF EXISTS "insert_overrides_admin" ON contact_overrides;
DROP POLICY IF EXISTS "update_overrides_admin" ON contact_overrides;
DROP POLICY IF EXISTS "delete_overrides_admin" ON contact_overrides;

-- Allow all authenticated AND anon users to read overrides (needed for display merging)
CREATE POLICY "select_overrides_all" ON contact_overrides FOR SELECT
  TO anon, authenticated USING (true);

-- Admin insert: use a direct role check
CREATE POLICY "insert_overrides_admin" ON contact_overrides FOR INSERT
  TO authenticated WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- Admin update: use a direct role check
CREATE POLICY "update_overrides_admin" ON contact_overrides FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  )
  WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- Admin delete
CREATE POLICY "delete_overrides_admin" ON contact_overrides FOR DELETE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );
