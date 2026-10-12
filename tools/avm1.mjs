import { readFileSync, writeFileSync } from "node:fs";
import { deflateSync, inflateSync } from "node:zlib";

const TAG = {
  END: 0,
  DEFINE_BUTTON: 7,
  DO_ACTION: 12,
  PLACE_OBJECT2: 26,
  DEFINE_BUTTON2: 34,
  DEFINE_SPRITE: 39,
  DO_INIT_ACTION: 59,
  PLACE_OBJECT3: 70,
};

export const OP = {
  ADD: 0x0a, SUBTRACT: 0x0b, MULTIPLY: 0x0c, DIVIDE: 0x0d, EQUALS: 0x0e, LESS: 0x0f, AND: 0x10, OR: 0x11,
  NOT: 0x12, STRING_EQUALS: 0x13, STRING_LENGTH: 0x14, STRING_EXTRACT: 0x15, POP: 0x17, TO_INTEGER: 0x18,
  GET_VARIABLE: 0x1c, SET_VARIABLE: 0x1d, SET_TARGET2: 0x20, STRING_ADD: 0x21, GET_PROPERTY: 0x22,
  SET_PROPERTY: 0x23, CLONE_SPRITE: 0x24, REMOVE_SPRITE: 0x25, TRACE: 0x26, STRING_LESS: 0x29,
  THROW: 0x2a, CAST_OP: 0x2b, RANDOM_NUMBER: 0x30, MB_STRING_LENGTH: 0x31, CHAR_TO_ASCII: 0x32,
  ASCII_TO_CHAR: 0x33, GET_TIME: 0x34, MB_STRING_EXTRACT: 0x35, MB_CHAR_TO_ASCII: 0x36,
  MB_ASCII_TO_CHAR: 0x37, DELETE: 0x3a, DELETE2: 0x3b, DEFINE_LOCAL: 0x3c, CALL_FUNCTION: 0x3d,
  RETURN: 0x3e, MODULO: 0x3f, NEW_OBJECT: 0x40, DEFINE_LOCAL2: 0x41, INIT_ARRAY: 0x42, INIT_OBJECT: 0x43,
  TYPE_OF: 0x44, TARGET_PATH: 0x45, ADD2: 0x47, LESS2: 0x48, EQUALS2: 0x49, TO_NUMBER: 0x4a,
  TO_STRING: 0x4b, PUSH_DUPLICATE: 0x4c, STACK_SWAP: 0x4d, GET_MEMBER: 0x4e, SET_MEMBER: 0x4f,
  INCREMENT: 0x50, DECREMENT: 0x51, CALL_METHOD: 0x52, NEW_METHOD: 0x53, INSTANCE_OF: 0x54,
  BIT_AND: 0x60, BIT_OR: 0x61, BIT_XOR: 0x62, BIT_LSHIFT: 0x63, BIT_RSHIFT: 0x64, BIT_URSHIFT: 0x65,
  STRICT_EQUALS: 0x66, GREATER: 0x67, STRING_GREATER: 0x68, EXTENDS: 0x69, CONSTANT_POOL: 0x88,
  DEFINE_FUNCTION2: 0x8e, WITH: 0x94, PUSH: 0x96, JUMP: 0x99, GET_URL2: 0x9a, DEFINE_FUNCTION: 0x9b,
  IF: 0x9d, CALL: 0x9e, GOTO_FRAME2: 0x9f,
};

