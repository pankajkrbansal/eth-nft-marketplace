// SPDX-License-Identifier:MIT

pragma solidity >= 0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
// import "../node_modules/@openzeppelin";

contract NFTMarketplace is ERC721URIStorage{
    address payable private owner; // owner of the nft marketplace
    uint256 listingPrice = 0.001 ether;    
    mapping (uint256 => ListedToken) private idToToken;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _itemSold; // items sold on marketplace

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

    // function used to mint the nft
    function createNFT(string memory tokenURI, uint256 nftPrice) payable public returns(uint256){
        require(msg.value == listingPrice, "Listing Price For NFT is 0.01 ETH");
        require(nftPrice>0,"NFT Price should be greater than 0");
        
        _tokenIds.increment(); // our NFT ID starts with "1"
        uint256 currentId = getCurrentTokenId();

        _safeMint(msg.sender, currentId);
        _setTokenURI(currentId, tokenURI);
        _createListedToken(currentId, nftPrice);
        
        return currentId;
    }

    function _createListedToken(uint256 id, uint256 nftPrice) private {
        idToToken[id] = ListedToken ({
            tokenID:id,
            owner:payable(address(this)),
            seller:payable(msg.sender),
            price:nftPrice,
            isCurrentlyListed:true
        });
        
        _transfer(msg.sender, address(this), id);
    }

    // get all nfts
    function getAllNFTs() public returns(ListedToken[] memory) {
        uint256 totalIds = _tokenIds.current();
        ListedToken[] memory tokenArr = new ListedToken[](totalIds); // creating new array for storing all tokens so far
        
        for(uint256 index=1; index<=totalIds; index++){
            ListedToken memory token = idToToken[index];
            tokenArr[index] = token;
        }

        return tokenArr;
    }

    // function to fetch NFT as per user
    function getNFTByUser() public view returns(ListedToken[] memory){
        uint256 currentId = _tokenIds.current();
        ListedToken[] memory nftArr = new ListedToken[](currentId);
        for(uint256 index = 1; index<=currentId; index++){
            ListedToken memory token = idToToken[index];
            if(token.seller == msg.sender || token.owner == msg.sender){
                nftArr[index] = token;
            }
        }
        return nftArr;
    }

    // function to execute sale for nft. It expects ETH because if you dont send ETH, tx will not be processed
    function executeSale(uint256 tokenId) public payable{
        uint256 priceNft = idToToken[tokenId].price;
        require(priceNft == msg.value, "Price Needs To Match The Listed Price");
        address oldSeller = idToToken[tokenId].seller;
        address ownerNFT = idToToken[tokenId].owner;

        idToToken[tokenId].seller = payable(msg.sender);
        _itemSold.increment();
        _transfer(address(this), msg.sender, tokenId);
        approve(address(this), tokenId);

        // payable(owner).transfer(listingPrice);
        (bool success, ) = payable(ownerNFT).call{value:msg.value}("");
        require(success,"Sending Ether To Owner Failed");
        
        (bool flag,) = payable(oldSeller).call{value:msg.value}("");
        require(flag,"Sending Ether To Seller Failed");
    }

    // function to fetch listing price on marketplace
    function getListingPrice() public view returns(uint256) {
        return listingPrice;
    }

    // function to fetch latest Listed token based on token id
    function getLatestTokenById() public view returns(ListedToken memory){
        uint256 tId = _tokenIds.current();
        return idToToken[tId];
    }

    // function to fetch Listed token based on token id
    function getTokenById(uint256 tokenId) public view returns(ListedToken memory){
        return idToToken[tokenId];
    }

    // function to fetch current token id 
    function getCurrentTokenId() public view returns(uint256){
        return _tokenIds.current();
    }
}