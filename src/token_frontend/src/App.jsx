import React from "react";
import Header from "./components/Header";
import Faucet from "./components/Faucet";
import Balance from "./components/Balance";
import Transfer from "./components/Transfer";

function App(props) {

  return (
    <div id="screen">
      <Header />
      <Faucet principal={props.userPrincipal} />
      <Balance />
      <Transfer />
    </div>
  );
}

export default App;
