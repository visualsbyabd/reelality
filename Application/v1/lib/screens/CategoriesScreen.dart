import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:v1/controllers/category_controller.dart';
import 'package:v1/models/category_model.dart';
import 'package:v1/prefs/theme.dart';
import 'package:v1/utils/colorManagement.dart';
import 'package:v1/widgets/FeaturedCategoryCard.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size mqs = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final List<CategoryModel> allCategories = ref
        .read(categoryControllerProvider)
        .valueOrNull!;
    final featuredCategories = allCategories.where(
      (category) => category.isFeatured ?? false,
    );
    return Stack(
      children: [
        // Featured Categories
        SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(top: mqs.height * 0.05),
            width: mqs.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
                  child: Text(
                    "Featured Categories",
                    style: TextStyle(
                      fontSize: 24,
                      color: theme.colorScheme.primary,
                      fontFamily: kEnglishPrimaryFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  width: mqs.width,
                  height: mqs.height * 0.3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          featuredCategories
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => FeaturedCategoryCard(
                                      category: entry.value,
                                      indexKey: entry.key,
                                    ),
                                  )
                                  .toList()
                              as List<Widget>,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: Text(
                    "Picked for You!",
                    style: TextStyle(
                      fontSize: 24,
                      color: theme.colorScheme.primary,
                      fontFamily: kEnglishPrimaryFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  width: mqs.width,
                  height: mqs.height * 0.3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          ref
                                  .read(categoryControllerProvider)
                                  .valueOrNull!
                                  .where((category) => !category.isFeatured!)
                                  .toList()
                                  .sublist(0, 5)
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => FeaturedCategoryCard(
                                      category: entry.value,
                                      indexKey: entry.key,
                                    ),
                                  )
                                  .toList()
                              as List<Widget>,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
                  child: Text(
                    "All Categories",
                    style: TextStyle(
                      fontSize: 24,
                      color: theme.colorScheme.primary,
                      fontFamily: kEnglishPrimaryFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Gap(8),
                for (CategoryModel category in allCategories)
                  Container(
                    width: mqs.width,
                    height: mqs.height * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: mqs.width * 0.15,
                              height: mqs.width * 0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colormanagement.hexStringToColor(
                                  category.specialColor!,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Image.network(
                                    "${dotenv.env['API_URL']}/assets/categories/${category.iconUrl!}",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Gap(8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: kEnglishPrimaryFont,
                                    color: theme.colorScheme.primaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(4),
                                Text(
                                  "${category.description!.substring(0, 50)}...",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: kEnglishSecondaryFont,
                                    color: theme.colorScheme.secondaryContainer,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
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
      ],
    );
  }
}
