// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Chainlink random number haven't implemented because of some limitations.
contract Avatars is ERC1155, Ownable {
    uint256 public avatarCreationFee;
    uint256 public attachmentCreationFee;
    mapping(address => mapping(uint => uint)) public attachmentInUse; // owner => tokenId => no. of attachment attached to avatars

    string[] public attachments = [
        "accessories", 
        "accessoriesColor", 
        "clotheGraphics", 
        "clothes", 
        "clothesColor", 
        "eyebrow", 
        "eyes", 
        "facialHair", 
        "facialHairColor", 
        "hairColor", 
        "hatColor", 
        "mouth", 
        "skin", 
        "top"
    ];

    uint[] public totalAttachments = [6, 18, 10, 12, 18, 18, 14, 10, 12, 12, 18, 12, 7, 37];

    uint public TRANSFORMIUM = 0;
    uint256 public totalTokens = 1;

    mapping(bytes32 => uint) public requestToToken; //request ID to token ID
    mapping(bytes32 => address) public requestToOwner; //request ID to token ID
    mapping(string => uint) public attachmentStartId;

    // event AvatarCreated(address indexed owner, uint avatarId);
    event AttachmentAdded(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);
    event AttachmentRemoved(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);

    constructor(uint _avatarCreationFee, uint _attachmentCreationFee) 
    ERC1155("") {
        avatarCreationFee = _avatarCreationFee;
        attachmentCreationFee = _attachmentCreationFee;
        for(uint i; i < attachments.length; i++){
            string memory attachmentName = attachments[i];
            attachmentStartId[attachmentName] = totalTokens;
            totalTokens += totalAttachments[i];
        }
        _mint(_msgSender(), TRANSFORMIUM, 10**12, "");
    }

    function setAvatarCreationFee(uint fee) public onlyOwner {
        avatarCreationFee = fee;
    }

    function setAttachmentCreationFee(uint fee) public onlyOwner {
        attachmentCreationFee = fee;
    }

    function createAvatar() external {
        uint tokenId = totalTokens;
        _burn(_msgSender(), TRANSFORMIUM, avatarCreationFee);
        _mint(_msgSender(), tokenId, 1, "");
        // emit AvatarCreated(_msgSender(), tokenId);
        totalTokens++;
    }

    function addAttachment(uint avatarId, string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        attachmentInUse[_msgSender()][tokenId] += 1;
        // safeTransferFrom(_msgSender(), address(this), tokenId, 1, "");
        emit AttachmentAdded(_msgSender(), avatarId, attachmentName, tokenId);
    }

    function removeAttachment(uint avatarId, string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        attachmentInUse[_msgSender()][tokenId] -= 1;
        // safeTransferFrom(address(this), _msgSender(), tokenId, 1, "");
        emit AttachmentRemoved(_msgSender(), avatarId, attachmentName, tokenId);
    }

    function buyAttachment(string memory attachmentName, uint attachmentId) external {
        _burn(_msgSender(), TRANSFORMIUM, attachmentCreationFee);
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        _mint(_msgSender(), tokenId, 1, "");
    }

    function sellAttachment(string memory attachmentName, uint attachmentId) external {
        _mint(_msgSender(), TRANSFORMIUM, attachmentCreationFee, "");
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        _burn(_msgSender(), tokenId, 1);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    )
        public
        override
    {
        require(balanceOf(from, id) - attachmentInUse[from][id] >= amount, "Avatars: Insufficient tokens");
        super.safeTransferFrom(from, to, id, amount, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    )
        public
        virtual
        override
    {
        for (uint256 i = 0; i < ids.length; ++i) {
            require(balanceOf(from, ids[i]) - attachmentInUse[from][ids[i]] >= amounts[i], "Avatars: Insufficient tokens");
        }
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }
}