import { OP, countChangedBytes, findSequences, loadSwf, saveSwf } from "../../../tools/avm1.mjs";

const ALLOWED_DOMAIN = "armorgames.com";

const pushesString = (instruction, value) =>
  instruction?.code === OP.PUSH && instruction.values.some((v) => v.kind === "lit" && v.value === value);

const sitelockBranch = (instructions, i) => {
  const [push, equals, negate, branchNot, branch] = instructions.slice(i, i + 5);
  const isMatch = pushesString(push, ALLOWED_DOMAIN) &&
    equals?.code === OP.EQUALS2 &&
    negate?.code === OP.NOT &&
    branchNot?.code === OP.NOT &&
    branch?.code === OP.IF;
  return isMatch ? { notOffset: branchNot.offset, ifOffset: branch.offset } : null;
};

const [inputPath, outputPath] = process.argv.slice(2);
if (!inputPath || !outputPath) {
  console.error("Usage: node patch-sitelock.mjs <input.swf> <output.swf>");
  process.exit(1);
}

const original = loadSwf(inputPath);
const matches = findSequences(original, sitelockBranch);
if (matches.length !== 1) throw new Error(`Expected exactly one sitelock branch, found ${matches.length}`);

const body = Buffer.from(original.body);
body[matches[0].notOffset] = OP.POP;
body[matches[0].ifOffset] = OP.JUMP;
const patched = { ...original, body };

if (findSequences(patched, sitelockBranch).length) throw new Error("Sitelock branch still present after patch");
saveSwf(outputPath, patched);
console.log(`Sitelock bypassed at ${matches[0].location}: ${countChangedBytes(original.body, body)} bytes changed -> ${outputPath}`);
