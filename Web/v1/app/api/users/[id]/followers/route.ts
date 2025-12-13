/**
 * @route   /api/users/:id/followers
 * @desc    Handle follow/unfollow actions and fetch followers
 * @methods GET, POST, DELETE
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const user = await User.findById(params.id).populate("followers", "username avatarUrl");
  return NextResponse.json(user.followers);
}

export async function POST(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { followerId } = await req.json();
  await User.findByIdAndUpdate(params.id, { $addToSet: { followers: followerId } });
  await User.findByIdAndUpdate(followerId, { $addToSet: { following: params.id } });
  return NextResponse.json({ message: "Followed successfully" });
}

export async function DELETE(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { followerId } = await req.json();
  await User.findByIdAndUpdate(params.id, { $pull: { followers: followerId } });
  await User.findByIdAndUpdate(followerId, { $pull: { following: params.id } });
  return NextResponse.json({ message: "Unfollowed successfully" });
}
