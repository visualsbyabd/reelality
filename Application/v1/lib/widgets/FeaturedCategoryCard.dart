import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:v1/models/category_model.dart';
import 'package:v1/prefs/theme.dart';
import 'package:v1/utils/cache_manager.dart';
import 'package:v1/utils/colorManagement.dart';
import 'package:v1/utils/formatters.dart';

class FeaturedCategoryCard extends StatelessWidget {
  final int indexKey;
  final CategoryModel category;
  const FeaturedCategoryCard({
    super.key,
    required this.category,
    this.indexKey = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Size mqs = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).pushPath("/category/${category.id}");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: mqs.width * 0.01),
        constraints: BoxConstraints(
          maxHeight: mqs.height * 0.25,
          maxWidth: mqs.width * 0.8,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(
            colors: Colormanagement.generateGradient(
              Colormanagement.hexStringToColor(category.specialColor!),
              mode: Theme.of(context).brightness == Brightness.light
                  ? BrightnessMode.medium
                  : BrightnessMode.light,
            ),
            begin: indexKey.isEven ? Alignment.topRight : Alignment.topLeft,
            end: indexKey.isEven ? Alignment.bottomLeft : Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: mqs.width * 0.2,
                      height: mqs.width * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: theme.colorScheme.surface,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: CachedNetworkImage(
                          imageUrl:
                              "${dotenv.env['API_URL']}/assets/categories/${category.iconUrl!}",
                          // TODO: Replace with proper icon placeholder
                          placeholder: (_, __) =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                          fadeInDuration: const Duration(milliseconds: 300),
                          memCacheWidth: 512,
                          memCacheHeight: 512,
                          cacheManager: AppCacheManager.instance,
                        ),
                      ),
                    ),
                  ),
                  Gap(4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),

                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: kCream,
                        fontFamily: kEnglishPrimaryFont,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),

                    child: Text(
                      category.description!,
                      style: TextStyle(
                        color: kCream,
                        fontFamily: kEnglishSecondaryFont,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Gap(32),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: mqs.width * 0.3,
                      height: mqs.height * 0.075,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kSecondaryDark,
                            kSecondaryDark.withValues(alpha: 0),
                          ],
                          end: Alignment.centerLeft,
                          begin: Alignment.centerRight,
                          stops: [0, 0.5],
                          transform: GradientRotation(math.pi / 3),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: kCream, size: 14),
                            Gap(4),
                            Text(
                              formatNumber(category.followers!.length),
                              style: TextStyle(
                                color: kCream,
                                fontFamily: kEnglishSecondaryFont,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
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
      ),
    );
  }
}
