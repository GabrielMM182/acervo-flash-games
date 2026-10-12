import { readFileSync } from "node:fs";
import { inflateSync } from "node:zlib";

const OPS = {
  0x04: "NextFrame", 0x05: "PrevFrame", 0x06: "Play", 0x07: "Stop", 0x0a: "Add", 0x0b: "Subtract",
  0x0c: "Multiply", 0x0d: "Divide", 0x0e: "Equals", 0x0f: "Less", 0x10: "And", 0x11: "Or", 0x12: "Not",
  0x13: "StringEquals", 0x14: "StringLength", 0x15: "StringExtract", 0x17: "Pop", 0x18: "ToInteger",
  0x1c: "GetVariable", 0x1d: "SetVariable", 0x20: "SetTarget2", 0x21: "StringAdd", 0x22: "GetProperty",
  0x23: "SetProperty", 0x24: "CloneSprite", 0x25: "RemoveSprite", 0x26: "Trace", 0x27: "StartDrag",
  0x28: "EndDrag", 0x29: "StringLess", 0x30: "RandomNumber", 0x34: "GetTime", 0x3a: "Delete",
  0x3b: "Delete2", 0x3c: "DefineLocal", 0x3d: "CallFunction", 0x3e: "Return", 0x3f: "Modulo",
  0x40: "NewObject", 0x41: "DefineLocal2", 0x42: "InitArray", 0x43: "InitObject", 0x44: "TypeOf",
  0x45: "TargetPath", 0x46: "Enumerate", 0x47: "Add2", 0x48: "Less2", 0x49: "Equals2", 0x4a: "ToNumber",
  0x4b: "ToString", 0x4c: "PushDuplicate", 0x4d: "StackSwap", 0x4e: "GetMember", 0x4f: "SetMember",
  0x50: "Increment", 0x51: "Decrement", 0x52: "CallMethod", 0x53: "NewMethod", 0x54: "InstanceOf",
  0x55: "Enumerate2", 0x60: "BitAnd", 0x61: "BitOr", 0x62: "BitXor", 0x63: "BitLShift", 0x64: "BitRShift",
  0x65: "BitURShift", 0x66: "StrictEquals", 0x67: "Greater", 0x68: "StringGreater", 0x81: "GotoFrame",
  0x83: "GetURL", 0x87: "StoreRegister", 0x88: "ConstantPool", 0x8a: "WaitForFrame", 0x8b: "SetTarget",
  0x8c: "GoToLabel", 0x8d: "WaitForFrame2", 0x8e: "DefineFunction2", 0x94: "With", 0x96: "Push",
  0x99: "Jump", 0x9a: "GetURL2", 0x9b: "DefineFunction", 0x9d: "If", 0x9e: "Call", 0x9f: "GotoFrame2",
};

const [, , swfPath, ...filters] = process.argv;
const raw = readFileSync(swfPath);
const body = inflateSync(raw.subarray(8));

const readCString = (buf, at) => {
  let end = at;
  while (end < buf.length && buf[end] !== 0) end++;
  return [buf.toString("latin1", at, end), end + 1];
};

