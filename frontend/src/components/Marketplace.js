import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
// const ethers = require("ethers")
import NFTMarketplace from "../utils/NFTMarketplace.json";

function Marketplace() {
  const CONTRACT_ADDR = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDR, NFTMarketplace.abi, signer);

  const [nftData, setNFTData] = useState([]);

  let getAllNFT = async () => {
    let data = await contract.getAllNFTs();
    if (data.length > 0) {
      setNFTData(data);
    }
  };

  useEffect(() => {
    getAllNFT();
  });

  if(nftData.length > 0){
    return (
        <>
          <h1>NFT Marketplace</h1>
        </>
      );
  }else{
    return (
        <>
        <h1>No NFT Data To Show Below</h1>
        </>
    )
  }
}

export default Marketplace;
