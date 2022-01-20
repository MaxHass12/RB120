1. `Game`

- States: `@deck`, `@player`, `@dealer`
- Interfaces: `play`
- Collaborators: `Deck`, `Player`, `Dealer`

2. `Deck`

- States: `cards`
- Interfaces: `deal_card`, `reset_cards`
- Collaborators: `Card`

3. `Card`

- States: `@value`
- Interfaces: `value`, `to_s`
- Collaborators: None

4. `Participant`

- States: `@hand`
- Interfaces: busted?, `add_to_hand(card)`, `hand_value`, `reset_hand`
- Collaborators: `Card`

5. `Player` < `Participant`

- States: `@hand`, `@stay = false`
- Interfaces: `take_turn(deck)`, `display_hand`
- Collaborators: `Card`

6. `Dealer` < `Participant`

- States: `@hand`
- Interfaces: take_turn(deck), `display_hand(player_stays)`
- Collaborators: `Card`
