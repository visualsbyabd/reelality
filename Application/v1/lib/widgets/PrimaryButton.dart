import 'package:flutter/material.dart';
import 'package:v1/prefs/theme.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget? prefixIcon, suffixIcon;
  final bool isActive;
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.isActive = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size mqs = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 2, color: theme.colorScheme.primary),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: widget.isActive
            ? theme.colorScheme.surface
            : theme.colorScheme.primary,
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
                color: widget.isActive ? theme.colorScheme.primary : kSoftBlack,
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
