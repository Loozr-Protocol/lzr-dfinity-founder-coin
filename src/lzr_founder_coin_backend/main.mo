import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Time "mo:base/Time";

import ExperimentalCycles "mo:base/ExperimentalCycles";

import ICRC1 "./ICRC1";
import Array "mo:base/Array";
import Token "./Token";

shared ({ caller = _owner }) actor class Factory() {
    type Token = Token.Token;
    stable let minting_account : ICRC1.Account = {
        owner = _owner;
        subaccount = null;
    };

    let n = 4;

    let tokens : [var ?Token] = Array.init(n, null);
    let cycleShare = ExperimentalCycles.balance() / (n + 1);

    // Deposit cycles into this archive canister.
    public shared func new_token(
        name : Text,
        symbol : Text,
    ) : async Token {
        ExperimentalCycles.add(cycleShare);
        let b = await Token.Token(name, symbol, minting_account);
        return b;
    };
};
