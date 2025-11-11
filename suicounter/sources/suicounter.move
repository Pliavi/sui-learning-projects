module suicounter::counter;

use std::debug::print;

public struct Suicounter has drop {
    current: u64,
    target: u64,
}

// É utilizado um inteiro aqui para sinalizar o erro de overflow
// Esse número "não é" realmente um valor utilizado no código
#[error]
const ECOUNTER_OVERFLOW: u8 = 0;

public fun new_counter(target: u64): Suicounter {
    Suicounter { current: 0, target }
}

fun increment(counter: &mut Suicounter) {
    assert!(counter.current < counter.target, ECOUNTER_OVERFLOW);
    counter.current = counter.current + 1;
}

fun get_current(counter: &Suicounter): u64 {
    print(&counter.current);
    counter.current
}

fun is_complete(counter: &Suicounter): bool {
    counter.current == counter.target
}

fun reset(counter: &mut Suicounter) {
    counter.current = 0;
}

fun start(counter: &mut Suicounter): () {
    while (!is_complete(counter)) {
        get_current(counter);
        increment(counter);
    };
    reset(counter);
}

#[test]
fun test_counter() {
    let mut counter = new_counter(5);
    start(&mut counter);
}
