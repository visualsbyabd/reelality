import 'package:flutter/material.dart';

class PrimaryIconDropdownMenu extends StatefulWidget {
  final Widget icon;
  final List<DropdownOption> options;
  final double? elevation;
  final double? borderRadius;

  const PrimaryIconDropdownMenu({
    super.key,
    required this.icon,
    required this.options,
    this.elevation,
    this.borderRadius,
  });

  @override
  State<PrimaryIconDropdownMenu> createState() =>
      _PrimaryIconDropdownMenuState();
}

class _PrimaryIconDropdownMenuState extends State<PrimaryIconDropdownMenu> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleMenu(BuildContext context) {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu(context);
    }
  }

  void _openMenu(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final Size mqs = MediaQuery.of(context).size;
        return Positioned(
          right: mqs.width * 0.1,
          top: position.dy + size.height + 16,
          child: Material(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.options.map((option) {
                    return InkWell(
                      onTap: () {
                        option.onPressed();
                        _closeMenu();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        child: Text(
                          option.label,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 2, color: theme.colorScheme.primary),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: theme.colorScheme.primary,
      ),
      child: GestureDetector(
        key: _menuKey,
        onTap: () {
          _toggleMenu(context);
        },
        child: Padding(padding: EdgeInsets.all(8), child: widget.icon),
      ),
    );
  }
}

/// Represents an item inside the dropdown menu.
/// Each option has a [label] and [onPressed] callback.
class DropdownOption {
  final String label;
  final VoidCallback onPressed;

  const DropdownOption({required this.label, required this.onPressed});
}