const BINARY_OPS = new Set([
  OP.ADD, OP.SUBTRACT, OP.MULTIPLY, OP.DIVIDE, OP.EQUALS, OP.LESS, OP.AND, OP.OR, OP.STRING_EQUALS,
  OP.STRING_ADD, OP.STRING_LESS, OP.MODULO, OP.ADD2, OP.LESS2, OP.EQUALS2, OP.INSTANCE_OF, OP.BIT_AND,
  OP.BIT_OR, OP.BIT_XOR, OP.BIT_LSHIFT, OP.BIT_RSHIFT, OP.BIT_URSHIFT, OP.STRICT_EQUALS, OP.GREATER,
  OP.STRING_GREATER, OP.GET_PROPERTY, OP.DELETE, OP.CAST_OP,
]);
const UNARY_OPS = new Set([
  OP.NOT, OP.STRING_LENGTH, OP.TO_INTEGER, OP.RANDOM_NUMBER, OP.MB_STRING_LENGTH, OP.CHAR_TO_ASCII,
  OP.ASCII_TO_CHAR, OP.MB_CHAR_TO_ASCII, OP.MB_ASCII_TO_CHAR, OP.TYPE_OF, OP.TARGET_PATH, OP.TO_NUMBER,
  OP.TO_STRING, OP.INCREMENT, OP.DECREMENT, OP.DELETE2,
]);
const POP_ONLY = new Map([
  [OP.POP, 1], [OP.SET_VARIABLE, 2], [OP.SET_TARGET2, 1], [OP.SET_PROPERTY, 3], [OP.CLONE_SPRITE, 3],
  [OP.REMOVE_SPRITE, 1], [OP.TRACE, 1], [OP.THROW, 1], [OP.DEFINE_LOCAL, 2], [OP.DEFINE_LOCAL2, 1],
  [OP.RETURN, 1], [OP.EXTENDS, 2], [OP.GET_URL2, 2], [OP.CALL, 1], [OP.GOTO_FRAME2, 1], [OP.WITH, 1],
]);
const NO_STACK_EFFECT = new Set([0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x28, 0x81, 0x83, 0x87, 0x8b, 0x8c]);

export const loadSwf = (path) => {
  const raw = readFileSync(path);
  const signature = raw.toString("latin1", 0, 3);
  if (signature === "ZWS") throw new Error("LZMA-compressed SWF is not supported");
  const body = Buffer.from(signature === "CWS" ? inflateSync(raw.subarray(8)) : raw.subarray(8));
  return { signature, version: raw[3], body };
};

export const saveSwf = (path, { signature, version, body }) => {
  const header = Buffer.alloc(8);
  header.write(signature, 0, "latin1");
  header[3] = version;
  header.writeUInt32LE(body.length + 8, 4);
  writeFileSync(path, Buffer.concat([header, signature === "CWS" ? deflateSync(body, { level: 9 }) : body]));
};

class BitReader {
  constructor(buf, at) {
    this.buf = buf;
    this.bit = at * 8;
  }
  read(n) {
    let value = 0;
    for (let i = 0; i < n; i++) {
      value = (value << 1) | ((this.buf[this.bit >> 3] >> (7 - (this.bit & 7))) & 1);
      this.bit++;
    }
    return value;
  }
  get byteOffset() {
    return Math.ceil(this.bit / 8);
  }
}

const skipMatrix = (buf, at) => {
  const bits = new BitReader(buf, at);
  if (bits.read(1)) bits.read(bits.read(5) * 2);
  if (bits.read(1)) bits.read(bits.read(5) * 2);
  bits.read(bits.read(5) * 2);
  return bits.byteOffset;
};

const skipColorTransformWithAlpha = (buf, at) => {
  const bits = new BitReader(buf, at);
  const hasAdd = bits.read(1);
  const hasMult = bits.read(1);
  const n = bits.read(4);
  bits.read(n * 4 * (hasAdd + hasMult));
  return bits.byteOffset;
};

const readCString = (buf, at) => {
  let end = at;
  while (buf[end] !== 0) end++;
  return { value: buf.toString("latin1", at, end), next: end + 1 };
};

const readTagHeader = (buf, at) => {
  const header = buf.readUInt16LE(at);
  let length = header & 0x3f;
  let dataStart = at + 2;
  if (length === 0x3f) {
    length = buf.readUInt32LE(dataStart);
    dataStart += 4;
  }
  return { code: header >> 6, dataStart, dataEnd: dataStart + length, next: dataStart + length };
};

