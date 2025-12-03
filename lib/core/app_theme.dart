import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test_app/core/gen/colors.gen.dart';

class AppColors {
  static const primary = Color(0xFF3B6CFF);
  static const background = Colors.white;
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const error = Color(0xFFF97316);
  static const success = Color(0xFF22C55E);
  static const disabled = Color(0xFFD4D4D8);
}

class AppTextStyles {
  static TextStyle get title => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    color: ColorName.woodsmoke,
  );

  static TextStyle get subtitle => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: ColorName.emperor,
  );

  static TextStyle get sectionTitle => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: ColorName.woodsmoke,
  );

  static TextStyle get fieldValue => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ColorName.woodsmoke,
  );

  static TextStyle get hint => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorName.emperor,
  );

  static TextStyle get small =>
      TextStyle(fontSize: 13.sp, height: 1.5, color: ColorName.emperor);

  static TextStyle get bottomBrand =>
      TextStyle(fontSize: 14.sp, color: ColorName.emperor);
}

class AppTheme {
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
