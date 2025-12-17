import 'package:flutter/material.dart';
import 'package:v1/prefs/theme.dart';

class ShadowButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  const ShadowButton({super.key, required this.title, required this.onPressed});

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size mqs = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Colors.transparent,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.transparent,
          shadowColor: WidgetStateColor.transparent,
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
