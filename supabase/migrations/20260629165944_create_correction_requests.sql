
-- Correction requests: users suggest fixes for contact info
CREATE TABLE correction_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  contact_name TEXT NOT NULL,
  contact_category TEXT,
  notes TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at TIMESTAMPTZ
);

ALTER TABLE correction_requests ENABLE ROW LEVEL SECURITY;

-- Users can see their own corrections
CREATE POLICY "select_own_corrections" ON correction_requests FOR SELECT
  TO authenticated USING (auth.uid() = user_id);

CREATE POLICY "insert_own_corrections" ON correction_requests FOR INSERT
  TO authenticated WITH CHECK (auth.uid() = user_id);

CREATE POLICY "update_own_corrections" ON correction_requests FOR UPDATE
  TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE POLICY "delete_own_corrections" ON correction_requests FOR DELETE
  TO authenticated USING (auth.uid() = user_id);

-- Admins can see all corrections
CREATE POLICY "admin_select_all_corrections" ON correction_requests FOR SELECT
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "admin_update_all_corrections" ON correction_requests FOR UPDATE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  ) WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );
