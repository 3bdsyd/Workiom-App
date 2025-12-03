import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

/// Collection of global text styles used across the app
class AppTextStyles {
  /// Main page titles
  static TextStyle get title => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    color: ColorName.woodsmoke,
  );

  /// Subtitle or descriptive text
  static TextStyle get subtitle => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: ColorName.emperor,
  );

  /// Section header text
  static TextStyle get sectionTitle => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: ColorName.woodsmoke,
  );

  /// Field value or primary form text
  static TextStyle get fieldValue => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ColorName.woodsmoke,
  );

  /// Placeholder or hint text
  static TextStyle get hint => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorName.emperor,
  );

  /// Small helper text
  static TextStyle get small =>
      TextStyle(fontSize: 13.sp, height: 1.5, color: ColorName.emperor);

  /// Text used in bottom branding sections
  static TextStyle get bottomBrand =>
      TextStyle(fontSize: 14.sp, color: ColorName.emperor);
}

/// App-wide theme configuration
class AppTheme {
  /// Light mode theme
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: ColorName.white,
    primaryColor: ColorName.cornflowerBlue,
    useMaterial3: true,
    fontFamily: 'Rubik',
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorName.cornflowerBlue,
      primary: ColorName.cornflowerBlue,
      background: ColorName.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorName.white,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: ColorName.woodsmoke),
    ),
  );
}
