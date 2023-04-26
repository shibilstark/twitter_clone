import 'package:flutter/material.dart';
import 'package:twitter_clone/config/config.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor = Palette.whiteColor,
    this.foregroundColor = Palette.backgroundColor,
  });
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: backgroundColor,
      onPressed: onTap,
      child: Text(
        "Done",
        style: TextStyle(
          color: foregroundColor,
          fontSize: AppFontSize.bodySmall,
        ),
      ),
    );
  }
}
