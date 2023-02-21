import { useState } from "react";
import { ethers } from "ethers";
import axios from "axios";
import NFTMarketplace from "../utils/NFTMarketplace.json";

function Marketplace() {
  const CONTRACT_ADDR = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  const [nftData, setNFTData] = useState([]);
  const [fetched, updateFetched] = useState(false);
  
  let getAllNFT = async () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(CONTRACT_ADDR, NFTMarketplace.abi, signer);
    let nftArr = await contract.getAllNFTs();
    if (nftArr.length > 0) {
      const nftItems = await nftArr.map(async(eachNft) => {
        const tokenURI = await contract.tokenURI(eachNft.tokenID);
        let nftMetadata = await axios.get(tokenURI);
        let nftData = nftMetadata.data;
        let price = ethers.utils.formatUnits(eachNft.price.toString());
        let item = {
          price,
          tokenID:eachNft.tokenID,
          seller:eachNft.seller,
          owner:eachNft.owner,
          image:nftData.image,
          description:nftData.description
        }
        return item;
      })
      setNFTData(nftItems);
      updateFetched(true);
    }
  };

  if(!fetched){
    getAllNFT();
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
