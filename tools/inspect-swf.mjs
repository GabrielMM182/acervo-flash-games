import { readFileSync } from "node:fs";
import { inflateSync } from "node:zlib";

const TAG_NAMES = {
  0: "End", 1: "ShowFrame", 2: "DefineShape", 4: "PlaceObject", 5: "RemoveObject", 6: "DefineBits",
  7: "DefineButton", 8: "JPEGTables", 9: "SetBackgroundColor", 10: "DefineFont", 11: "DefineText",
  12: "DoAction", 13: "DefineFontInfo", 14: "DefineSound", 15: "StartSound", 17: "DefineButtonSound",
  18: "SoundStreamHead", 19: "SoundStreamBlock", 20: "DefineBitsLossless", 21: "DefineBitsJPEG2",
  22: "DefineShape2", 24: "Protect", 26: "PlaceObject2", 28: "RemoveObject2", 32: "DefineShape3",
  33: "DefineText2", 34: "DefineButton2", 35: "DefineBitsJPEG3", 36: "DefineBitsLossless2",
  37: "DefineEditText", 39: "DefineSprite", 41: "ProductInfo", 43: "FrameLabel", 45: "SoundStreamHead2",
  46: "DefineMorphShape", 48: "DefineFont2", 56: "ExportAssets", 57: "ImportAssets", 58: "EnableDebugger",
  59: "DoInitAction", 60: "DefineVideoStream", 61: "VideoFrame", 62: "DefineFontInfo2", 64: "EnableDebugger2",
  65: "ScriptLimits", 66: "SetTabIndex", 69: "FileAttributes", 70: "PlaceObject3", 72: "DoABC",
  77: "Metadata", 82: "DoABC2", 87: "DefineBinaryData",
};

const NETWORK_KEYWORDS = [
  "getURL", "loadMovie", "loadMovieNum", "loadVariables", "loadVariablesNum", "LoadVars", "XMLSocket",
  "sendAndLoad", "ExternalInterface", "fscommand", "navigateToURL", "LocalConnection", "SharedObject",
  "javascript:", "mailto:", "_blank", "URLRequest", "URLLoader", "Loader", "Socket", "allowDomain",
  "allowInsecureDomain", "loadPolicyFile", "MochiAd", "MochiServices", "sitelock", "Security",
];

const path = process.argv[2];
const raw = readFileSync(path);
const signature = raw.toString("latin1", 0, 3);
const version = raw[3];
const declaredLength = raw.readUInt32LE(4);

if (signature === "ZWS") {
  console.log(JSON.stringify({ signature, version, error: "LZMA-compressed SWF not supported by this script" }));
  process.exit(1);
}
const body = signature === "CWS" ? inflateSync(raw.subarray(8)) : raw.subarray(8);

let bitPos = 0;
const readBits = (n) => {
  let v = 0;
  for (let i = 0; i < n; i++) {
    const byte = body[bitPos >> 3];
    v = (v << 1) | ((byte >> (7 - (bitPos & 7))) & 1);
    bitPos++;
  }
  return v;
};
const signed = (v, n) => (v & (1 << (n - 1)) ? v - (1 << n) : v);
const nBits = readBits(5);
const rect = [readBits(nBits), readBits(nBits), readBits(nBits), readBits(nBits)].map((v) => signed(v, nBits) / 20);
let pos = Math.ceil(bitPos / 8);
const frameRate = body.readUInt16LE(pos) / 256;
const frameCount = body.readUInt16LE(pos + 2);
pos += 4;

const tagCounts = {};
const frameLabels = [];
const exports = [];
const getUrlTargets = [];
const pushedStrings = new Set();
const constantPoolStrings = new Set();
let actionBytes = 0;
let sprites = 0;

const readCString = (buf, at) => {
  let end = at;
  while (end < buf.length && buf[end] !== 0) end++;
  return [buf.toString("latin1", at, end), end + 1];
};

