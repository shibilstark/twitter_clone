import 'package:flutter/material.dart';
import 'package:twitter_clone/config/config.dart';

class CommonAuthTextFieldWidget extends StatelessWidget {
  const CommonAuthTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.focusNode,
  });
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(
        color: Palette.whiteColor,
        fontSize: AppFontSize.bodyMedium,
      ),
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: Palette.greyColor,
            fontSize: AppFontSize.bodyMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Palette.greyColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Palette.greyColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Palette.greyColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
