import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:v1/prefs/theme.dart';

class PrimaryIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isActive, isLoading;

  const PrimaryIconButton({
    super.key,
    this.isLoading = false,
    required this.onPressed,
    required this.icon,
    this.isActive = false,
  });

  @override
  State<PrimaryIconButton> createState() => _PrimaryIconButtonState();
}

class _PrimaryIconButtonState extends State<PrimaryIconButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size mqs = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 2, color: theme.colorScheme.primary),
        shape: BoxShape.circle,
        color: widget.isActive
            ? theme.colorScheme.surface
            : theme.colorScheme.primary,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.transparent,
          shadowColor: WidgetStateColor.transparent,
        ),
        onPressed: () {
          if (!widget.isLoading) {
            widget.onPressed();
          }
        },
        child: FaIcon(
          widget.icon,
          size: 24,
          color: widget.isActive
              ? theme.colorScheme.primary
              : theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
