
-- Profile claims: users claim ownership of a contact listing
CREATE TABLE profile_claims (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  target_contact_name TEXT NOT NULL,
  target_contact_category TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at TIMESTAMPTZ
);

ALTER TABLE profile_claims ENABLE ROW LEVEL SECURITY;

-- Users can see their own claims
CREATE POLICY "select_own_claims" ON profile_claims FOR SELECT
  TO authenticated USING (auth.uid() = user_id);

CREATE POLICY "insert_own_claims" ON profile_claims FOR INSERT
  TO authenticated WITH CHECK (auth.uid() = user_id);

CREATE POLICY "update_own_claims" ON profile_claims FOR UPDATE
  TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE POLICY "delete_own_claims" ON profile_claims FOR DELETE
  TO authenticated USING (auth.uid() = user_id);

-- Admins can see all claims
CREATE POLICY "admin_select_all_claims" ON profile_claims FOR SELECT
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "admin_update_all_claims" ON profile_claims FOR UPDATE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  ) WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );
