import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:v1/models/category_model.dart';
import 'package:v1/utils/colorManagement.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../prefs/theme.dart';
import '../widgets/MiniVideoCard.dart';

class CategoryListTile extends StatefulWidget {
  const CategoryListTile({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  final videos = [
    {
      "video": "assets/placeholders/videos/1.mp4",
      "thumbnail": "assets/placeholders/thumbnails/1.png",
    },
    {
      "video": "assets/placeholders/videos/2.mp4",
      "thumbnail": "assets/placeholders/thumbnails/2.png",
    },
    {
      "video": "assets/placeholders/videos/3.mp4",
      "thumbnail": "assets/placeholders/thumbnails/3.png",
    },
    {
      "video": "assets/placeholders/videos/4.mp4",
      "thumbnail": "assets/placeholders/thumbnails/4.png",
    },
    {
      "video": "assets/placeholders/videos/5.mp4",
      "thumbnail": "assets/placeholders/thumbnails/5.png",
    },
    {
      "video": "assets/placeholders/videos/6.mp4",
      "thumbnail": "assets/placeholders/thumbnails/6.png",
    },
    {
      "video": "assets/placeholders/videos/7.mp4",
      "thumbnail": "assets/placeholders/thumbnails/7.png",
    },
    {
      "video": "assets/placeholders/videos/8.mp4",
      "thumbnail": "assets/placeholders/thumbnails/8.png",
    },
    {
      "video": "assets/placeholders/videos/9.mp4",
      "thumbnail": "assets/placeholders/thumbnails/9.png",
    },
    {
      "video": "assets/placeholders/videos/10.mp4",
      "thumbnail": "assets/placeholders/thumbnails/10.png",
    },
  ];

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size mqs = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return VisibilityDetector(
      key: widget.key ?? Key(widget.category.id ?? ""),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },

      child: Container(
        padding: const EdgeInsets.only(top: 12),
        width: mqs.width,
        height: mqs.height * 0.35,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: mqs.width * 0.96,
                      maxHeight: mqs.height * 0.32,
                    ),
                    width: double.infinity,

                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: mqs.width,
                height: mqs.height * 0.32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: mqs.width * 0.05,
                        top: mqs.height * 0.025,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: mqs.width * 0.15,
                            height: mqs.width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colormanagement.hexStringToColor(
                                widget.category.specialColor!,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Image.network(
                                  "${dotenv.env['API_URL']}/assets/categories/${widget.category.iconUrl!}",
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
                                widget.category.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: kEnglishPrimaryFont,
                                  color: theme.colorScheme.primaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(4),
                              Text(
                                "${widget.category.description!.substring(0, 50)}...",
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
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: mqs.height * 0.2,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Gap(12),
                          ...videos
                                  .map(
                                    (video) => Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      child: MiniVideoCard(
                                        video: video["video"]!,
                                        thumbnail: video["thumbnail"]!,
                                      ),
                                    ),
                                  )
                                  .toList()
                              as List<Widget>,
                        ],
                      ),
                    ),
                    Gap(12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
