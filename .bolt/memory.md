# Project memory

## Product intent & audience

- App involving trades/business categories, likely a directory, booking, or listings platform.
- Trades are user-facing categories (e.g., Hair/Barber, Pet Grooming, Tutoring, Florist, Security/Alarms).

## Brand personality & voice

- Helpful and direct; explains limitations plainly and invites correction.

## Visual design & UX direction

- Trade cards displayed in a 3D carousel layout.
- Each trade has an associated icon displayed in the UI; icons are used in multiple locations.
- ~60 trade types recognized via keyword matching on trade name (scissors for barber, dog for pet grooming, grad cap for tutoring, flower for florist, lock-shield for security).
- 32 trades had existing explicit icons and retain them.
- Unmatched trades default to briefcase icon instead of dot.
- App supports light mode and dark mode.
- Focused/center card is solid (white in light mode, dark navy in dark mode) — no transparency.
- Side cards in the carousel still fade slightly to preserve the 3D depth effect.

## Decisions, constraints & rationale

- Trade list is stored locked/encrypted, so exact trade names cannot be inspected directly at runtime.
- Icon assignment uses keyword-based picker reading words from each trade's name rather than a static mapping to every trade.
- Fallback chosen as briefcase (professional, generic) to eliminate empty dot placeholders.
- Card transparency on focus removed because see-through cards made text/icons hard to read when cards stacked behind showed through.
- Side-card fade retained to keep 3D carousel aesthetic; user has not requested removing it.

## Open questions & assumptions

- Assumption: keyword matching on trade names reliably selects appropriate icons; may produce mismatches for ambiguous names.
- User may report specific trades where the auto-assigned icon looks wrong; corrections handled case-by-case.
- Open: whether side cards should also be fully solid or keep the current fade.