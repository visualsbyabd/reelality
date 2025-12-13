import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v1/components/BottomNavBar.dart';
import 'package:v1/components/DefaultAppBar.dart';
import 'package:v1/providers/user_provider.dart';
import 'package:v1/screens/LoadingScreen.dart';
import 'package:v1/screens/ProfileScreen.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final PageController pagesController;

  const ProfilePage({super.key, required this.pagesController});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            userAsync.when(
              data: (user) {
                if (user == null) {
                  return const LoadingScreen(message: "Loading Profile");
                }
                return ProfileScreen(user: user);
              },
              loading: () => const LoadingScreen(message: "Loading Profile"),
              error: (err, _) => Center(child: Text("Error: $err")),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.025,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: BottomNavbar(pagesController: widget.pagesController),
            ),
            Positioned(top: 0, child: DefaultAppBar()),
          ],
        ),
      ),
    );
  }
}
