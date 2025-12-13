import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:v1/prefs/theme.dart';

class DefaultAppBar extends StatelessWidget {
  final bool showBackButton;
  const DefaultAppBar({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.5),
            Colors.black.withValues(alpha: 0),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Placeholder
            Builder(
              builder: (_) {
                if (!showBackButton) {
                  return Container();
                }
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: kCreamLight),
                );
              },
            ),
            // Logo
            Text(
              "Reelality",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'AFSobremesa',
                fontSize: 24,
                color: kCreamLight,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            // Right Icons
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 48,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/icons/search.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          kCreamLight,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Gap(4),
                  SizedBox(
                    width: 40,
                    height: 48,
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/notification.svg",
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              kCreamLight,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Badge(
                            largeSize: 12,
                            smallSize: 12,
                            textColor: kCreamLight,
                            backgroundColor: theme.colorScheme.primary,
                            alignment: Alignment.topRight,
                            label: Text(
                              "6",
                              style: TextStyle(
                                color: theme.colorScheme.surface,
                                fontSize: 14,
                                fontFamily: kEnglishPrimaryFont,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
