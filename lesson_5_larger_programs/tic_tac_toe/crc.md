1. TTTGame

- state: board, user, computer, player1, player2
- interface: play
- collaborators: Board, Player

2. Board

- state: squares, user_marker, computer_marker
- interface: reset, display, set_player_markers, user_won?, computer_won?, mark_square(marker)
- collaborators: Square

3. Square

- state: mark
- interface: to_s, blank?, mark=,
- collaborators: None

4. Player

- state: marker, score, name
- interface: score, marker, marker=, name, name=, reset_score, increment_score
- collaborator: None
