// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
// import "@chainlink/contracts/src/v0.8/dev/VRFConsumerBase.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// Chainlink random number haven't implemented because of some limitations.
contract Avatars is ERC1155, IERC1155Receiver {
    uint256 public constant TRANSFORMIUM = 0;
    uint256 public totalTokens = 1;
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public avatarCreationFee;
    uint256 public attachmentCreationFee;

    string[] public attachments = [
        "Accessories", 
        "AccessoriesColor", 
        "ClotheGraphics", 
        "Clothes", 
        "ClothesColor", 
        "Eyebrow", 
        "Eyes", 
        "FacialHair", 
        "FacialHairColor", 
        "HairColor", 
        "HatColor", 
        "Mouth", 
        "Skin", 
        "Top"
    ];

    uint[] public totalAttachments = [6, 18, 10, 12, 18, 18, 14, 10, 12, 12, 18, 12, 7, 37];

    mapping(bytes32 => uint) public requestToToken; //request ID to token ID
    mapping(bytes32 => address) public requestToOwner; //request ID to token ID
    mapping(string => uint) public attachmentStartId;

    event AvatarCreated(address indexed owner, uint avatarId);
    event AttachmentAdded(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);
    event AttachmentRemoved(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);

    /**
     * Constructor inherits VRFConsumerBase
     * 
     * Network: Kovan
     * Chainlink VRF Coordinator address: 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9
     * LINK token address:                0xa36085F69e2889c224210F603D836748e7dC0088
     * Key Hash: 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4
     */

    constructor() 
    ERC1155("")
    // VRFConsumerBase(
    //     0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9, // VRF Coordinator
    //     0xa36085F69e2889c224210F603D836748e7dC0088  // LINK Token
    // ){
    //     keyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
    //     fee = 0.1 * 10 ** 18;
    {
        // 0.1 LINK (varies by network)
        // Free for demo though!
        // avatarCreationFee = 1000; // 1000 Transformium
        // attachmentCreationFee = 100; // 100 Transformium
        // _mint(_msgSender(), TRANSFORMIUM, 10**10, "");

        for(uint i; i < attachments.length; i++){
            string memory attachmentName = attachments[i];
            attachmentStartId[attachmentName] = totalTokens;
            totalTokens += totalAttachments[i];
        }
    }

    // function createAvatar() public returns (bytes32 requestId)
    function createAvatar() public {
        // require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        // safeTransferFrom(_msgSender(), owner(), TRANSFORMIUM, avatarCreationFee, "");
        uint tokenId = totalTokens;
        // requestToToken[requestId] = tokenId;
        // requestToOwner[requestId] = _msgSender();
        _mint(_msgSender(), tokenId, 1, "");
        emit AvatarCreated(_msgSender(), tokenId);
        totalTokens++;
        // return requestRandomness(keyHash, fee, block.number);
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
        // safeTransferFrom(_msgSender(), address(this), TRANSFORMIUM, attachmentCreationFee, "");
        _mint(_msgSender(), tokenId, 1, "");
    }

    function sellAttachment(string memory attachmentName, uint attachmentId) external {
        uint tokenId = attachmentStartId[attachmentName] + attachmentId;
        // safeTransferFrom(address(this), _msgSender(), TRANSFORMIUM, attachmentCreationFee, "");
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

    /**
     * Callback function used by VRF Coordinator
     */
    // function fulfillRandomness(bytes32 requestId, uint256 random) internal override {
    //     uint tokenId = requestToToken[requestId];
    //     address receiver = requestToOwner[requestId];
    // }
}