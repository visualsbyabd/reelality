// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['_id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  coverPhotoUrl: json['coverPhotoUrl'] as String?,
  bio: json['bio'] as String?,
  website: json['website'] as String?,
  gender: json['gender'] as String?,
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  country: json['country'] as String?,
  city: json['city'] as String?,
  region: json['region'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  role: json['role'] as String?,
  verified: json['verified'] as bool?,
  accountStatus: json['accountStatus'] as String?,
  followers: (json['followers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  following: (json['following'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  blockedUsers: (json['blockedUsers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
  deviceInfo: (json['deviceInfo'] as List<dynamic>?)
      ?.map((e) => _$DeviceInfoFromJson(e as Map<String, dynamic>))
      .toList(),
  pushNotifications: json['pushNotifications'] as bool?,
  emailUpdates: json['emailUpdates'] as bool?,
  preferredLanguage: json['preferredLanguage'] as String?,
  theme: json['theme'] as String?,
  engagementScore: (json['engagementScore'] as num?)?.toDouble(),
  totalWatchTime: (json['totalWatchTime'] as num?)?.toDouble(),
  videosWatched: (json['videosWatched'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  likedVideos: (json['likedVideos'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  savedVideos: (json['savedVideos'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  purchasedCourses: (json['purchasedCourses'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  earnings: (json['earnings'] as num?)?.toDouble(),
  walletBalance: (json['walletBalance'] as num?)?.toDouble(),
  walletCurrency: json['walletCurrency'] as String?,
  payoutMethods: (json['payoutMethods'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  personalizedAds: json['personalizedAds'] as bool?,
  dataSharing: json['dataSharing'] as bool?,
  analytics: json['analytics'] as bool?,
  chats: (json['chats'] as List<dynamic>?)?.map((e) => e as String).toList(),
  unreadMessagesCount: (json['unreadMessagesCount'] as num?)?.toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'avatarUrl': instance.avatarUrl,
  'coverPhotoUrl': instance.coverPhotoUrl,
  'bio': instance.bio,
  'website': instance.website,
  'gender': instance.gender,
  'birthday': instance.birthday?.toIso8601String(),
  'languages': instance.languages,
  'country': instance.country,
  'city': instance.city,
  'region': instance.region,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'role': instance.role,
  'verified': instance.verified,
  'accountStatus': instance.accountStatus,
  'followers': instance.followers,
  'following': instance.following,
  'blockedUsers': instance.blockedUsers,
  'interests': instance.interests,
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
  'deviceInfo': instance.deviceInfo,
  'pushNotifications': instance.pushNotifications,
  'emailUpdates': instance.emailUpdates,
  'preferredLanguage': instance.preferredLanguage,
  'theme': instance.theme,
  'engagementScore': instance.engagementScore,
  'totalWatchTime': instance.totalWatchTime,
  'videosWatched': instance.videosWatched,
  'likedVideos': instance.likedVideos,
  'savedVideos': instance.savedVideos,
  'purchasedCourses': instance.purchasedCourses,
  'earnings': instance.earnings,
  'walletBalance': instance.walletBalance,
  'walletCurrency': instance.walletCurrency,
  'payoutMethods': instance.payoutMethods,
  'personalizedAds': instance.personalizedAds,
  'dataSharing': instance.dataSharing,
  'analytics': instance.analytics,
  'chats': instance.chats,
  'unreadMessagesCount': instance.unreadMessagesCount,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
  deviceId: json['deviceId'] as String?,
  platform: json['platform'] as String?,
  osVersion: json['osVersion'] as String?,
  appVersion: json['appVersion'] as String?,
  model: json['model'] as String?,
  ipAddress: json['ipAddress'] as String?,
);

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'platform': instance.platform,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'model': instance.model,
      'ipAddress': instance.ipAddress,
    };
