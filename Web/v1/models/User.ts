import { Schema, model, models } from "mongoose";

const deviceSchema = new Schema({
  deviceId: String,
  platform: String,
  osVersion: String,
  appVersion: String,
  model: String,
  ipAddress: String,
});

const walletSchema = new Schema({
  balance: { type: Number, default: 0 },
  currency: { type: String, default: "USD" },
  payoutMethods: [{ type: String }],
});

const preferencesSchema = new Schema({
  pushNotifications: { type: Boolean, default: true },
  emailUpdates: { type: Boolean, default: false },
  language: { type: String, default: "en" },
  theme: { type: String, enum: ["light", "dark"], default: "light" },
});

const consentSchema = new Schema({
  personalizedAds: { type: Boolean, default: false },
  dataSharing: { type: Boolean, default: false },
  analytics: { type: Boolean, default: true },
});

const locationSchema = new Schema({
  country: String,
  city: String,
  region: String,
  coordinates: { lat: Number, lng: Number },
});

const userSchema = new Schema(
  {
    firstName: String,
    lastName: String,
    username: { type: String, unique: true, index: true },
    email: { type: String, unique: true, required: true, index: true },
    phone: String,
    passwordHash: { type: String, required: true },
    avatarUrl: String,
    coverPhotoUrl: String,
    bio: { type: String, maxlength: 300 },
    website: String,
    gender: {
      type: String,
      enum: ["male", "female", "other", "prefer_not_to_say"],
      default: "prefer_not_to_say",
    },
    birthday: Date,
    languages: [String],
    location: locationSchema,

    role: {
      type: String,
      enum: ["VIEWER", "CREATOR", "INSTITUTION", "ADMIN"],
      default: "VIEWER",
      index: true,
    },
    verified: { type: Boolean, default: false },
    accountStatus: {
      type: String,
      enum: ["ACTIVE", "DEACTIVATED", "SUSPENDED"],
      default: "ACTIVE",
    },

    followers: [{ type: Schema.Types.ObjectId, ref: "User" }],
    following: [{ type: Schema.Types.ObjectId, ref: "User" }],
    blockedUsers: [{ type: Schema.Types.ObjectId, ref: "User" }],
    interests: [String],

    lastActiveAt: Date,
    deviceInfo: [deviceSchema],

    preferences: preferencesSchema,

    engagementScore: { type: Number, default: 0 },
    totalWatchTime: { type: Number, default: 0 },
    videosWatched: [{ type: Schema.Types.ObjectId, ref: "Video" }],
    likedVideos: [{ type: Schema.Types.ObjectId, ref: "Video" }],
    savedVideos: [{ type: Schema.Types.ObjectId, ref: "Video" }],
    purchasedCourses: [{ type: Schema.Types.ObjectId, ref: "Course" }],

    earnings: { type: Number, default: 0 },
    wallet: walletSchema,

    consent: consentSchema,

    // 🧩 New Chat Fields
    chats: [{ type: Schema.Types.ObjectId, ref: "Chat" }], // Conversations user is part of
    unreadMessagesCount: { type: Number, default: 0 },

    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now },
  },
  { timestamps: true }
);

export const User = models.User || model("User", userSchema);
