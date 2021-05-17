import { AvatarCreated, AttachmentAdded } from '../generated/Avatars/Avatars'
import { Avatar, Attachment } from '../generated/schema'
import { AttachmentMap } from './utils'

const API_URL = "https://avatars.dicebear.com/api/avataaars/"

export function handleAvatarCreated(event: AvatarCreated): void {
  let avatar = new Avatar(event.params.avatarId.toHex())
  avatar.owner = event.params.owner
  avatar.imageUrl = API_URL + avatar.id + ".svg"
  avatar.save()
}

export function handleAttachmentAdded(event: AttachmentAdded): void {
  let avatarId = event.params.avatarId.toHex()
  let avatar = Avatar.load(avatarId)
  if (avatar == null) return

  let attachmentId = event.params.attachmentId
  let attachment = new Attachment(avatarId + "-" + attachmentId.toHex())
  attachment.type = event.params.attachmentName
  attachment.tokenId = event.params.attachmentId
  attachment.value = AttachmentMap[attachment.tokenId.toI32()]
  attachment.avatar = avatarId
  attachment.save()

  // Change url
  // avatar.save()
}

// export function handleAttachmentRemoved(event: AttachmentRemoved): void {
//   let avatarId = event.params.avatarId.toHex()
//   let avatar = Avatar.load(avatarId)
//   if (avatar == null) return

//   let attachmentId = event.params.attachmentId.toHex()
//   let attachment = new Attachment(avatarId + "-" + attachmentId.toHex())
//   attachment.type = event.params.attachmentName
//   attachment.tokenId = event.params.attachmentId
//   attachment.value = AttachmentMap[tokenId]
//   attachment.avatar = null
//   attachment.save()
// }