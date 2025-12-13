import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { Category } from "@/models/Category";
import { User } from "@/models/User";

/**
 * @route /api/categories/:id/follow
 * @methods POST, DELETE
 * @desc Users follow or unfollow a category
 */

export async function POST(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { userId } = await req.json();

  const category = await Category.findByIdAndUpdate(
    params.id,
    { $addToSet: { followers: userId } },
    { new: true }
  );
  await User.findByIdAndUpdate(userId, { $addToSet: { interests: category.name } });
  return NextResponse.json(category);
}

export async function DELETE(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { userId } = await req.json();

  const category = await Category.findByIdAndUpdate(
    params.id,
    { $pull: { followers: userId } },
    { new: true }
  );
  await User.findByIdAndUpdate(userId, { $pull: { interests: category.name } });
  return NextResponse.json(category);
}