const parseActions = (buf, start, end) => {
  let p = start;
  while (p < end) {
    const code = buf[p++];
    if (code === 0) continue;
    if (code < 0x80) continue;
    const len = buf.readUInt16LE(p);
    p += 2;
    const dataEnd = p + len;
    if (code === 0x83) {
      const [url, next] = readCString(buf, p);
      const [target] = readCString(buf, next);
      getUrlTargets.push({ url, target });
    } else if (code === 0x88) {
      const count = buf.readUInt16LE(p);
      let q = p + 2;
      for (let i = 0; i < count && q < dataEnd; i++) {
        const [s, next] = readCString(buf, q);
        constantPoolStrings.add(s);
        q = next;
      }
    } else if (code === 0x96) {
      let q = p;
      while (q < dataEnd) {
        const type = buf[q++];
        if (type === 0) {
          const [s, next] = readCString(buf, q);
          pushedStrings.add(s);
          q = next;
        } else if (type === 1 || type === 7) q += 4;
        else if (type === 6) q += 8;
        else if (type === 4 || type === 5 || type === 8) q += 1;
        else if (type === 9) q += 2;
        else q = dataEnd;
      }
    }
    p = dataEnd;
  }
};

const walkTags = (buf, start, end, depth) => {
  let p = start;
  while (p < end) {
    const header = buf.readUInt16LE(p);
    p += 2;
    const code = header >> 6;
    let len = header & 0x3f;
    if (len === 0x3f) {
      len = buf.readUInt32LE(p);
      p += 4;
    }
    const dataStart = p;
    const dataEnd = p + len;
    const name = TAG_NAMES[code] ?? `Tag${code}`;
    tagCounts[name] = (tagCounts[name] ?? 0) + 1;

    if (code === 12) {
      actionBytes += len;
      parseActions(buf, dataStart, dataEnd);
    } else if (code === 59) {
      actionBytes += len - 2;
      parseActions(buf, dataStart + 2, dataEnd);
    } else if (code === 43) {
      frameLabels.push({ depth, label: readCString(buf, dataStart)[0] });
    } else if (code === 56) {
      const count = buf.readUInt16LE(dataStart);
      let q = dataStart + 2;
      for (let i = 0; i < count; i++) {
        const id = buf.readUInt16LE(q);
        const [exportName, next] = readCString(buf, q + 2);
        exports.push({ id, name: exportName });
        q = next;
      }
    } else if (code === 39) {
      sprites++;
      walkTags(buf, dataStart + 4, dataEnd, depth + 1);
    }

    p = dataEnd;
    if (code === 0) break;
  }
};

walkTags(body, pos, body.length, 0);

const printable = body.toString("latin1").match(/[\x20-\x7e]{4,}/g) ?? [];
const urlLike = [...new Set(printable.flatMap((s) => s.match(/(https?:\/\/|www\.)[^\s"']+|[a-z0-9-]+\.(com|net|org|br)(\/[^\s"']*)?/gi) ?? []))];
const allStrings = new Set([...constantPoolStrings, ...pushedStrings, ...printable]);
const networkHits = NETWORK_KEYWORDS.filter((k) => [...allStrings].some((s) => s.includes(k)));

console.log(JSON.stringify({
  file: { signature, swfVersion: version, compressedBytes: raw.length, uncompressedBytes: declaredLength },
  stage: { widthPx: rect[1] - rect[0], heightPx: rect[3] - rect[2], frameRate, frameCount },
  actionScript: {
    avm: tagCounts.DoABC || tagCounts.DoABC2 ? "AVM2 (AS3)" : "AVM1 (AS1/AS2)",
    doActionBytes: actionBytes,
    constantPoolStrings: constantPoolStrings.size,
  },
  sprites,
  tagCounts,
  frameLabels,
  exports,
  network: { getUrlTargets, urlLikeStrings: urlLike, keywordHits: networkHits },
  identifiers: [...constantPoolStrings].filter((s) => /^[A-Za-z_][A-Za-z0-9_]{1,30}$/.test(s)).sort(),
}, null, 1));
