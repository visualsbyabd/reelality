import { Schema, model, models } from "mongoose";

/**
 * Category schema for Reelality.
 * Represents admin-curated topics (e.g. "Video Editing", "Cinematography").
 */
const categorySchema = new Schema(
  {
    // 🏷️ Basic Info
    name: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    }, // Category name (e.g., "Cinematography")

    description: {
      type: String,
      maxlength: 500,
    }, // Description or summary

    specialColor: {
      type: String,
      required: true,
      unique: true,
    },

    slug: {
      type: String,
      unique: true,
      lowercase: true,
      trim: true,
    }, // SEO-friendly slug for URLs

    // 🖼️ Media
    iconUrl: { type: String }, // Small icon for UI
    bannerUrl: { type: String }, // Optional banner image

    // 📊 Engagement
    followers: [{ type: Schema.Types.ObjectId, ref: "User" }], // Users following the category
    followerCount: { type: Number, default: 0 },

    // 🧭 Metadata
    createdBy: { type: Schema.Types.ObjectId, ref: "User" }, // Admin who created
    isFeatured: { type: Boolean, default: false },
    isActive: { type: Boolean, default: true },


  },
  { timestamps: true }
);

export const Category = models.Category || model("Category", categorySchema);
