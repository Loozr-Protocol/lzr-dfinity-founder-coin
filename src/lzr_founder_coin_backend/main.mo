import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Time "mo:base/Time";

import ExperimentalCycles "mo:base/ExperimentalCycles";

import ICRC1 "./ICRC1";
import Array "mo:base/Array";
import Token "./Token";

actor Factory {
    type Token = Token.Token;

    let n = 4;

    let tokens : [var ?Token] = Array.init(n, null);
    let cycleShare = ExperimentalCycles.balance() / (n + 1);

    // Deposit cycles into this archive canister.
    public shared ({ caller = _owner }) func new_token() : async Token {
        let m: ICRC1.TokenInitArgs = {
            advanced_settings = null;
            decimals = 18;
            fee = 1_000;
            initial_balances = [(
                {
                    owner = _owner;
                    subaccount = null;
                },
                0,
            )];
            max_supply = 0;
            min_burn_amount = 0;
            minting_account = null;
            name = "Funny Token1";
            symbol = "FNT-1";
        };
        ExperimentalCycles.add(cycleShare);
        let b = await Token.Token(m);
        return b;
    };
};
