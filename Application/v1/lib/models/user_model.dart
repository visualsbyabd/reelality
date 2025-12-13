import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  // 🧍 Identity
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String email;
  final String? phone;

  // 🖼️ Profile
  final String? avatarUrl;
  final String? coverPhotoUrl;
  final String? bio;
  final String? website;
  final String? gender;
  final DateTime? birthday;
  final List<String>? languages;

  // 🌍 Location
  final String? country;
  final String? city;
  final String? region;
  final double? latitude;
  final double? longitude;

  // 🔐 Role, Verification & Status
  final String? role; // VIEWER, CREATOR, INSTITUTION, ADMIN
  final bool? verified;
  final String? accountStatus; // ACTIVE, DEACTIVATED, SUSPENDED

  // 🤝 Social Graph
  final List<String>? followers;
  final List<String>? following;
  final List<String>? blockedUsers;
  final List<String>? interests;

  // 📱 Activity & Devices
  final DateTime? lastActiveAt;
  final List<DeviceInfo>? deviceInfo;

  // ⚙️ Preferences
  final bool? pushNotifications;
  final bool? emailUpdates;
  final String? preferredLanguage;
  final String? theme;

  // 📊 Engagement
  final double? engagementScore;
  final double? totalWatchTime;
  final List<String>? videosWatched;
  final List<String>? likedVideos;
  final List<String>? savedVideos;
  final List<String>? purchasedCourses;

  // 💰 Monetization
  final double? earnings;
  final double? walletBalance;
  final String? walletCurrency;
  final List<String>? payoutMethods;

  // 🔒 Privacy
  final bool? personalizedAds;
  final bool? dataSharing;
  final bool? analytics;

  // 💬 Chat
  final List<String>? chats;
  final int? unreadMessagesCount;

  // 🧭 System
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // ✅ Constructor
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.bio,
    this.website,
    this.gender,
    this.birthday,
    this.languages,
    this.country,
    this.city,
    this.region,
    this.latitude,
    this.longitude,
    this.role,
    this.verified,
    this.accountStatus,
    this.followers,
    this.following,
    this.blockedUsers,
    this.interests,
    this.lastActiveAt,
    this.deviceInfo,
    this.pushNotifications,
    this.emailUpdates,
    this.preferredLanguage,
    this.theme,
    this.engagementScore,
    this.totalWatchTime,
    this.videosWatched,
    this.likedVideos,
    this.savedVideos,
    this.purchasedCourses,
    this.earnings,
    this.walletBalance,
    this.walletCurrency,
    this.payoutMethods,
    this.personalizedAds,
    this.dataSharing,
    this.analytics,
    this.chats,
    this.unreadMessagesCount,
    this.createdAt,
    this.updatedAt,
  });

  // ✅ copyWith() for partial updates
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    String? avatarUrl,
    String? coverPhotoUrl,
    String? bio,
    String? website,
    String? gender,
    DateTime? birthday,
    List<String>? languages,
    String? country,
    String? city,
    String? region,
    double? latitude,
    double? longitude,
    String? role,
    bool? verified,
    String? accountStatus,
    List<String>? followers,
    List<String>? following,
    List<String>? blockedUsers,
    List<String>? interests,
    DateTime? lastActiveAt,
    List<DeviceInfo>? deviceInfo,
    bool? pushNotifications,
    bool? emailUpdates,
    String? preferredLanguage,
    String? theme,
    double? engagementScore,
    double? totalWatchTime,
    List<String>? videosWatched,
    List<String>? likedVideos,
    List<String>? savedVideos,
    List<String>? purchasedCourses,
    double? earnings,
    double? walletBalance,
    String? walletCurrency,
    List<String>? payoutMethods,
    bool? personalizedAds,
    bool? dataSharing,
    bool? analytics,
    List<String>? chats,
    int? unreadMessagesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      bio: bio ?? this.bio,
      website: website ?? this.website,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      languages: languages ?? this.languages,
      country: country ?? this.country,
      city: city ?? this.city,
      region: region ?? this.region,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      role: role ?? this.role,
      verified: verified ?? this.verified,
      accountStatus: accountStatus ?? this.accountStatus,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      interests: interests ?? this.interests,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailUpdates: emailUpdates ?? this.emailUpdates,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      theme: theme ?? this.theme,
      engagementScore: engagementScore ?? this.engagementScore,
      totalWatchTime: totalWatchTime ?? this.totalWatchTime,
      videosWatched: videosWatched ?? this.videosWatched,
      likedVideos: likedVideos ?? this.likedVideos,
      savedVideos: savedVideos ?? this.savedVideos,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,
      earnings: earnings ?? this.earnings,
      walletBalance: walletBalance ?? this.walletBalance,
      walletCurrency: walletCurrency ?? this.walletCurrency,
      payoutMethods: payoutMethods ?? this.payoutMethods,
      personalizedAds: personalizedAds ?? this.personalizedAds,
      dataSharing: dataSharing ?? this.dataSharing,
      analytics: analytics ?? this.analytics,
      chats: chats ?? this.chats,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ✅ JSON serialization
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class DeviceInfo {
  final String? deviceId;
  final String? platform;
  final String? osVersion;
  final String? appVersion;
  final String? model;
  final String? ipAddress;

  DeviceInfo({
    this.deviceId,
    this.platform,
    this.osVersion,
    this.appVersion,
    this.model,
    this.ipAddress,
  });
}
