import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/controllers/auth_controller.dart';
import 'package:v1/pages/AuthPage.dart';
import 'package:v1/pages/HomePage.dart';
import 'package:v1/screens/SingleCategoryScreen.dart';

class AuthGaurd extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Implement your authentication logic here
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null && userId.isNotEmpty) {
      resolver.next(true); // Allow navigation
    } else {
      router.pushPath('/auth'); // Redirect to login
    }
  }
}

class NotAuthGaurd extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Implement your authentication logic here
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null || userId.isNotEmpty) {
      resolver.next(true); // Allow navigation
    } else {
      router.pushPath('/'); // Redirect to login
    }
  }
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final authGuard = AuthGaurd();
  final notAuthGuard = NotAuthGaurd();
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: "HomePagePath",
      path: "/",
      initial: true,
      guards: [authGuard],
      builder: (context, data) {
        return HomePage();
      },
    ),
    NamedRouteDef(
      name: "CategoryPath",
      guards: [authGuard],
      path: "/category/:categoryId",
      builder: (context, data) {
        return SingleCategoryPage(
          categoryId: data.params.getString("categoryId"),
        );
      },
    ),
    NamedRouteDef(
      name: "AuthPath",
      guards: [notAuthGuard],
      path: "/auth/",
      builder: (context, data) {
        return AuthPage();
      },
    ),
  ];
}
