import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { Category } from "@/models/Category";

/**
 * @route /api/categories/featured
 * @method GET
 * @desc Fetch featured categories (for discover page)
 */
export async function GET() {
  await connectDB();
  const featured = await Category.find({ isFeatured: true }).limit(10);
  return NextResponse.json(featured);
}
