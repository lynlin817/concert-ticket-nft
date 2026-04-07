// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ConcertTicketNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    mapping(uint256 => bool) public used;

    constructor() ERC721("Concert Ticket NFT", "CTIX") Ownable(msg.sender) {}

    function mintTicket(address to, string memory metadataURI) public onlyOwner {
        nextTokenId += 1;
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, metadataURI);
    }

    function markAsUsed(uint256 tokenId) public onlyOwner {
        require(_ownerOf(tokenId) != address(0), "Ticket does not exist");
        require(!used[tokenId], "Ticket already used");
        used[tokenId] = true;
    }
}
