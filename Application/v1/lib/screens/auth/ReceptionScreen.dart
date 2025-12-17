import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v1/controllers/auth_controller.dart';
import 'package:v1/widgets/PrimaryButton.dart';

class ReceptionScreen extends ConsumerStatefulWidget {
  const ReceptionScreen({super.key});

  @override
  ConsumerState<ReceptionScreen> createState() => _ReceptionScreenState();
}

class _ReceptionScreenState extends ConsumerState<ReceptionScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider.notifier);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Reception Page")),
          Row(
            children: [
              PrimaryButton(
                onPressed: () {
                  authController.setAuthMode(AuthMode.SIGNUP);
                },
                title: "Signup Page",
              ),
              PrimaryButton(
                onPressed: () {
                  authController.setAuthMode(AuthMode.SIGNUP);
                },
                title: "Login Page",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
