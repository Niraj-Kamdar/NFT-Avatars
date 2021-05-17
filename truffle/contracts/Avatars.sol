// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

// Chainlink random number haven't implemented because of some limitations.
contract Avatars is ERC1155, IERC1155Receiver {
    uint256 public totalTokens = 0;
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public avatarCreationFee;
    uint256 public attachmentCreationFee;

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

    mapping(bytes32 => uint) public requestToToken; //request ID to token ID
    mapping(bytes32 => address) public requestToOwner; //request ID to token ID
    mapping(string => uint) public attachmentStartId;

    event AvatarCreated(address indexed owner, uint avatarId);
    event AttachmentAdded(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);
    event AttachmentRemoved(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);

    constructor() 
    ERC1155("") {
        for(uint i; i < attachments.length; i++){
            string memory attachmentName = attachments[i];
            attachmentStartId[attachmentName] = totalTokens;
            totalTokens += totalAttachments[i];
        }
    }

    function createAvatar() public {
        uint tokenId = totalTokens;
        _mint(_msgSender(), tokenId, 1, "");
        emit AvatarCreated(_msgSender(), tokenId);
        totalTokens++;
    }

    /**
     * Function for updating the avatar.
     * attachmentId will be enum from the attachment enum.
     * todo: This isn't non-custodial figure out a way to make it non-custodial
     * Some custom modification to ERC1155 may help.
     * NFTs won't get locked on contract forever since owner can remove attachment anytime.
     */
    function addAttachment(uint avatarId, string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        safeTransferFrom(_msgSender(), address(this), tokenId, 1, "");
        emit AttachmentAdded(_msgSender(), avatarId, attachmentName, tokenId);
    }

    function removeAttachment(uint avatarId, string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        safeTransferFrom(address(this), _msgSender(), tokenId, 1, "");
        emit AttachmentRemoved(_msgSender(), avatarId, attachmentName, tokenId);
    }

    function buyAttachment(string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        _mint(_msgSender(), tokenId, 1, "");
    }

    function sellAttachment(string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        _burn(_msgSender(), tokenId, 1);
    }

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
    external
    override
    returns(bytes4){
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    )
    external
    override
    returns(bytes4){
        return bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"));
    }
}