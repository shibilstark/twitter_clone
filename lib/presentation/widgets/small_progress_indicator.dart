import 'package:flutter/material.dart';
import 'package:twitter_clone/config/config.dart';

class SmallProgressIndication extends StatelessWidget {
  const SmallProgressIndication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Palette.blueColor,
        strokeWidth: 2,
      ),
    );
  }
}
