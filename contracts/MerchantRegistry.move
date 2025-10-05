module LasavoPay::MerchantRegistry {
    use std::signer;
    use std::vector;
    use aptos_framework::event::{EventHandle, emit_event};
    use aptos_framework::timestamp;

    struct Merchant has key, store {
        owner: address,
        name: vector<u8>,
        metadata_uri: vector<u8>,
        created_at: u64,
    }

    resource struct Registry { merchants: vector<(address, Merchant)>, events: EventHandle<MerchantEvent> }

    struct MerchantEvent has copy, drop, store { merchant: address, action: vector<u8>, ts: u64 }

    public fun init(account: &signer) {
        let addr = signer::address_of(account);
        if (!exists<Registry>(addr)) {
            let handle = aptos_framework::event::new_event_handle<MerchantEvent>(account);
            move_to(account, Registry { merchants: vector::empty<(address, Merchant)>(), events: handle });
        }
    }

    public fun register(account: &signer, merchant_addr: address, name: vector<u8>, metadata_uri: vector<u8>, ts: u64) {
        let owner = signer::address_of(account);
        let merchant = Merchant { owner: merchant_addr, name, metadata_uri, created_at: ts };
        let reg = borrow_global_mut<Registry>(owner);
        vector::push_back(&mut reg.merchants, (merchant_addr, merchant));
        let ev = MerchantEvent { merchant: merchant_addr, action: vector::empty<u8>(), ts };
        aptos_framework::event::emit_event(&mut reg.events, ev);
    }
}
