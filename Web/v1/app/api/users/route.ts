/**
 * @route   /api/users
 * @desc    Fetch all users or create a new user
 * @methods GET, POST
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function GET() {
  try {
    await connectDB();
    const users = await User.find().select("-passwordHash");
    return NextResponse.json(users);
  } catch (err: any) {
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}

export async function POST(req: Request) {
  try {
    await connectDB();
    const data = await req.json();
    const user = await User.create(data);
    return NextResponse.json(user, { status: 201 });
  } catch (err: any) {
    return NextResponse.json({ error: err.message }, { status: 400 });
  }
}
