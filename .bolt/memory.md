# Project memory

## Product intent & audience

- App involving trades/business categories, likely a directory, booking, or listings platform.
- Trades are user-facing categories (e.g., Hair/Barber, Pet Grooming, Tutoring, Florist, Security/Alarms).

## Brand personality & voice

- Helpful and direct; explains limitations plainly and invites correction.

## Visual design & UX direction

- Each trade has an associated icon displayed in the UI; icons are used in multiple locations.
- Previously, unmatched trades rendered a plain dot/circle placeholder — now replaced with contextual icons or a briefcase fallback.
- ~60 trade types recognized via keyword matching on trade name (scissors for barber, dog for pet grooming, grad cap for tutoring, flower for florist, lock-shield for security).
- 32 trades had existing explicit icons and retain them.
- Unmatched trades default to briefcase icon instead of dot.

## Decisions, constraints & rationale

- Trade list is stored locked/encrypted, so exact trade names cannot be inspected directly at runtime.
- Icon assignment uses keyword-based picker reading words from each trade's name rather than a static mapping to every trade.
- Fallback chosen as briefcase (professional, generic) to eliminate empty dot placeholders.

## Open questions & assumptions

- Assumption: keyword matching on trade names reliably selects appropriate icons; may produce mismatches for ambiguous names.
- User may report specific trades where the auto-assigned icon looks wrong; corrections handled case-by-case.