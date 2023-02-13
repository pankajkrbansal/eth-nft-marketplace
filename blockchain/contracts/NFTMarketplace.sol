// SPDX-License-Identifier:MIT

pragma solidity >= 0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "hardhat/console.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract NFTMarketplace is ERC721URIStorage{
    address payable private owner; // owner of the nft marketplace
    uint256 listingPrice = 0.001 ether;    
    mapping (uint256 => ListedToken) private idToToken;

    using Counters for Counters.Counter;
    Counter.Counter private _tokenIds;
    Counter.Counters private _itemSold; // items sold on marketplace

    struct ListedToken{
        uint256 tokenID;
        address payable owner;
        address payable seller;
        uint256 price;
        bool isCurrentlyListed;
    }

    constructor()ERC721("NFTMarketplace","NFTMRKT"){
        owner = payable(msg.sender);
    }

    // function to update listing price by only owner
    function updateListingPrice(uint256 _listingPrice) public payable {
        require(owner == msg.sender, "Listing Price Can Be Updated By Owner Only");
        listingPrice = _listingPrice;
    } 

    // function to fetch listing price on marketplace
    function getListingPrice() public view returns(uint256) {
        return listingPrice;
    }

    // function to fetch Listed token based on token id
    function getTokenById(uint256 tokenId) public view returns(ListedToken){
        
    }
}