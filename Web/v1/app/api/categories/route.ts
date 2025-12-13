import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { Category } from "@/models/Category";

/**
 * @route /api/categories
 * @methods GET, POST
 * @desc Admin creates new categories, users fetch all
 */

export async function GET() {
  await connectDB();
  const categories = await Category.find({ isActive: true }).sort("name");
  return NextResponse.json(categories);
}

export async function POST(req: Request) {
  await connectDB();
  const data = await req.json();

  try {
    const newCategory = await Category.create(data);
    return NextResponse.json(newCategory, { status: 201 });
  } catch (err: any) {
    return NextResponse.json({ error: err.message }, { status: 400 });
  }
}
