import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:v1/prefs/theme.dart';

class MorphSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final double width, height;

  const MorphSwitch({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.width = 50.0,
    this.height = 30.0,
  });

  @override
  State<MorphSwitch> createState() => _MorphSwitchState();
}

class _MorphSwitchState extends State<MorphSwitch>
    with SingleTickerProviderStateMixin {
  final _controller = ValueNotifier<bool>(false);
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: _controller,
      activeColor: kPrimaryLight,
      inactiveColor: kCreamDark,
      borderRadius: BorderRadius.all(const Radius.circular(15)),
      width: widget.width,
      height: widget.height,
      enabled: true,
      disabledOpacity: 0.5,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
