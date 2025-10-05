module LasavoPay::PaymentEscrow {
    use std::signer;
    use std::vector;
    use aptos_framework::coin::{Coin, withdraw, deposit, extract_coin, transfer};
    use aptos_framework::event::{EventHandle, emit_event};
    use aptos_framework::timestamp;

    struct Escrow has key, store {
        id: u64,
        sender: address,
        receiver: address,
        amount: u64,
        currency: address,
        created_at: u64,
        claimed: bool,
    }

    resource struct EscrowStore {
        next_id: u64,
        escrows: vector<Escrow>,
        events: EventHandle<EscrowEvent>,
    }

    struct EscrowEvent has copy, drop, store {
        id: u64,
        sender: address,
        receiver: address,
        amount: u64,
        currency: address,
        action: vector<u8>,
        ts: u64,
    }

    public fun init(account: &signer) {
        let addr = signer::address_of(account);
        if (!exists<EscrowStore>(addr)) {
            let handle = aptos_framework::event::new_event_handle<EscrowEvent>(account);
            move_to(account, EscrowStore { next_id: 1u64, escrows: vector::empty<Escrow>(), events: handle });
        }
    }

    public fun create_escrow(account: &signer, receiver: address, amount: u64, currency: address) {
        // withdraw coins from sender to contract (simplified as storing metadata)
        let sender = signer::address_of(account);
        assert!(amount > 0, 1);
        let ts = timestamp::now_seconds();
        let store = borrow_global_mut<EscrowStore>(sender);
        let id = store.next_id;
        store.next_id = id + 1;
        let escrow = Escrow { id, sender, receiver, amount, currency, created_at: ts, claimed: false };
        vector::push_back(&mut store.escrows, escrow);
        let ev = EscrowEvent { id, sender, receiver, amount, currency, action: vector::empty<u8>(), ts };
        aptos_framework::event::emit_event(&mut store.events, ev);
    }

    public fun claim_escrow(account: &signer, escrow_id: u64) {
        let receiver = signer::address_of(account);
        // find escrow in receiver's store or in sender store (for demo we scan sender stores)
        // NOTE: production: index escrows into a global mapping; demo keeps it simple
        // Iterate all accounts isn't feasible on-chain — for the hackathon demo we assume the escrow owner (sender) calls a helper to transfer
        // Instead provide `release_by_sender` and `claim_by_receiver_with_proof` off-chain flows.
    }
}
