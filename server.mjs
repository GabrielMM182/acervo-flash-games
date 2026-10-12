import { createServer } from "node:http";
import { readFile } from "node:fs/promises";
import { extname, join, normalize, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = resolve(fileURLToPath(new URL(".", import.meta.url)));
const HOST = process.env.HOST ?? "127.0.0.1";
const PORT = Number(process.env.PORT ?? 8090);

const MIME_TYPES = {
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".swf": "application/x-shockwave-flash",
  ".wasm": "application/wasm",
  ".png": "image/png",
  ".ico": "image/x-icon",
};

const resolveRequestPath = (url) => {
  const pathname = decodeURIComponent(new URL(url, "http://localhost").pathname);
  const relative = pathname.endsWith("/") ? `${pathname}index.html` : pathname;
  const absolute = resolve(ROOT, normalize(`.${relative}`));
  return absolute === ROOT || absolute.startsWith(ROOT + sep) ? absolute : null;
};

createServer(async (req, res) => {
  const filePath = resolveRequestPath(req.url);
  if (!filePath || filePath.endsWith("server.mjs")) {
    res.writeHead(403).end();
    return;
  }
  try {
    const content = await readFile(filePath);
    res.writeHead(200, {
      "Content-Type": MIME_TYPES[extname(filePath).toLowerCase()] ?? "application/octet-stream",
      "Cache-Control": "no-store",
    });
    res.end(content);
  } catch {
    res.writeHead(404).end();
  }
}).listen(PORT, HOST, () => {
  console.log(`Serving ${join(ROOT)} at http://${HOST}:${PORT}`);
});
