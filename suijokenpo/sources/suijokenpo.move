module suijokenpo::jokenpo;

use std::debug::print;
use std::string::{String, append};

#[error]
const ENOT_A_PLAYER: u64 = 0;

#[error]
const EMOVE_NOT_SET: u64 = 1;

public enum Moves has copy, drop {
    Rock,
    Paper,
    Scissors,
}

public fun new_rock(): Moves { Moves::Rock }

public fun new_paper(): Moves { Moves::Paper }

public fun new_scissors(): Moves { Moves::Scissors }

public enum GameResult has copy, drop {
    Player1Wins,
    Player2Wins,
    Draw,
}

public fun to_string(movement: &mut Moves): String {
    match (*movement) {
        Moves::Rock => b"Rock".to_string(),
        Moves::Paper => b"Paper".to_string(),
        Moves::Scissors => b"Scissors".to_string(),
    }
}

public struct Game has copy, drop {
    player1: Option<Moves>,
    player2: Option<Moves>,
}

public fun new_jokenpo(): Game {
    Game {
        player1: option::none<Moves>(),
        player2: option::none<Moves>(),
    }
}

public fun set_player_move(game: &mut Game, player: u8, movement: Moves) {
    assert!(player == 1 || player == 2, ENOT_A_PLAYER);
    if (player == 1) {
        game.player1 = option::some(movement);
        return
    };

    if (player == 2) {
        game.player2 = option::some(movement);
        return
    }
}

public fun get_winner(game: &Game): GameResult {
    assert!(option::is_some(&game.player1) && option::is_some(&game.player2), EMOVE_NOT_SET);

    let p1_move = option::borrow(&game.player1);
    let p2_move = option::borrow(&game.player2);

    let vs = b" vs ".to_string();

    let mut versus = b"".to_string();
    versus.append((*p1_move).to_string());
    versus.append(vs);
    versus.append((*p2_move).to_string());

    print(&versus);

    if (*p1_move == *p2_move) {
        return GameResult::Draw
    };

    if (
        (*p1_move == Moves::Rock && *p2_move == Moves::Scissors) ||
        (*p1_move == Moves::Paper && *p2_move == Moves::Rock) ||
        (*p1_move == Moves::Scissors && *p2_move == Moves::Paper)
    ) {
        return GameResult::Player1Wins
    };

    return GameResult::Player2Wins
}

public fun game_result_message(result: &mut GameResult): String {
    match (*result) {
        GameResult::Player1Wins => b"Player 1 Wins".to_string(),
        GameResult::Player2Wins => b"Player 2 Wins".to_string(),
        GameResult::Draw => b"Draw".to_string(),
    }
}
