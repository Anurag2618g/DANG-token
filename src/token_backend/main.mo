import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

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

    public shared(msg) func payOut(): async Text {
        Debug.print(debug_show(msg.caller));
        if(balances.get(msg.caller) == null){
            let amount = 10000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {
            return "Already Claimed";
        }    
    };

    public shared(msg) func transfer(to: Principal, amount: Nat): async  Text {
        let fromBalance = await balanceOf(msg.caller);

        if (fromBalance > amount){
            let newFromBalance: Nat = fromBalance-amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance = toBalance+amount;
            balances.put(to, newToBalance);

            return "Success";
        } else {
            return "Insufficient Funds";
        }
    };
};