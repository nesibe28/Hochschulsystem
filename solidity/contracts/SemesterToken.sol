//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";, Ownable

contract SemesterToken is ERC721 {

    uint256 public mintPrice = 0.05 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping (address => uint256) public mintedWallets;

    constructor() payable ERC721("Semester Registration", "SR") {
        maxSupply = 2;
    }
/*
    function toggleIsMintEnabled() external {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 _maxSupply) external {
        maxSupply = _maxSupply;
    }*/

    function pay(address _from, uint256 _tokenID) external payable{
        //require(mintedWallets[msg.sender] < 1, "exceeds max per wallet");
        //require(maxSupply > totalSupply, "sold out");
        //mintedWallets[msg.sender]++;
        //totalSupply++;
        //uint256 tokenId = totalSupply;
        _safeMint(_from, _tokenID);
        //return (_tokenID);
    }

}