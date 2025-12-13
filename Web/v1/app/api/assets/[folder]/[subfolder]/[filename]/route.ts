import { NextResponse } from "next/server";
import { join } from "path";
import { readFile } from "fs/promises";
import mime from "mime";

export async function GET(
  request: Request,
  { params }: { params: { folder: string; subfolder: string, filename: string } }
) {
  try {
    const { folder, subfolder, filename }= await params;

    // Construct absolute path to asset
    const filePath = join(process.cwd(), "assets", folder, subfolder, filename);

    console.log(filePath);
    // Read the file as a buffer
    const fileBuffer = await readFile(filePath);

    // Detect MIME type based on file extension
    const contentType = mime.getType(filePath) || "application/octet-stream";

    // Return binary data with correct headers
    return new NextResponse(fileBuffer, {
      headers: {
        "Content-Type": contentType,
        "Cache-Control": "public, max-age=86400",
      },
    });
  } catch (err: any) {
    console.error("Asset fetch error:", err);
    return NextResponse.json(
      { error: `Asset not found: ${err.message}` },
      { status: 404 }
    );
  }
}