const disassemble = (buf, start, end) => {
  const out = [];
  let pool = [];
  let p = start;
  while (p < end) {
    const code = buf[p++];
    if (code === 0) break;
    const name = OPS[code] ?? `Op${code.toString(16)}`;
    if (code < 0x80) {
      out.push(name);
      continue;
    }
    const len = buf.readUInt16LE(p);
    p += 2;
    const d = p;
    const dEnd = p + len;
    let arg = "";
    if (code === 0x88) {
      const count = buf.readUInt16LE(d);
      pool = [];
      let q = d + 2;
      for (let i = 0; i < count; i++) {
        const [s, next] = readCString(buf, q);
        pool.push(s);
        q = next;
      }
      arg = `${count} entries`;
    } else if (code === 0x96) {
      const values = [];
      let q = d;
      while (q < dEnd) {
        const t = buf[q++];
        if (t === 0) { const [s, n] = readCString(buf, q); values.push(JSON.stringify(s)); q = n; }
        else if (t === 1) { values.push(buf.readFloatLE(q)); q += 4; }
        else if (t === 2) values.push("null");
        else if (t === 3) values.push("undefined");
        else if (t === 4) { values.push(`r${buf[q]}`); q += 1; }
        else if (t === 5) { values.push(buf[q] ? "true" : "false"); q += 1; }
        else if (t === 6) { const b = Buffer.concat([buf.subarray(q + 4, q + 8), buf.subarray(q, q + 4)]); values.push(b.readDoubleLE(0)); q += 8; }
        else if (t === 7) { values.push(buf.readInt32LE(q)); q += 4; }
        else if (t === 8) { values.push(JSON.stringify(pool[buf[q]])); q += 1; }
        else if (t === 9) { values.push(JSON.stringify(pool[buf.readUInt16LE(q)])); q += 2; }
        else break;
      }
      arg = values.join(", ");
    } else if (code === 0x81) arg = String(buf.readUInt16LE(d));
    else if (code === 0x8c || code === 0x8b) arg = JSON.stringify(readCString(buf, d)[0]);
    else if (code === 0x83) { const [u, n] = readCString(buf, d); arg = `${JSON.stringify(u)} ${JSON.stringify(readCString(buf, n)[0])}`; }
    else if (code === 0x99 || code === 0x9d) arg = String(buf.readInt16LE(d));
    else if (code === 0x9b) {
      const [fname, n] = readCString(buf, d);
      const argc = buf.readUInt16LE(n);
      let q = n + 2;
      const params = [];
      for (let i = 0; i < argc; i++) { const [s, nn] = readCString(buf, q); params.push(s); q = nn; }
      arg = `${fname}(${params.join(", ")}) size=${buf.readUInt16LE(q)}`;
    } else if (code === 0x9f) arg = `play=${buf[d] & 1}`;
    else if (code === 0x8a || code === 0x8d) arg = String(buf[d + (code === 0x8a ? 2 : 0)]);
    out.push(arg ? `${name} ${arg}` : name);
    p = dEnd;
  }
  return out;
};

const walk = (buf, start, end, owner) => {
  let p = start;
  let frame = 1;
  while (p < end) {
    const header = buf.readUInt16LE(p);
    p += 2;
    const code = header >> 6;
    let len = header & 0x3f;
    if (len === 0x3f) { len = buf.readUInt32LE(p); p += 4; }
    const d = p;
    const dEnd = p + len;
    if (code === 1) frame++;
    else if (code === 43) console.log(`[${owner} f${frame}] LABEL ${readCString(buf, d)[0]}`);
    else if (code === 12) {
      const ops = disassemble(buf, d, dEnd);
      console.log(`[${owner} f${frame}] DoAction (${ops.length} ops)`);
      ops.forEach((o) => console.log(`    ${o}`));
    } else if (code === 39) {
      const id = buf.readUInt16LE(d);
      if (!filters.length || filters.includes(String(id))) walk(buf, d + 4, dEnd, `sprite${id}`);
    } else if (code === 34) {
      const id = buf.readUInt16LE(d);
      const actionOffset = buf.readUInt16LE(d + 3);
      if (actionOffset && (!filters.length || filters.includes(`b${id}`))) {
        let q = d + 3 + actionOffset;
        while (q < dEnd) {
          const condSize = buf.readUInt16LE(q);
          const cond = buf.readUInt16LE(q + 2);
          const aStart = q + 4;
          const aEnd = condSize ? q + condSize : dEnd;
          const ops = disassemble(buf, aStart, aEnd);
          console.log(`[button${id} cond=0x${cond.toString(16)}] (${ops.length} ops)`);
          ops.forEach((o) => console.log(`    ${o}`));
          if (!condSize) break;
          q += condSize;
        }
      }
    }
    p = dEnd;
    if (code === 0) break;
  }
};

const nBits = body[0] >> 3;
const headerBytes = Math.ceil((5 + nBits * 4) / 8) + 4;
walk(body, headerBytes, body.length, "root");
