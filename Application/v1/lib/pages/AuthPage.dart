import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v1/controllers/auth_controller.dart';
import 'package:riverpod/riverpod.dart';
import 'package:v1/screens/LoadingScreen.dart';
import 'package:v1/screens/NotFoundScreen.dart';
import 'package:v1/screens/auth/LoginScreen.dart';
import 'package:v1/screens/auth/ReceptionScreen.dart';
import 'package:v1/screens/auth/SignUpScreen.dart';

class AuthPage extends ConsumerStatefulWidget {
  final AuthMode? initalRouter;
  const AuthPage({super.key, this.initalRouter = AuthMode.LOGIN});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    return authController.when(
      data: (authData) {
        switch (authData.mode) {
          case AuthMode.RECEPTION:
            return ReceptionScreen();
          case AuthMode.LOGIN:
            return LoginScreen();

          case AuthMode.SIGNUP:
            return SignUpScreen();
            ;
          case AuthMode.COMPLETE_PROFILE:
            return const Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text("Complate Profile Page"))],
              ),
            );
          case AuthMode.VERIFY_EMAIL:
            return const Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text("Verify Email Page"))],
              ),
            );
          case AuthMode.FORGOT_PASSWORD:
            return const Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text("Forget Password"))],
              ),
            );
        }
      },
      error: (error, trace) {
        return NotFoundscreen(message: "error");
      },
      loading: () {
        return LoadingScreen(message: "Loading...");
      },
    );
  }
}
