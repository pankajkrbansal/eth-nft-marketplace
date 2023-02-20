import { useState } from "react";

let Navigation = () => {
  const [isWalletConnected, setWalletConnected] = useState(false);
  const [account, setAccount] = useState('');

  let connectWithWallet = async() => {
    console.log("wallet");
    const {ethereum} = window;
    if (!ethereum) {
      <div classNameName="alert alert-secondary" role="alert">
        A simple secondary alert—check it out!
      </div>
    }
    // take crypto account out from ethereum object
    let cryptoAccount = await ethereum.request({
      method: "eth_requestAccounts",
    });
    {
      cryptoAccount.length == 0 || cryptoAccount.length == undefined ?
         setWalletConnected(false)
        : setWalletConnected(true);
    }
  }
  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light">
      <a className="navbar-brand" href="/">
        NFT Marketplace
      </a>
      <button
        className="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span className="navbar-toggler-icon"></span>
      </button>

      <div className="collapse navbar-collapse" id="navbarSupportedContent">
        <ul className="navbar-nav">
          <li className="nav-item">
            <a className="nav-link" href="/sellnft">
              Sell NFT
            </a>
          </li>
          <li className="nav-item">
            <a className="nav-link" href="/profile">
              Profile
            </a>
          </li>
          {/* <li className="nav-item">
            <a className="nav-link  ml-auto">
              Connect With Metamask
            </a>
          </li> */}
        </ul>
      </div>
      <button className="btn btn-warning" onClick={connectWithWallet}>Connect With Metamask</button>
    </nav>

  );
};

export default Navigation;