import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { Category } from "@/models/Category";

/**
 * @route /api/categories/:id
 * @methods GET, PUT, DELETE
 */

export async function GET(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const category = await Category.findById(params.id);
  return NextResponse.json(category);
}

export async function PUT(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const updates = await req.json();
  const updated = await Category.findByIdAndUpdate(params.id, updates, {
    new: true,
  });
  return NextResponse.json(updated);
}

export async function DELETE(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  await Category.findByIdAndDelete(params.id);
  return NextResponse.json({ message: "Category deleted" });
}
