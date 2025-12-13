import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../providers/user_provider.dart';

/// Controller to manage user state and business logic.
/// This acts like a ViewModel (MVVM pattern).
class UserController extends AsyncNotifier<UserModel?> {
  late UserService _userService;
  late String userId;
  late UserModel currentUser;

  @override
  FutureOr<UserModel?> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';

    _userService = ref.read(userServiceProvider);
    await loadCurrentUser();
    return state.value;
  }

  /// Log in (future integration with auth service)
  Future<void> loadUser(String id) async {
    state = const AsyncLoading();
    try {
      final user = await _userService.getUserById(id);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadCurrentUser() async {
    state = const AsyncLoading();
    try {
      final user = await _userService.getUserById(userId);
      currentUser = user;
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Update user profile
  Future<void> updateUser(String id, Map<String, dynamic> updates) async {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncLoading();
    try {
      final updatedUser = await _userService.updateUser(id, updates);
      state = AsyncData(updatedUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Refresh user data
  Future<void> refreshUser() async {
    final current = state.valueOrNull;
    if (current == null) return;
    await loadUser(current.id!);
  }

  /// Follow / Unfollow (updates local state immediately)
  Future<void> toggleFollow(String targetId, bool isFollowing) async {
    final current = state.valueOrNull;
    if (current == null) return;

    try {
      if (isFollowing) {
        await _userService.unfollowUser(targetId, current.id!);
      } else {
        await _userService.followUser(targetId, current.id!);
      }
      await refreshUser();
    } catch (e) {
      rethrow;
    }
  }

  /// Deactivate / Suspend account (admin feature)
  Future<void> updateAccountStatus(String status) async {
    final current = state.valueOrNull;
    if (current == null) return;
    await _userService.updateAccountStatus(current.id!, status);
    await refreshUser();
  }
}
