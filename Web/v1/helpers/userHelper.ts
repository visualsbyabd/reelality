import { connectDB } from "@/db/connect";
import { User } from "../models/User";
import { UpdateQuery } from "mongoose";

// ✅ Ensure DB connection before each operation
await connectDB();

export class UserHelper {
  /**
   * 🆕 Create a new user
   */
  static async createUser(data: any) {
    try {
      const user = new User(data);
      return await user.save();
    } catch (err: any) {
      console.error("❌ Error creating user:", err.message);
      throw new Error("Failed to create user");
    }
  }

  /**
   * 🔍 Find a user by ID
   */
  static async getUserById(id: string) {
    try {
      return await User.findById(id).select("-passwordHash");
    } catch (err: any) {
      console.error("❌ Error fetching user:", err.message);
      throw new Error("User not found");
    }
  }

  /**
   * 📧 Find a user by email
   */
  static async getUserByEmail(email: string) {
    try {
      return await User.findOne({ email }).select("-passwordHash");
    } catch (err: any) {
      console.error("❌ Error fetching user by email:", err.message);
      throw new Error("User not found");
    }
  }

  /**
   * 🔄 Update user data
   */
  static async updateUser(id: string, updates: UpdateQuery<any>) {
    try {
      return await User.findByIdAndUpdate(id, updates, { new: true }).select(
        "-passwordHash"
      );
    } catch (err: any) {
      console.error("❌ Error updating user:", err.message);
      throw new Error("Failed to update user");
    }
  }

  /**
   * ❌ Delete a user
   */
  static async deleteUser(id: string) {
    try {
      return await User.findByIdAndDelete(id);
    } catch (err: any) {
      console.error("❌ Error deleting user:", err.message);
      throw new Error("Failed to delete user");
    }
  }

  /**
   * 🔎 Filter users by custom query
   */
  static async findUsers(
    filter: Record<string, any> = {},
    limit = 50,
    skip = 0
  ) {
    try {
      return await User.find(filter)
        .select("-passwordHash")
        .limit(limit)
        .skip(skip)
        .sort({ createdAt: -1 });
    } catch (err: any) {
      console.error("❌ Error fetching users:", err.message);
      throw new Error("Failed to fetch users");
    }
  }

  /**
   * 📈 Get active users (recently online)
   */
  static async getRecentlyActive(minutes = 30) {
    const since = new Date(Date.now() - minutes * 60 * 1000);
    return await User.find({ lastActiveAt: { $gte: since } }).select(
      "-passwordHash"
    );
  }

  /**
   * 🧭 Get users by role
   */
  static async getUsersByRole(role: string) {
    return await User.find({ role }).select("-passwordHash");
  }

  /**
   * 🧩 Increment engagement or stats
   */
  static async incrementEngagement(
    userId: string,
    field: string,
    value: number = 1
  ) {
    const validFields = ["engagementScore", "totalWatchTime"];
    if (!validFields.includes(field))
      throw new Error("Invalid field to increment");
    return await User.findByIdAndUpdate(
      userId,
      { $inc: { [field]: value } },
      { new: true }
    );
  }

  /**
   * ⚡ Update last active timestamp
   */
  static async updateLastActive(userId: string) {
    return await User.findByIdAndUpdate(userId, { lastActiveAt: new Date() });
  }

  /**
   * 🔒 Sanitize user object (remove sensitive fields)
   */
  static sanitize(user: any) {
    if (!user) return null;
    const { passwordHash, ...safe } = user.toObject ? user.toObject() : user;
    return safe;
  }
}
