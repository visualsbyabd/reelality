/**
 * @route   /api/users/:id/chats
 * @desc    Fetch all chat IDs or add chat reference for a user
 * @methods GET, POST
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const user = await User.findById(params.id).populate("chats");
  return NextResponse.json(user.chats);
}

export async function POST(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { chatId } = await req.json();
  const updated = await User.findByIdAndUpdate(
    params.id,
    { $addToSet: { chats: chatId } },
    { new: true }
  ).select("chats");
  return NextResponse.json(updated);
}
