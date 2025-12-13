import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/prefs/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:v1/utils/app_router.dart';

final AppRouter router = AppRouter();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', '6929dbed9fe1f8c8f3e5afa8');

  runApp(ProviderScope(child: ReelalityApp()));
}

class ReelalityApp extends StatelessWidget {
  const ReelalityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      title: 'Reelality',
      theme: buildDarkTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
