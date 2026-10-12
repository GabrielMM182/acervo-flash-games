import { readFileSync, writeFileSync } from "node:fs";
import { deflateSync, inflateSync } from "node:zlib";

const TAG_DEFINE_SPRITE = 39;
const TAG_DO_ACTION = 12;
const TARGET_SPRITE_ID = 686;
const TARGET_FUNCTION = "enemyBrain";

const OP_DEFINE_FUNCTION = 0x9b;
const OP_ADD2 = 0x47;
const OP_LESS2 = 0x48;
const OP_NOT = 0x12;
const OP_IF = 0x9d;
const OP_POP = 0x17;
const OP_JUMP = 0x99;

const [inputPath, outputPath] = process.argv.slice(2);
if (!inputPath || !outputPath) {
  console.error("Usage: node patch-god-mode.mjs <input.swf> <output.swf>");
  process.exit(1);
}

const raw = readFileSync(inputPath);
if (raw.toString("latin1", 0, 3) !== "CWS") throw new Error("Expected a zlib-compressed (CWS) SWF");
const body = Buffer.from(inflateSync(raw.subarray(8)));

const readTagHeader = (buf, at) => {
  const header = buf.readUInt16LE(at);
  let length = header & 0x3f;
  let dataStart = at + 2;
  if (length === 0x3f) {
    length = buf.readUInt32LE(dataStart);
    dataStart += 4;
  }
  return { code: header >> 6, dataStart, dataEnd: dataStart + length };
};

const listTags = (buf, start, end) => {
  const tags = [];
  let at = start;
  while (at < end) {
    const tag = readTagHeader(buf, at);
    tags.push(tag);
    if (tag.code === 0) break;
    at = tag.dataEnd;
  }
  return tags;
};

const readCString = (buf, at) => {
  let end = at;
  while (buf[end] !== 0) end++;
  return buf.toString("latin1", at, end);
};

const listActions = (buf, start, end) => {
  const actions = [];
  let at = start;
  while (at < end && buf[at] !== 0) {
    const code = buf[at];
    const length = code >= 0x80 ? buf.readUInt16LE(at + 1) : 0;
    const dataStart = at + (code >= 0x80 ? 3 : 1);
    actions.push({ code, offset: at, dataStart, dataEnd: dataStart + length });
    at = dataStart + length;
  }
  return actions;
};

const findFunctionBody = (doActions, name) => {
  for (const tag of doActions) {
    const fn = listActions(body, tag.dataStart, tag.dataEnd)
      .find((a) => a.code === OP_DEFINE_FUNCTION && readCString(body, a.dataStart) === name);
    if (fn) {
      const codeSize = body.readUInt16LE(fn.dataEnd - 2);
      return { start: fn.dataEnd, end: fn.dataEnd + codeSize };
    }
  }
  throw new Error(`Function ${name} not found`);
};

const nBits = body[0] >> 3;
const firstTag = Math.ceil((5 + nBits * 4) / 8) + 4;
const sprite = listTags(body, firstTag, body.length)
  .find((t) => t.code === TAG_DEFINE_SPRITE && body.readUInt16LE(t.dataStart) === TARGET_SPRITE_ID);
if (!sprite) throw new Error(`Sprite ${TARGET_SPRITE_ID} not found`);
const doActions = listTags(body, sprite.dataStart + 4, sprite.dataEnd).filter((t) => t.code === TAG_DO_ACTION);
const fnBody = findFunctionBody(doActions, TARGET_FUNCTION);
const fnActions = listActions(body, fnBody.start, fnBody.end);

const matches = fnActions
  .map((action, i) => ({ action, i }))
  .filter(({ i }) => {
    const [add, less, not, branch] = fnActions.slice(i, i + 4);
    return add?.code === OP_ADD2 && less?.code === OP_LESS2 && not?.code === OP_NOT && branch?.code === OP_IF;
  });

if (matches.length !== 1) throw new Error(`Expected exactly one collision check, found ${matches.length}`);

const [, less, not, branch] = fnActions.slice(matches[0].i, matches[0].i + 4);
body[less.offset] = OP_POP;
body[not.offset] = OP_POP;
body[branch.offset] = OP_JUMP;

const header = Buffer.alloc(8);
header.write("CWS", 0, "latin1");
header[3] = raw[3];
header.writeUInt32LE(body.length + 8, 4);
writeFileSync(outputPath, Buffer.concat([header, deflateSync(body, { level: 9 })]));
console.log(`Patched ${TARGET_FUNCTION} collision check at body offset 0x${less.offset.toString(16)} -> ${outputPath}`);
