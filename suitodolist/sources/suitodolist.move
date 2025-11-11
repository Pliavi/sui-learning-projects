module suitodolist::suitodolist;

use std::string::String;

public struct TodoList has key, store {
    id: UID,
    items: vector<String>,
}

#[allow(lint(self_transfer))]
public fun new(ctx: &mut TxContext) {
    let list = TodoList {
        id: object::new(ctx),
        items: vector::empty<String>(),
    };

    transfer::transfer(list, tx_context::sender(ctx));
}

public fun add_item(list: &mut TodoList, item: String) {
    list.items.push_back(item);
}

public fun remove_item(list: &mut TodoList, index: u64) {
    list.items.remove(index);
}

public fun clear_list(list: TodoList) {
    let TodoList { id, items: _ } = list;
    id.delete()
}
