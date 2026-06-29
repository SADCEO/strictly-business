
-- Add requester_email to profile_claims
ALTER TABLE profile_claims ADD COLUMN requester_email TEXT;

-- Add requester_email to correction_requests
ALTER TABLE correction_requests ADD COLUMN requester_email TEXT;
