import 'package:flutter/material.dart';
import 'package:v1/prefs/theme.dart';

class SecondaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget? prefixIcon, suffixIcon;
  const SecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size mqs = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border: BoxBorder.all(
          width: 2,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
      ),
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: WidgetStateColor.transparent),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.prefixIcon!,
            Text(
              widget.title,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            widget.suffixIcon!,
          ],
        ),
      ),
    );
  }
}