const clipActionBlocks = (buf, at, end, version, location) => {
  const blocks = [];
  const flagBytes = version >= 6 ? 4 : 2;
  let p = at + 2 + flagBytes;
  while (p < end) {
    const flags = flagBytes === 4 ? buf.readUInt32LE(p) : buf.readUInt16LE(p);
    p += flagBytes;
    if (flags === 0) break;
    const size = buf.readUInt32LE(p);
    p += 4;
    const keyPress = flagBytes === 4 && (flags >>> 16) & 0x02 ? 1 : 0;
    blocks.push({ start: p + keyPress, end: p + size, location: `${location} clip-event 0x${flags.toString(16)}` });
    p += size;
  }
  return blocks;
};

const placeObject2Blocks = (buf, tag, version, location) => {
  const flags = buf[tag.dataStart];
  if (!(flags & 0x80)) return [];
  let p = tag.dataStart + 3;
  if (flags & 0x02) p += 2;
  if (flags & 0x04) p = skipMatrix(buf, p);
  if (flags & 0x08) p = skipColorTransformWithAlpha(buf, p);
  if (flags & 0x10) p += 2;
  if (flags & 0x20) p = readCString(buf, p).next;
  if (flags & 0x40) p += 2;
  return clipActionBlocks(buf, p, tag.dataEnd, version, location);
};

const button2Blocks = (buf, tag, location) => {
  const offsetField = tag.dataStart + 3;
  const actionOffset = buf.readUInt16LE(offsetField);
  if (!actionOffset) return [];
  const blocks = [];
  let p = offsetField + actionOffset;
  while (p < tag.dataEnd) {
    const size = buf.readUInt16LE(p);
    const conditions = buf.readUInt16LE(p + 2);
    blocks.push({ start: p + 4, end: size ? p + size : tag.dataEnd, location: `${location} button-cond 0x${conditions.toString(16)}` });
    if (!size) break;
    p += size;
  }
  return blocks;
};

export const listActionBlocks = ({ body, version }) => {
  const blocks = [];
  const skipped = [];
  const walk = (start, end, owner) => {
    let p = start;
    let frame = 1;
    while (p < end) {
      const tag = readTagHeader(body, p);
      const location = `${owner} frame ${frame}`;
      if (tag.code === 1) frame++;
      else if (tag.code === TAG.DO_ACTION) blocks.push({ start: tag.dataStart, end: tag.dataEnd, location: `${location} DoAction` });
      else if (tag.code === TAG.DO_INIT_ACTION) blocks.push({ start: tag.dataStart + 2, end: tag.dataEnd, location: `${location} DoInitAction` });
      else if (tag.code === TAG.PLACE_OBJECT2) blocks.push(...placeObject2Blocks(body, tag, version, `${location} PlaceObject2`));
      else if (tag.code === TAG.DEFINE_BUTTON2) blocks.push(...button2Blocks(body, tag, `button ${body.readUInt16LE(tag.dataStart)}`));
      else if (tag.code === TAG.PLACE_OBJECT3 && body[tag.dataStart] & 0x80) skipped.push(`${location} PlaceObject3`);
      else if (tag.code === TAG.DEFINE_BUTTON) skipped.push(`button ${body.readUInt16LE(tag.dataStart)} (DefineButton)`);
      else if (tag.code === TAG.DEFINE_SPRITE) walk(tag.dataStart + 4, tag.dataEnd, `sprite ${body.readUInt16LE(tag.dataStart)}`);
      p = tag.next;
      if (tag.code === TAG.END) break;
    }
  };
  const nBits = body[0] >> 3;
  walk(Math.ceil((5 + nBits * 4) / 8) + 4, body.length, "root");
  return { blocks, skipped };
};

