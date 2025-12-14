import 'package:auto_route/auto_route.dart';
import 'package:v1/pages/HomePage.dart';
import 'package:v1/screens/SingleCategoryScreen.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: "HomePagePath",
      path: "/",
      initial: true,
      builder: (context, data) {
        return HomePage();
      },
    ),
    NamedRouteDef(
      name: "CategoryPath",
      path: "/category/:categoryId",
      builder: (context, data) {
        return SingleCategoryPage(
          categoryId: data.params.getString("categoryId"),
        );
      },
    ),
  ];
}
