/**
 * @route   /api/users/:id/following
 * @desc    Fetch list of users this user follows
 * @methods GET
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const user = await User.findById(params.id).populate("following", "username avatarUrl");
  return NextResponse.json(user.following);
}