const decodePushValues = (buf, start, end, pool) => {
  const values = [];
  let p = start;
  while (p < end) {
    const type = buf[p++];
    const valueOffset = p;
    if (type === 0) {
      const { value, next } = readCString(buf, p);
      values.push({ kind: "lit", value });
      p = next;
    } else if (type === 1) {
      values.push({ kind: "lit", value: buf.readFloatLE(p), numberType: type, valueOffset });
      p += 4;
    } else if (type === 6) {
      const swapped = Buffer.concat([buf.subarray(p + 4, p + 8), buf.subarray(p, p + 4)]);
      values.push({ kind: "lit", value: swapped.readDoubleLE(0), numberType: type, valueOffset });
      p += 8;
    } else if (type === 7) {
      values.push({ kind: "lit", value: buf.readInt32LE(p), numberType: type, valueOffset });
      p += 4;
    } else if (type === 8) {
      values.push({ kind: "lit", value: pool[buf[p]] });
      p += 1;
    } else if (type === 9) {
      values.push({ kind: "lit", value: pool[buf.readUInt16LE(p)] });
      p += 2;
    } else if (type === 4) {
      values.push({ kind: "register", index: buf[p] });
      p += 1;
    } else if (type === 5) {
      values.push({ kind: "lit", value: Boolean(buf[p]) });
      p += 1;
    } else if (type === 2 || type === 3) {
      values.push({ kind: "lit", value: type === 2 ? null : undefined });
    } else break;
  }
  return values;
};

export const writeNumberLiteral = (buf, literal, value) => {
  if (literal.numberType === 7) buf.writeInt32LE(value, literal.valueOffset);
  else if (literal.numberType === 1) buf.writeFloatLE(value, literal.valueOffset);
  else if (literal.numberType === 6) {
    const tmp = Buffer.alloc(8);
    tmp.writeDoubleLE(value, 0);
    tmp.copy(buf, literal.valueOffset, 4, 8);
    tmp.copy(buf, literal.valueOffset + 4, 0, 4);
  } else throw new Error("Literal is not a number");
};

const PRELOAD_ORDER = [
  { flag: 0x0001, name: "this" },
  { flag: 0x0004, name: "arguments" },
  { flag: 0x0010, name: "super" },
  { flag: 0x0040, name: "_root" },
  { flag: 0x0080, name: "_parent" },
  { flag: 0x0100, name: "_global" },
];

const readFunction2Scope = (buf, dataStart, dataEnd) => {
  let q = readCString(buf, dataStart).next;
  const paramCount = buf.readUInt16LE(q);
  const flags = buf.readUInt16LE(q + 3);
  q += 5;
  const registers = new Map();
  let next = 1;
  for (const { flag, name } of PRELOAD_ORDER) if (flags & flag) registers.set(next++, name);
  for (let i = 0; i < paramCount; i++) {
    const register = buf[q];
    const { value, next: after } = readCString(buf, q + 1);
    if (register) registers.set(register, value);
    q = after;
  }
  return { end: dataEnd + buf.readUInt16LE(q), registers };
};

