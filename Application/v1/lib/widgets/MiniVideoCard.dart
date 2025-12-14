import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:v1/prefs/theme.dart';

class MiniVideoCard extends StatelessWidget {
  final String video;
  final String thumbnail;
  const MiniVideoCard({
    super.key,
    required this.video,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    final Size mqs = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {},

      child: Container(
        clipBehavior: Clip.hardEdge,
        height: mqs.height * 0.18,
        width: mqs.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(thumbnail),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: mqs.width * 0.3,
                height: mqs.height * 0.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kSecondaryDark,
                      kSecondaryDark.withValues(alpha: 0),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [0, 0.9],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
