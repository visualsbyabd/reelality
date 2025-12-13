/**
 * @route   /api/users/:id/devices
 * @desc    Manage user's logged-in devices
 * @methods GET, POST, DELETE
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const user = await User.findById(params.id).select("deviceInfo");
  return NextResponse.json(user.deviceInfo);
}

export async function POST(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const newDevice = await req.json();
  const user = await User.findByIdAndUpdate(
    params.id,
    { $push: { deviceInfo: newDevice } },
    { new: true }
  ).select("deviceInfo");
  return NextResponse.json(user.deviceInfo);
}

export async function DELETE(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { deviceId } = await req.json();
  const user = await User.findByIdAndUpdate(
    params.id,
    { $pull: { deviceInfo: { deviceId } } },
    { new: true }
  ).select("deviceInfo");
  return NextResponse.json(user.deviceInfo);
}