export const simulateBlock = (buf, block, onStore) => {
  let pool = [];
  let stack = [];
  const scopes = [];
  const unknown = { kind: "unknown" };
  const pop = () => stack.pop() ?? unknown;
  const popCount = () => {
    const n = pop();
    return n.kind === "lit" && Number.isInteger(n.value) ? n.value : null;
  };
  const resolveRegister = (value) => {
    if (value.kind !== "register") return value;
    const name = scopes.at(-1)?.registers.get(value.index);
    return name ? { kind: "var", name } : value;
  };
  let p = block.start;
  while (p < block.end) {
    while (scopes.length && scopes.at(-1).end <= p) scopes.pop();
    const code = buf[p];
    if (code === 0) break;
    const offset = p;
    const length = code >= 0x80 ? buf.readUInt16LE(p + 1) : 0;
    const dataStart = p + (code >= 0x80 ? 3 : 1);
    const dataEnd = dataStart + length;
    p = dataEnd;

    if (code === OP.DEFINE_FUNCTION2) scopes.push(readFunction2Scope(buf, dataStart, dataEnd));

    if (code === OP.CONSTANT_POOL) {
      pool = [];
      let q = dataStart + 2;
      for (let i = 0; i < buf.readUInt16LE(dataStart); i++) {
        const { value, next } = readCString(buf, q);
        pool.push(value);
        q = next;
      }
    } else if (code === OP.PUSH) stack.push(...decodePushValues(buf, dataStart, dataEnd, pool).map(resolveRegister));
    else if (code === OP.GET_VARIABLE) {
      const name = pop();
      stack.push({ kind: "var", name: name.value });
    } else if (code === OP.GET_MEMBER) {
      const name = pop();
      const obj = pop();
      stack.push({ kind: "member", obj, name: name.value });
    } else if (code === OP.SET_MEMBER) {
      const value = pop();
      const name = pop();
      const obj = pop();
      onStore({ target: { kind: "member", obj, name: name.value }, value, offset, location: block.location });
    } else if (code === OP.SET_VARIABLE) {
      const value = pop();
      const name = pop();
      onStore({ target: { kind: "var", name: name.value }, value, offset, location: block.location });
    } else if (BINARY_OPS.has(code)) {
      const right = pop();
      const left = pop();
      stack.push({ kind: "op", code, offset, args: [left, right] });
    } else if (UNARY_OPS.has(code)) stack.push({ kind: "op", code, offset, args: [pop()] });
    else if (POP_ONLY.has(code)) for (let i = 0; i < POP_ONLY.get(code); i++) pop();
    else if (code === OP.PUSH_DUPLICATE) {
      const top = pop();
      stack.push(top, top);
    } else if (code === OP.STACK_SWAP) {
      const a = pop();
      const b = pop();
      stack.push(a, b);
    } else if (code === OP.STRING_EXTRACT || code === OP.MB_STRING_EXTRACT) {
      pop(); pop(); pop();
      stack.push(unknown);
    } else if (code === OP.GET_TIME) stack.push(unknown);
    else if (code === OP.CALL_FUNCTION || code === OP.NEW_OBJECT) {
      pop();
      const n = popCount();
      if (n === null) stack = [];
      else {
        for (let i = 0; i < n; i++) pop();
        stack.push(unknown);
      }
    } else if (code === OP.CALL_METHOD || code === OP.NEW_METHOD) {
      pop(); pop();
      const n = popCount();
      if (n === null) stack = [];
      else {
        for (let i = 0; i < n; i++) pop();
        stack.push(unknown);
      }
    } else if (code === OP.INIT_ARRAY || code === OP.INIT_OBJECT) {
      const n = popCount();
      if (n === null) stack = [];
      else {
        for (let i = 0; i < n * (code === OP.INIT_OBJECT ? 2 : 1); i++) pop();
        stack.push(unknown);
      }
    } else if (code === OP.IF) {
      pop();
      stack = [];
    } else if (code === OP.JUMP || code === OP.DEFINE_FUNCTION || code === OP.DEFINE_FUNCTION2) {
      stack = [];
    } else if (!NO_STACK_EFFECT.has(code)) stack = [];
  }
};

export const listInstructions = (buf, block) => {
  const instructions = [];
  let pool = [];
  let p = block.start;
  while (p < block.end && buf[p] !== 0) {
    const code = buf[p];
    const length = code >= 0x80 ? buf.readUInt16LE(p + 1) : 0;
    const dataStart = p + (code >= 0x80 ? 3 : 1);
    const dataEnd = dataStart + length;
    if (code === OP.CONSTANT_POOL) {
      pool = [];
      let q = dataStart + 2;
      for (let i = 0; i < buf.readUInt16LE(dataStart); i++) {
        const { value, next } = readCString(buf, q);
        pool.push(value);
        q = next;
      }
    }
    const values = code === OP.PUSH ? decodePushValues(buf, dataStart, dataEnd, pool) : undefined;
    instructions.push({ code, offset: p, dataStart, dataEnd, values });
    p = dataEnd;
  }
  return instructions;
};

export const findSequences = (swf, matcher) => {
  const matches = [];
  for (const block of listActionBlocks(swf).blocks) {
    const instructions = listInstructions(swf.body, block);
    instructions.forEach((_, i) => {
      const match = matcher(instructions, i);
      if (match) matches.push({ ...match, location: block.location });
    });
  }
  return matches;
};

export const isRootMember = (node, name) =>
  node?.kind === "member" && node.name === name && node.obj.kind === "var" && node.obj.name === "_root";

export const countChangedBytes = (a, b) => {
  let changed = 0;
  for (let i = 0; i < a.length; i++) if (a[i] !== b[i]) changed++;
  return changed;
};
