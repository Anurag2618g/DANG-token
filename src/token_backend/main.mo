import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";

actor token{
    var owner: Principal = Principal.fromText("2zjrq-yt6us-bexnr-xbjwg-hnlek-elkpy-z3pjg-a5by2-vyi3b-2lrsa-5ae");
    var totalSupply: Nat = 100000000;
    var symbol: Text = "DANG";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);

    public query func balanceOf(who: Principal): async  Nat {

        let balance = switch(balances.get(who)){
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol(): async Text {
        return symbol;
    };
};