import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavbar extends StatelessWidget {
  final PageController pagesController;
  const BottomNavbar({super.key, required this.pagesController});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.075,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 1),
            blurRadius: 30,
            spreadRadius: 1,
            offset: Offset.zero,
          ),
        ],
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.015,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pagesController.jumpToPage(0);
                  },
                  icon: SvgPicture.asset(
                    pagesController.page != 0
                        ? "assets/icons/home.svg"
                        : "assets/icons/home-selected.svg",
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,

                      BlendMode.srcIn,
                    ),
                    width: 28,
                    height: 28,
                  ),
                ),
                pagesController.page == 0
                    ? Text(
                        "Home",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pagesController.jumpToPage(1);
                  },
                  icon: SvgPicture.asset(
                    pagesController.page != 1
                        ? "assets/icons/discover.svg"
                        : "assets/icons/discover-selected.svg",
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,

                      BlendMode.srcIn,
                    ),
                    width: 28,
                    height: 28,
                  ),
                ),
                pagesController.page == 1
                    ? Text(
                        "Discover",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pagesController.jumpToPage(2);
                  },
                  icon: SvgPicture.asset(
                    pagesController.page != 2
                        ? "assets/icons/category.svg"
                        : "assets/icons/category-selected.svg",
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,

                      BlendMode.srcIn,
                    ),
                    width: 28,
                    height: 28,
                  ),
                ),
                pagesController.page == 2
                    ? Text(
                        "Categories",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pagesController.jumpToPage(3);
                  },
                  icon: SvgPicture.asset(
                    pagesController.page != 3
                        ? "assets/icons/profile.svg"
                        : "assets/icons/profile-selected.svg",
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,

                      BlendMode.srcIn,
                    ),
                    width: 28,
                    height: 28,
                  ),
                ),
                pagesController.page == 3
                    ? Text(
                        "Profile",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
