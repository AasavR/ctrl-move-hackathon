module LasavoPay::StablecoinSwap {
    // Thin wrapper that demonstrates the swap intent and emits Swap events.
    use std::signer;
    use aptos_framework::event::{EventHandle, emit_event};

    struct SwapEvent has copy, drop, store { id: u64, trader: address, from_amt: u64, to_amt: u64 }
    resource struct SwapStore { next_id: u64, events: EventHandle<SwapEvent> }

    public fun init(account: &signer) {
        let addr = signer::address_of(account);
        if (!exists<SwapStore>(addr)) {
            let h = aptos_framework::event::new_event_handle<SwapEvent>(account);
            move_to(account, SwapStore { next_id: 1, events: h });
        }
    }

    public fun emit_swap_intent(account: &signer, from_amt: u64, to_amt: u64) {
        let addr = signer::address_of(account);
        let store = borrow_global_mut<SwapStore>(addr);
        let id = store.next_id;
        store.next_id = id + 1;
        let ev = SwapEvent { id, trader: addr, from_amt, to_amt };
        aptos_framework::event::emit_event(&mut store.events, ev);
    }
}
