// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

interface IAvatars is IERC1155 {
    function createAvatar() external;
    function addAttachment(uint avatarId, string memory attachmentName, uint attachmentId) external;
    function removeAttachment(uint avatarId, string memory attachmentName, uint attachmentId) external;
    function buyAttachment(string memory attachmentName, uint attachmentId) external;
    function sellAttachment(string memory attachmentName, uint attachmentId) external;

    event AvatarCreated(address indexed owner, uint avatarId);
    event AttachmentAdded(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);
    event AttachmentRemoved(address indexed updater, uint avatarId, string attachmentName, uint attachmentId);
}