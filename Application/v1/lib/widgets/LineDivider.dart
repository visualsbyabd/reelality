import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

List<Widget> lineDivider({
  required BuildContext context,
  required Color color,
}) {
  final Size mqs = MediaQuery.of(context).size;
  return [
    Gap(16),
    Container(
      height: 2,
      width: mqs.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0),
            color.withValues(alpha: 0.25),
            color.withValues(alpha: 0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    ),
    Gap(16),
  ];
}
