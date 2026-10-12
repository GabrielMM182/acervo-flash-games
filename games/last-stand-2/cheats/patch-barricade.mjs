import { join } from "node:path";
import {
  OP, countChangedBytes, listActionBlocks, loadSwf, saveSwf, simulateBlock,
} from "../../../tools/avm1.mjs";

const EXPECTED_WALL_DAMAGE_SITES = 2;

const isWallSubtract = (store) =>
  store.target.kind === "member" &&
  store.target.obj.kind === "var" &&
  store.target.obj.name === "wall" &&
  store.target.name === "health" &&
  store.value.kind === "op" &&
  store.value.code === OP.SUBTRACT;

const findSites = (swf) => {
  const sites = { wall: [] };
  const { blocks, skipped } = listActionBlocks(swf);
  for (const block of blocks) {
    simulateBlock(swf.body, block, (store) => {
      if (isWallSubtract(store)) sites.wall.push(store);
    });
  }
  return { sites, blockCount: blocks.length, skipped };
};

const assertCount = (label, actual, expected) => {
  if (actual !== expected) throw new Error(`${label}: expected ${expected} sites, found ${actual}`);
};

const applyBarricadeCheat = (swf, sites) => {
  const body = Buffer.from(swf.body);
  sites.wall.forEach((s) => { body[s.value.offset] = OP.POP; });
  return { ...swf, body };
};

const [inputPath, outputPath] = process.argv.slice(2);
if (!inputPath || !outputPath) {
  console.error("Usage: node patch-barricade.mjs <input.swf> <output.swf>");
  process.exit(1);
}

const original = loadSwf(inputPath);
const { sites, blockCount, skipped } = findSites(original);
console.log(`Scanned ${blockCount} action blocks${skipped.length ? `, skipped ${skipped.length}: ${skipped.join("; ")}` : ""}`);
assertCount("wall damage", sites.wall.length, EXPECTED_WALL_DAMAGE_SITES);
sites.wall.forEach((s) => console.log(`  wall.health -= at 0x${s.value.offset.toString(16)} (${s.location})`));

const patched = applyBarricadeCheat(original, sites);
const remaining = findSites(patched).sites;
if (remaining.wall.length > 0) {
  throw new Error(`${remaining.wall.length} wall damage sites still active after patch`);
}

saveSwf(outputPath, patched);
console.log(`barricade-god: ${countChangedBytes(original.body, patched.body)} bytes changed -> ${outputPath}`);
