import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';

/// A service class that communicates with the Next.js API endpoints.
/// Handles all user-related routes including profile, preferences, followers, devices, and account status.
class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          "${dotenv.env['API_URL']!}/users/", // ← Change to production URL later
      headers: {
        "Content-Type": "application/json",
        'Authorization': dotenv.env['JWT_SECRET']!,
      },
    ),
  );

  /// 🔹 Fetch all users
  Future<List<UserModel>> getAllUsers() async {
    try {
      final res = await _dio.get("/");
      return (res.data as List).map((e) => UserModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        "Failed to fetch users: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Create a new user
  Future<UserModel> createUser(UserModel user) async {
    try {
      final res = await _dio.post("/", data: user.toJson());
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(
        "Failed to create user: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Get single user by ID
  Future<UserModel> getUserById(String id) async {
    try {
      final res = await _dio.get("/$id");
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception("Failed to get user: ${e.response?.data ?? e.message}");
    }
  }

  /// 🔹 Update user info
  Future<UserModel> updateUser(String id, Map<String, dynamic> updates) async {
    try {
      final res = await _dio.put("/$id", data: updates);
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(
        "Failed to update user: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Delete user
  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete("/$id");
    } on DioException catch (e) {
      throw Exception(
        "Failed to delete user: ${e.response?.data ?? e.message}",
      );
    }
  }

  // =============================================================
  // ⚙️ USER PREFERENCES
  // =============================================================

  /// 🔹 Get user preferences
  Future<Map<String, dynamic>> getPreferences(String id) async {
    try {
      final res = await _dio.get("/$id/preferences");
      return Map<String, dynamic>.from(res.data);
    } on DioException catch (e) {
      throw Exception(
        "Failed to get preferences: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Update preferences
  Future<Map<String, dynamic>> updatePreferences(
    String id,
    Map<String, dynamic> prefs,
  ) async {
    try {
      final res = await _dio.put("/$id/preferences", data: prefs);
      return Map<String, dynamic>.from(res.data);
    } on DioException catch (e) {
      throw Exception(
        "Failed to update preferences: ${e.response?.data ?? e.message}",
      );
    }
  }

  // =============================================================
  // 📱 DEVICES
  // =============================================================

  /// 🔹 Get all logged devices for user
  Future<List<Map<String, dynamic>>> getDevices(String id) async {
    try {
      final res = await _dio.get("/$id/devices");
      return List<Map<String, dynamic>>.from(res.data);
    } on DioException catch (e) {
      throw Exception(
        "Failed to get devices: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Add a new device
  Future<List<Map<String, dynamic>>> addDevice(
    String id,
    Map<String, dynamic> device,
  ) async {
    try {
      final res = await _dio.post("/$id/devices", data: device);
      return List<Map<String, dynamic>>.from(res.data);
    } on DioException catch (e) {
      throw Exception("Failed to add device: ${e.response?.data ?? e.message}");
    }
  }

  /// 🔹 Remove device by deviceId
  Future<List<Map<String, dynamic>>> removeDevice(
    String id,
    String deviceId,
  ) async {
    try {
      final res = await _dio.delete(
        "/$id/devices",
        data: {"deviceId": deviceId},
      );
      return List<Map<String, dynamic>>.from(res.data);
    } on DioException catch (e) {
      throw Exception(
        "Failed to remove device: ${e.response?.data ?? e.message}",
      );
    }
  }

  // =============================================================
  // 🤝 FOLLOWERS / FOLLOWING
  // =============================================================

  /// 🔹 Get all followers
  Future<List<UserModel>> getFollowers(String id) async {
    try {
      final res = await _dio.get("/$id/followers");
      return (res.data as List).map((e) => UserModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        "Failed to fetch followers: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Follow another user
  Future<void> followUser(String id, String followerId) async {
    try {
      await _dio.post("/$id/followers", data: {"followerId": followerId});
    } on DioException catch (e) {
      throw Exception(
        "Failed to follow user: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Unfollow user
  Future<void> unfollowUser(String id, String followerId) async {
    try {
      await _dio.delete("/$id/followers", data: {"followerId": followerId});
    } on DioException catch (e) {
      throw Exception(
        "Failed to unfollow user: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Get following list
  Future<List<UserModel>> getFollowing(String id) async {
    try {
      final res = await _dio.get("/$id/following");
      return (res.data as List).map((e) => UserModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        "Failed to fetch following: ${e.response?.data ?? e.message}",
      );
    }
  }

  // =============================================================
  // 💬 CHATS
  // =============================================================

  /// 🔹 Get chat references for user
  Future<List<String>> getChats(String id) async {
    try {
      final res = await _dio.get("/$id/chats");
      return List<String>.from(res.data.map((e) => e.toString()));
    } on DioException catch (e) {
      throw Exception(
        "Failed to fetch chats: ${e.response?.data ?? e.message}",
      );
    }
  }

  /// 🔹 Add chat reference
  Future<List<String>> addChat(String id, String chatId) async {
    try {
      final res = await _dio.post("/$id/chats", data: {"chatId": chatId});
      return List<String>.from(res.data["chats"]);
    } on DioException catch (e) {
      throw Exception("Failed to add chat: ${e.response?.data ?? e.message}");
    }
  }

  // =============================================================
  // 🧭 ACCOUNT STATUS
  // =============================================================

  /// 🔹 Update user status (ACTIVE / DEACTIVATED / SUSPENDED)
  Future<void> updateAccountStatus(String id, String status) async {
    try {
      await _dio.patch("/$id/status", data: {"status": status});
    } on DioException catch (e) {
      throw Exception(
        "Failed to update status: ${e.response?.data ?? e.message}",
      );
    }
  }
}
