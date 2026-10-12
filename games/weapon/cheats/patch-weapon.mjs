import { join } from "node:path";
import {
  OP, countChangedBytes, isRootMember, listActionBlocks, loadSwf, saveSwf, simulateBlock, writeNumberLiteral,
} from "../../../tools/avm1.mjs";

const STARTING_CREDITS = 999999;
const EXPECTED_HEALTH_DAMAGE_SITES = 16;
const EXPECTED_CREDIT_SPEND_SITES = 51;

const VARIANTS = {
  heli: ["heli"],
  money: ["money"],
  all: ["heli", "money"],
};

const isCompoundSubtract = (store, name) =>
  isRootMember(store.target, name) &&
  store.value.kind === "op" &&
  store.value.code === OP.SUBTRACT &&
  isRootMember(store.value.args[0], name);

const isCreditsInit = (store) =>
  store.target.kind === "var" &&
  store.target.name === "credits" &&
  store.value.kind === "lit" &&
  store.value.numberType !== undefined;

const findSites = (swf) => {
  const sites = { health: [], credits: [], creditsInit: [] };
  const { blocks, skipped } = listActionBlocks(swf);
  for (const block of blocks) {
    simulateBlock(swf.body, block, (store) => {
      if (isCompoundSubtract(store, "health")) sites.health.push(store);
      else if (isCompoundSubtract(store, "credits")) sites.credits.push(store);
      else if (isCreditsInit(store)) sites.creditsInit.push(store);
    });
  }
  return { sites, blockCount: blocks.length, skipped };
};

const assertCount = (label, actual, expected) => {
  if (actual !== expected) throw new Error(`${label}: expected ${expected} sites, found ${actual}`);
};

const applyCheats = (swf, sites, cheats) => {
  const body = Buffer.from(swf.body);
  if (cheats.includes("heli")) sites.health.forEach((s) => { body[s.value.offset] = OP.POP; });
  if (cheats.includes("money")) {
    sites.credits.forEach((s) => { body[s.value.offset] = OP.POP; });
    writeNumberLiteral(body, sites.creditsInit[0].value, STARTING_CREDITS);
  }
  return { ...swf, body };
};

const [inputPath, outputDir] = process.argv.slice(2);
if (!inputPath || !outputDir) {
  console.error("Usage: node patch-weapon.mjs <weapon.swf> <output-dir>");
  process.exit(1);
}

const original = loadSwf(inputPath);
const { sites, blockCount, skipped } = findSites(original);
console.log(`Scanned ${blockCount} action blocks${skipped.length ? `, skipped ${skipped.length}: ${skipped.join("; ")}` : ""}`);
assertCount("helicopter damage", sites.health.length, EXPECTED_HEALTH_DAMAGE_SITES);
assertCount("credit spending", sites.credits.length, EXPECTED_CREDIT_SPEND_SITES);
assertCount("credits initialization", sites.creditsInit.length, 1);
sites.health.forEach((s) => console.log(`  health -= at 0x${s.value.offset.toString(16)} (${s.location})`));
console.log(`  credits -= at ${sites.credits.length} store buttons, credits = ${sites.creditsInit[0].value.value} at ${sites.creditsInit[0].location}`);

for (const [variant, cheats] of Object.entries(VARIANTS)) {
  const patched = applyCheats(original, sites, cheats);
  const remaining = findSites(patched).sites;
  const leftovers = (cheats.includes("heli") ? remaining.health.length : 0) + (cheats.includes("money") ? remaining.credits.length : 0);
  if (leftovers) throw new Error(`${variant}: ${leftovers} sites still active after patch`);
  const outputPath = join(outputDir, `weapon-${variant}.swf`);
  saveSwf(outputPath, patched);
  console.log(`${variant}: ${countChangedBytes(original.body, patched.body)} bytes changed -> ${outputPath}`);
}
