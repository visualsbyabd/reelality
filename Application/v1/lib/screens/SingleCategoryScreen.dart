import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/async_notifier.dart';
import 'package:v1/components/DefaultAppBar.dart';
import 'package:v1/controllers/category_controller.dart';
import 'package:v1/models/category_model.dart';
import 'package:v1/prefs/theme.dart';
import 'package:v1/providers/user_provider.dart';
import 'package:v1/screens/LoadingScreen.dart';
import 'package:v1/screens/NotFoundScreen.dart';
import 'package:v1/utils/cache_manager.dart';
import 'package:v1/utils/colorManagement.dart';
import 'package:v1/widgets/PrimaryButton.dart';

@routePage
class SingleCategoryPage extends ConsumerStatefulWidget {
  final String categoryId;
  const SingleCategoryPage({super.key, required this.categoryId});

  @override
  ConsumerState<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends ConsumerState<SingleCategoryPage> {
  late String searchParamter;
  late bool isScrolled;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    isScrolled = false;
    scrollController.addListener(() {
      setState(() {
        isScrolled = scrollController.offset > 100;
      });
    });
    setState(() {
      searchParamter = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size mqs = MediaQuery.of(context).size;
    final List<CategoryModel> allCategories = ref
        .read(categoryControllerProvider)
        .valueOrNull!;
    final currentUser = ref.read(currentUserProvider).valueOrNull;

    return SafeArea(
      child: Builder(
        builder: (context) {
          return FutureBuilder<CategoryModel?>(
            future: Future<CategoryModel?>(() async {
              return allCategories.firstWhere(
                (cat) => cat.id == widget.categoryId,
              );
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen(message: "Loading Category");
              }
              final category = snapshot.data;
              if (category == null) {
                return NotFoundscreen(message: "Category Not Found");
              }
              print(
                "Banner: ${"${dotenv.env["API_URL"]!}${category.bannerUrl}"}",
              );
              return Scaffold(
                body: Stack(
                  children: [
                    SizedBox(
                      height: mqs.height,
                      width: mqs.width,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          SizedBox(
                            width: mqs.width,
                            height: mqs.height * 0.35,
                            child: Stack(
                              children: [
                                Container(
                                  width: mqs.width,
                                  height: mqs.height * 0.215,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${dotenv.env["API_URL"]!}/assets/categories/${category.bannerUrl}",
                                    height: mqs.height * 0.3,
                                    width: mqs.width,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) =>
                                        const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                    errorWidget: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                    fadeInDuration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    memCacheWidth: 512,
                                    memCacheHeight: 512,
                                    cacheManager: AppCacheManager.instance,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: mqs.height * 0.125,
                                                height: mqs.height * 0.125,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: theme
                                                        .colorScheme
                                                        .surface,
                                                    width: 4,
                                                  ),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: Colormanagement.generateGradient(
                                                      Colormanagement.hexStringToColor(
                                                        category.specialColor!,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12,
                                                  ),
                                                  child: Hero(
                                                    tag:
                                                        "category_icon_${category.id}",
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${dotenv.env["API_URL"]!}/assets/categories/${category.iconUrl}",
                                                      fit: BoxFit.contain,
                                                      placeholder: (_, __) =>
                                                          const CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                      errorWidget:
                                                          (
                                                            _,
                                                            __,
                                                            ___,
                                                          ) => const Icon(
                                                            Icons.broken_image,
                                                          ),
                                                      fadeInDuration:
                                                          const Duration(
                                                            milliseconds: 300,
                                                          ),
                                                      memCacheWidth: 512,
                                                      memCacheHeight: 512,
                                                      cacheManager:
                                                          AppCacheManager
                                                              .instance,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                category.name,
                                                style: TextStyle(
                                                  fontFamily:
                                                      kEnglishPrimaryFont,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      theme.colorScheme.primary,
                                                ),
                                              ),
                                              Text(
                                                category.description!,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontFamily:
                                                      kEnglishSecondaryFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: theme
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        NotificationListener(
                                          child:
                                              !category.isFollowedByUser(
                                                currentUser!.id,
                                              )
                                              ? PrimaryButton(
                                                  prefixIcon: Container(),
                                                  suffixIcon: Container(),
                                                  isActive: true,
                                                  title: "Unfollow",
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                          categoryControllerProvider
                                                              .notifier,
                                                        )
                                                        .unfollowCategory(
                                                          category.id,
                                                          currentUser.id,
                                                        );
                                                  },
                                                )
                                              : PrimaryButton(
                                                  prefixIcon: Container(),
                                                  suffixIcon: Container(),
                                                  isActive: false,
                                                  title: "Follow",
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                          categoryControllerProvider
                                                              .notifier,
                                                        )
                                                        .followCategory(
                                                          category.id,
                                                          currentUser.id,
                                                        );
                                                  },
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: mqs.width,
                        height: mqs.height * 0.08,
                        decoration: BoxDecoration(
                          color: isScrolled
                              ? theme.colorScheme.surface
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    Positioned(top: 0, child: DefaultAppBar()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
