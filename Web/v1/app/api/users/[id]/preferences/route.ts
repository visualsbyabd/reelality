/**
 * @route   /api/users/:id/preferences
 * @desc    Read or update user notification, theme, and language settings
 * @methods GET, PUT
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const user = await User.findById(params.id).select("pushNotifications emailUpdates preferredLanguage theme");
  return NextResponse.json(user);
}

export async function PUT(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const body = await req.json();
  const updated = await User.findByIdAndUpdate(
    params.id,
    {
      pushNotifications: body.pushNotifications,
      emailUpdates: body.emailUpdates,
      preferredLanguage: body.preferredLanguage,
      theme: body.theme,
    },
    { new: true }
  ).select("pushNotifications emailUpdates preferredLanguage theme");

  return NextResponse.json(updated);
}
