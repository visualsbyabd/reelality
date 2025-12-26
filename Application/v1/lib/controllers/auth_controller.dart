import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/main.dart';
import 'package:v1/models/user_model.dart';
import 'package:v1/services/auth_service.dart';
import 'package:v1/utils/app_router.dart';

enum AuthMode {
  LOGIN,
  SIGNUP,
  COMPLETE_PROFILE,
  VERIFY_EMAIL,
  FORGOT_PASSWORD,
  RECEPTION,
}

class AuthData {
  final AuthMode mode;
  final String? email;
  final String? username;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? bio;
  final String? gender;
  final String? birthday;
  final List<String>? languages;

  AuthData({
    this.mode = AuthMode.LOGIN,
    this.email,
    this.username,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.bio,
    this.gender,
    this.birthday,
    this.languages,
  });
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthData>(
  () => AuthController(),
);

class AuthController extends AsyncNotifier<AuthData> {
  late AuthService _service;

  @override
  FutureOr<AuthData> build() {
    _service = ref.read(authServiceProvider);
    return AuthData(mode: AuthMode.LOGIN);
  }

  Future<void> setAuthMode(AuthMode mode) async {
    final current = state.value!;
    state = AsyncData(
      AuthData(
        mode: mode,
        email: current.email,
        username: current.username,
        password: current.password,
        firstName: current.firstName,
        lastName: current.lastName,
        phone: current.phone,
        bio: current.bio,
        gender: current.gender,
        birthday: current.birthday,
        languages: current.languages,
      ),
    );
  }

  Future<void> updateAuthData({
    String? email,
    String? username,
    String? password,
    String? firstName,
    String? lastName,
    String? phone,
    String? bio,
    String? gender,
    String? birthday,
    List<String>? languages,
  }) async {
    final current = state.value!;
    state = AsyncData(
      AuthData(
        mode: current.mode,
        email: email ?? current.email,
        username: username ?? current.username,
        password: password ?? current.password,
        firstName: firstName ?? current.firstName,
        lastName: lastName ?? current.lastName,
        phone: phone ?? current.phone,
        bio: bio ?? current.bio,
        gender: gender ?? current.gender,
        birthday: birthday ?? current.birthday,
        languages: languages ?? current.languages,
      ),
    );
  }

  Future<int> login({required String email, required String password}) async {
    try {
      final authResult = await _service.login(email: email, password: password);
      switch (authResult["statusCode"]) {
        case 1:
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            "userId",
            (authResult["user"] as UserModel).id!,
          );

          return authResult["statusCode"];
        default:
          return authResult["statusCode"];
      }
    } catch (e) {
      print(e);
      return -2;
    }
  }
}
