import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:v1/components/CategoryListTile.dart';
import 'package:v1/controllers/category_controller.dart';
import 'package:v1/models/category_model.dart';
import 'package:v1/prefs/theme.dart';
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
        Container(
          margin: EdgeInsets.only(top: mqs.height * 0.05),
          width: mqs.width,
          child: ListView(
            controller: scrollController,
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
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
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
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
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
              SizedBox(
                height:
                    allCategories.length * (mqs.height * 0.35) +
                    mqs.height * 0.15,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryListTile(category: allCategories[index]);
                  },
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
      ],
    );
  }
}
