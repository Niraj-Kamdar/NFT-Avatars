// THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.

import {
  TypedMap,
  Entity,
  Value,
  ValueKind,
  store,
  Address,
  Bytes,
  BigInt,
  BigDecimal
} from "@graphprotocol/graph-ts";

export class Avatar extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id !== null, "Cannot save Avatar entity without an ID");
    assert(
      id.kind == ValueKind.STRING,
      "Cannot save Avatar entity with non-string ID. " +
        'Considering using .toHex() to convert the "id" to a string.'
    );
    store.set("Avatar", id.toString(), this);
  }

  static load(id: string): Avatar | null {
    return store.get("Avatar", id) as Avatar | null;
  }

  get id(): string {
    let value = this.get("id");
    return value.toString();
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get owner(): Bytes {
    let value = this.get("owner");
    return value.toBytes();
  }

  set owner(value: Bytes) {
    this.set("owner", Value.fromBytes(value));
  }

  get imageUrl(): string {
    let value = this.get("imageUrl");
    return value.toString();
  }

  set imageUrl(value: string) {
    this.set("imageUrl", Value.fromString(value));
  }

  get attachments(): Array<string> | null {
    let value = this.get("attachments");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toStringArray();
    }
  }

  set attachments(value: Array<string> | null) {
    if (value === null) {
      this.unset("attachments");
    } else {
      this.set("attachments", Value.fromStringArray(value as Array<string>));
    }
  }
}

export class Attachment extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id !== null, "Cannot save Attachment entity without an ID");
    assert(
      id.kind == ValueKind.STRING,
      "Cannot save Attachment entity with non-string ID. " +
        'Considering using .toHex() to convert the "id" to a string.'
    );
    store.set("Attachment", id.toString(), this);
  }

  static load(id: string): Attachment | null {
    return store.get("Attachment", id) as Attachment | null;
  }

  get id(): string {
    let value = this.get("id");
    return value.toString();
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get tokenId(): BigInt {
    let value = this.get("tokenId");
    return value.toBigInt();
  }

  set tokenId(value: BigInt) {
    this.set("tokenId", Value.fromBigInt(value));
  }

  get type(): string {
    let value = this.get("type");
    return value.toString();
  }

  set type(value: string) {
    this.set("type", Value.fromString(value));
  }

  get value(): string {
    let value = this.get("value");
    return value.toString();
  }

  set value(value: string) {
    this.set("value", Value.fromString(value));
  }

  get avatar(): string | null {
    let value = this.get("avatar");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toString();
    }
  }

  set avatar(value: string | null) {
    if (value === null) {
      this.unset("avatar");
    } else {
      this.set("avatar", Value.fromString(value as string));
    }
  }
}
