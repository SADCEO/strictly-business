# Project memory

## Product intent & audience

- Directory/listings platform for trades and business categories.
- Profiles show the person's trade/category under their name.
- Each trade has a full list view ("see all" for that category), accessible from both the home page and now from individual profiles.

## Brand personality & voice

- Helpful and direct; explains limitations plainly and invites correction.

## Visual design & UX direction

- Trade cards displayed in a 3D carousel layout on home page.
- Each trade has an associated icon displayed in multiple UI locations.
- ~60 trade types recognized via keyword matching on trade name (scissors→barber, dog→pet grooming, grad cap→tutoring, flower→florist, lock-shield→security).
- 32 trades had existing explicit icons and retain them.
- Unmatched trades default to briefcase icon instead of dot.
- App supports light mode and dark mode.
- Focused/center card is solid (white in light mode, dark navy in dark mode) — no transparency.
- Side cards in the carousel fade slightly to preserve 3D depth effect.
- Profile category label under a name is tappable; includes a small arrow and hover highlight to signal interactivity.
- If a profile's trade doesn't match a home-page trade, the label renders as plain non-interactive text.

## Decisions, constraints & rationale

- Trade list is stored locked/encrypted, so exact trade names cannot be inspected directly at runtime.
- Icon assignment uses keyword-based picker reading words from each trade's name rather than a static mapping to every trade.
- Fallback chosen as briefcase (professional, generic) to eliminate empty dot placeholders.
- Card transparency on focus removed because see-through cards made text/icons hard to read.
- Side-card fade retained to keep 3D carousel aesthetic.
- Profile category label made tappable to improve navigation flow from a profile to the full trade list.
- Arrow + hover highlight added to tappable label so users can discover the interaction.
- Plain-label fallback for unmatched trades prevents dead/empty navigation.

## Open questions & assumptions

- Assumption: keyword matching on trade names reliably selects appropriate icons; may produce mismatches for ambiguous names.
- User may report specific trades where the auto-assigned icon looks wrong; corrections handled case-by-case.
- Open: whether side cards should also be fully solid or keep the current fade.
- Open: whether unmatched-trade profile labels should navigate to a broader fallback view instead of being non-interactive.
- Assumption: users will discover the tappable category label via the arrow/hover cues.