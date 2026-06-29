
-- Allow admins to delete any claim record
CREATE POLICY "admin_delete_all_claims" ON profile_claims FOR DELETE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- Allow admins to delete any correction record
CREATE POLICY "admin_delete_all_corrections" ON correction_requests FOR DELETE
  TO authenticated USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );
