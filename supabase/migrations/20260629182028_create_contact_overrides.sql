
-- Admin overrides for contact details
CREATE TABLE contact_overrides (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contact_name TEXT NOT NULL,
  override_name TEXT,
  override_category TEXT,
  override_bio TEXT,
  override_tags TEXT,
  updated_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(contact_name)
);

ALTER TABLE contact_overrides ENABLE ROW LEVEL SECURITY;

-- Only admins can read overrides (but we also allow anon/authenticated to read for display merging)
CREATE POLICY "select_overrides_public" ON contact_overrides FOR SELECT
  TO authenticated USING (true);

CREATE POLICY "insert_overrides_admin" ON contact_overrides FOR INSERT
  TO authenticated WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "update_overrides_admin" ON contact_overrides FOR UPDATE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  ) WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "delete_overrides_admin" ON contact_overrides FOR DELETE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );
