
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/custom_keyboard.dart';
class KeyboardContainer extends StatelessWidget {
  final Widget? child;

  const KeyboardContainer({
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (child != null) Expanded(child: child!),
        const CustomKeyboard(),
      ],
    );
  }
}
