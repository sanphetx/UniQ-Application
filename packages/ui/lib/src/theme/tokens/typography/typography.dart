import 'package:ui/src/theme/tokens/colors/colors.dart';
import 'package:ui/src/theme/tokens/typography/text_styles.dart';
import 'package:flutter/material.dart';

final class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.lightTheme,
    required this.regular,
    required this.medium,
    required this.semiBold,
    required this.bold,
  });

  final AppTextStyles lightTheme;
  final AppTextStyles regular;
  final AppTextStyles medium;
  final AppTextStyles semiBold;
  final AppTextStyles bold;

  static final light = AppTypography(
    lightTheme: AppTextStyles.light(AppColors.light.textStrong950),
    regular: AppTextStyles.regular(AppColors.light.textStrong950),
    medium: AppTextStyles.medium(AppColors.light.textStrong950),
    semiBold: AppTextStyles.semiBold(AppColors.light.textStrong950),
    bold: AppTextStyles.bold(AppColors.light.textStrong950),
  );

  @override
  AppTypography copyWith({
    AppTextStyles? lightTheme,
    AppTextStyles? regular,
    AppTextStyles? medium,
    AppTextStyles? semiBold,
    AppTextStyles? bold,
  }) {
    return AppTypography(
      lightTheme: lightTheme ?? this.lightTheme,
      regular: regular ?? this.regular,
      medium: medium ?? this.medium,
      semiBold: semiBold ?? this.semiBold,
      bold: bold ?? this.bold,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      lightTheme: lightTheme.lerp(other.lightTheme, t),
      regular: regular.lerp(other.regular, t),
      medium: medium.lerp(other.medium, t),
      semiBold: semiBold.lerp(other.semiBold, t),
      bold: bold.lerp(other.bold, t),
    );
  }
}
