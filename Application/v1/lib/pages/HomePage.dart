import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:v1/pages/CategoriesPage.dart';
import 'package:v1/pages/DiscoverPage.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/pages/ProfilePage.dart';

class HomePage extends StatelessWidget {
  final int initialPage;
  const HomePage({super.key, @PathParam('initialPage') this.initialPage = 2});

  @override
  Widget build(BuildContext context) {
    PageController pagesController = PageController(initialPage: initialPage);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pagesController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomeScreen(pagesController: pagesController),
        DiscoverPage(pagesController: pagesController),
        CategoriesPage(pagesController: pagesController),
        ProfilePage(pagesController: pagesController),
      ],
    );
  }
}
