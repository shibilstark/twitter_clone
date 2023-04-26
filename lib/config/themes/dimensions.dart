import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontSize {
  static final bigTitle = 26.sp;
  static final titleLarge = 24.sp;
  static final titleMedium = 22.sp;
  static final titleSmall = 20.sp;
  static final bodyLarge = 18.sp;
  static final bodyMedium = 16.sp;
  static final bodySmall = 14.sp;
  static final displayLarge = 12.sp;
  static final displayMedium = 10.sp;
  static final displaySmall = 8.sp;
}

class AppFontWeight {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
}

class AppPadding {
  static const largeScreenPadding = EdgeInsets.all(20);
  static const commonScreenPadding = EdgeInsets.all(15);
  static const homePadding = EdgeInsets.symmetric(vertical: 0, horizontal: 5);
}

class WhiteSpace {
  static final gapH5 = SizedBox(height: 5.h);
  static final gapH10 = SizedBox(height: 10.h);
  static final gapH15 = SizedBox(height: 15.h);
  static final gapH20 = SizedBox(height: 20.h);
  static final gapH25 = SizedBox(height: 25.h);
  static final gapW5 = SizedBox(width: 5.h);
  static final gapW10 = SizedBox(width: 10.h);
  static final gapW15 = SizedBox(width: 15.h);
  static final gapW20 = SizedBox(width: 20.h);
  static final gapW25 = SizedBox(width: 25.h);
}
