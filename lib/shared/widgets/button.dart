import 'package:flutter/material.dart';

import '../../config/config.dart';

abstract class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool haveShadow;
  final bool fullWidth;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  const Button({
    super.key,
    required this.title,
    this.onPressed,
    this.haveShadow = false,
    this.fullWidth = false,
    this.padding = const EdgeInsets.all(0),
    this.textStyle = const TextStyle(),
  });
}

class PrimaryButton extends Button {
  const PrimaryButton({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    bool haveShadow = false,
    bool fullWidth = false,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
    TextStyle textStyle = const TextStyle(),
  }) : super(
          key: key,
          title: title,
          onPressed: onPressed,
          haveShadow: haveShadow,
          fullWidth: fullWidth,
          padding: padding,
          textStyle: textStyle,
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          App.theme.colors.primary.yellow,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all(
          padding,
        ),
        shadowColor: MaterialStateProperty.all(
          haveShadow ? App.theme.colors.primary.grey : Colors.transparent,
        ),
        elevation: MaterialStateProperty.all(
          haveShadow ? 2 : 0,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}
