import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v1/components/BottomNavBar.dart';
import 'package:v1/components/DefaultAppBar.dart';
import 'package:v1/controllers/category_controller.dart';
import 'package:v1/screens/CategoriesScreen.dart';
import 'package:v1/screens/LoadingScreen.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  final PageController pagesController;

  const CategoriesPage({super.key, required this.pagesController});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final categoriesAsync = ref.watch(categoryControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            categoriesAsync.when(
              data: (categories) {
                if (categories.isEmpty) {
                  return const LoadingScreen(message: "Loading Categories");
                }
                // Precache all category images using context here
                for (final cat in categories) {
                  if (cat.iconUrl != null && cat.iconUrl!.isNotEmpty) {
                    precacheImage(
                      CachedNetworkImageProvider(
                        "${dotenv.env["API_URL"]!}${cat.iconUrl!}",
                      ),
                      context,
                    );
                  }
                }

                return CategoriesScreen();
              },
              loading: () => const LoadingScreen(message: "Loading Categories"),
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
