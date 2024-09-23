import React, { useState } from "react";
import { token_backend, canisterId, createActor } from "../../../declarations/token_backend";
import { AuthClient } from "@dfinity/auth-client";

function Faucet(props) {

  const [isDisabled, setDisabled] = useState(false);
  const [buttonText, setButton] = useState("Gimme gimme");

  async function handleClick() {

    const authClient = await AuthClient.create();
    const identity = authClient.getIdentity();

    const authenticatedCanister = createActor(canisterId, {
      agentOptions: {
        identity,
      }
    });
    
    setDisabled(true);
    const result = await token_backend.payOut(authenticatedCanister);
    setButton(result);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free tokens here! Claim 10,000 DANG tokens to {props.principal}.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
