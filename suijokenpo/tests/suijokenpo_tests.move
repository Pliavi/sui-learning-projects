#[test_only]
module suijokenpo::suijokenpo_tests;

use std::debug::print;
use suijokenpo::jokenpo;

#[test]
fun test_jokenpo() {
    // p1 = Rock, p2 = Scissors => p1 wins
    let mut game = jokenpo::new_jokenpo();
    jokenpo::set_player_move(&mut game, 1, jokenpo::new_rock());
    jokenpo::set_player_move(&mut game, 2, jokenpo::new_scissors());
    let result = &mut jokenpo::get_winner(&game);
    print(&jokenpo::game_result_message(result));
    print(&b"");

    // p1 = Paper, p2 = Scissors => p2 wins
    jokenpo::set_player_move(&mut game, 1, jokenpo::new_paper());
    jokenpo::set_player_move(&mut game, 2, jokenpo::new_scissors());
    let result = &mut jokenpo::get_winner(&game);
    print(&jokenpo::game_result_message(result));
    print(&b"");

    // p1 = Paper, p2 = Paper => draw
    jokenpo::set_player_move(&mut game, 1, jokenpo::new_paper());
    jokenpo::set_player_move(&mut game, 2, jokenpo::new_paper());
    let result = &mut jokenpo::get_winner(&game);
    print(&jokenpo::game_result_message(result));
    print(&b"");
}
