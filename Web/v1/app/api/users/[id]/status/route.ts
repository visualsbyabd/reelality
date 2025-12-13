/**
 * @route   /api/users/:id/status
 * @desc    Change user account status (ACTIVE, DEACTIVATED, SUSPENDED)
 * @method  PATCH
 */

import { NextResponse } from "next/server";
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";

export async function PATCH(req: Request, { params }: { params: { id: string } }) {
  await connectDB();
  const { status } = await req.json();

  if (!["ACTIVE", "DEACTIVATED", "SUSPENDED"].includes(status))
    return NextResponse.json({ error: "Invalid status" }, { status: 400 });

  const updated = await User.findByIdAndUpdate(
    params.id,
    { accountStatus: status },
    { new: true }
  );
  return NextResponse.json({ message: `Account updated to ${status}`, updated });
}
