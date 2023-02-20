# Ethereum NFT Marketplace

## Tech Stack Used
- Hardhat
- Solidity
- React.js
- HTML
- CSS
- Web3.js
- ethers.js
- Pinata
- IPFS

## About Marketplace Contract
This is a Solidity smart contract for an NFT marketplace that allows users to create and sell NFTs. The contract inherits from ERC721URIStorage, which is a standard implementation of the ERC721 NFT standard, and uses OpenZeppelin's Counters library to keep track of token IDs and the number of items sold.

The contract has a single owner, who can update the listing price for NFTs, and users can create NFTs by calling the createNFT function with a token URI and a price. The createNFT function mints a new NFT with a unique token ID, sets the token URI, and creates a new ListedToken object that tracks the owner, seller, price, and whether the NFT is currently listed for sale. The NFT is transferred to the marketplace, and the seller receives payment from the buyer when the NFT is sold.

The contract also includes several helper functions for fetching NFTs by user, getting the latest and specific ListedTokens based on the token ID, and getting the current token ID.

Overall, this contract provides a basic implementation for a simple NFT marketplace where users can create and sell their own NFTs.

## Installation

## Live Link