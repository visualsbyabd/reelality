// Authentication Route
import { connectDB } from "@/db/connect";
import { User } from "@/models/User";
import PasswordHash from "@/utils/password_hash";
import { NextRequest, NextResponse } from "next/server";

export async function PATCH(request: NextRequest, _: NextResponse) {
  console.log("Request received:"); // This should show up now
  await connectDB();
  const data = await request.json();

  switch (data.mode) {
    case "LOGIN":
      const user = await User.findOne({ email: data.email });
      if (!user) return NextResponse.json({}, { status: 404 });
      const userDoc = user.toObject();
      const isValidPassword = await PasswordHash.comparePassword(
        data.password,
        userDoc.passowrdHash
      );
      console.log(isValidPassword)
      if (!isValidPassword) {
        return NextResponse.json(
          { message: "Wrong Passowrd" },
          { status: 301 }
        );
      }
      return NextResponse.json({ user: user }, { status: 200 });

    default:
      return NextResponse.json({}, { status: 500 });
  }
}
