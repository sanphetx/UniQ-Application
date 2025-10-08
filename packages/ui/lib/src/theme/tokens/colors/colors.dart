// lib/src/theme/tokens/colors/app_colors.dart
import 'package:flutter/material.dart';
import 'package:ui/src/theme/tokens/colors/color_palette.dart';

final class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.staticBlack,
    required this.staticWhite,
    required this.primaryBase,
    required this.bgStrong950,
    required this.bgSurface800,
    required this.bgSub300,
    required this.bgSoft200,
    required this.bgWeak50,
    required this.bgWhite0,
    required this.textStrong950,
    required this.textSub600,
    required this.textSoft400,
    required this.textDisabled300,
    required this.textWhite0,
    required this.strokeStrong950,
    required this.strokeSub300,
    required this.strokeSoft200,
    required this.strokeWhite0,
    required this.informationDark,
    required this.informationBase,
    required this.informationLight,
    required this.informationLighter,
    required this.warningDark,
    required this.warningBase,
    required this.warningLight,
    required this.warningLighter,
    required this.errorDark,
    required this.errorBase,
    required this.errorLight,
    required this.errorLighter,
    required this.successDark,
    required this.successBase,
    required this.successLight,
    required this.successLighter,
  });

  final Color staticBlack;
  final Color staticWhite;
  final Color primaryBase;
  final Color bgStrong950;
  final Color bgSurface800;
  final Color bgSub300;
  final Color bgSoft200;
  final Color bgWeak50;
  final Color bgWhite0;
  final Color textStrong950;
  final Color textSub600;
  final Color textSoft400;
  final Color textDisabled300;
  final Color textWhite0;
  final Color strokeStrong950;
  final Color strokeSub300;
  final Color strokeSoft200;
  final Color strokeWhite0;
  final Color informationDark;
  final Color informationBase;
  final Color informationLight;
  final Color informationLighter;
  final Color warningDark;
  final Color warningBase;
  final Color warningLight;
  final Color warningLighter;
  final Color errorDark;
  final Color errorBase;
  final Color errorLight;
  final Color errorLighter;
  final Color successDark;
  final Color successBase;
  final Color successLight;
  final Color successLighter;

  static const light = AppColors(
    // Static colors
    staticBlack: ColorPalette.black04,
    staticWhite: ColorPalette.white01,

    // Brand colors
    primaryBase: ColorPalette.primaryPink,

    // Background colors
    bgStrong950: ColorPalette.black02,
    bgSurface800: ColorPalette.black01,
    bgSub300: ColorPalette.grey03,
    bgSoft200: ColorPalette.grey02,
    bgWeak50: ColorPalette.grey01,
    bgWhite0: ColorPalette.white01,

    // Text colors
    textStrong950: ColorPalette.black02,
    textSub600: ColorPalette.grey06,
    textSoft400: ColorPalette.grey05,
    textDisabled300: ColorPalette.grey03,
    textWhite0: ColorPalette.white01,

    // Stroke colors
    strokeStrong950: ColorPalette.black01,
    strokeSub300: ColorPalette.grey03,
    strokeSoft200: ColorPalette.grey02,
    strokeWhite0: ColorPalette.white01,

    // Informational colors
    informationDark: ColorPalette.blue06,
    informationBase: ColorPalette.primaryBlue05,
    informationLight: ColorPalette.blue03,
    informationLighter: ColorPalette.blue01,

    // Warning colors
    warningDark: ColorPalette.yellow06,
    warningBase: ColorPalette.primaryYellow05,
    warningLight: ColorPalette.yellow03,
    warningLighter: ColorPalette.yellow01,

    // Error colors
    errorDark: ColorPalette.red06,
    errorBase: ColorPalette.primaryRed05,
    errorLight: ColorPalette.red03,
    errorLighter: ColorPalette.red01,

    // Success colors
    successDark: ColorPalette.green400,
    successBase: ColorPalette.green300,
    successLight: ColorPalette.green100,
    successLighter: ColorPalette.green50,
  );

  @override
  AppColors copyWith({
    Color? staticBlack,
    Color? staticWhite,
    Color? primaryBase,
    Color? bgStrong950,
    Color? bgSurface800,
    Color? bgSub300,
    Color? bgSoft200,
    Color? bgWeak50,
    Color? bgWhite0,
    Color? textStrong950,
    Color? textSub600,
    Color? textSoft400,
    Color? textDisabled300,
    Color? textWhite0,
    Color? strokeStrong950,
    Color? strokeSub300,
    Color? strokeSoft200,
    Color? strokeWhite0,
    Color? informationDark,
    Color? informationBase,
    Color? informationLight,
    Color? informationLighter,
    Color? warningDark,
    Color? warningBase,
    Color? warningLight,
    Color? warningLighter,
    Color? errorDark,
    Color? errorBase,
    Color? errorLight,
    Color? errorLighter,
    Color? successDark,
    Color? successBase,
    Color? successLight,
    Color? successLighter,
  }) {
    return AppColors(
      staticBlack: staticBlack ?? this.staticBlack,
      staticWhite: staticWhite ?? this.staticWhite,
      primaryBase: primaryBase ?? this.primaryBase,
      bgStrong950: bgStrong950 ?? this.bgStrong950,
      bgSurface800: bgSurface800 ?? this.bgSurface800,
      bgSub300: bgSub300 ?? this.bgSub300,
      bgSoft200: bgSoft200 ?? this.bgSoft200,
      bgWeak50: bgWeak50 ?? this.bgWeak50,
      bgWhite0: bgWhite0 ?? this.bgWhite0,
      textStrong950: textStrong950 ?? this.textStrong950,
      textSub600: textSub600 ?? this.textSub600,
      textSoft400: textSoft400 ?? this.textSoft400,
      textDisabled300: textDisabled300 ?? this.textDisabled300,
      textWhite0: textWhite0 ?? this.textWhite0,
      strokeStrong950: strokeStrong950 ?? this.strokeStrong950,
      strokeSub300: strokeSub300 ?? this.strokeSub300,
      strokeSoft200: strokeSoft200 ?? this.strokeSoft200,
      strokeWhite0: strokeWhite0 ?? this.strokeWhite0,
      informationDark: informationDark ?? this.informationDark,
      informationBase: informationBase ?? this.informationBase,
      informationLight: informationLight ?? this.informationLight,
      informationLighter: informationLighter ?? this.informationLighter,
      warningDark: warningDark ?? this.warningDark,
      warningBase: warningBase ?? this.warningBase,
      warningLight: warningLight ?? this.warningLight,
      warningLighter: warningLighter ?? this.warningLighter,
      errorDark: errorDark ?? this.errorDark,
      errorBase: errorBase ?? this.errorBase,
      errorLight: errorLight ?? this.errorLight,
      errorLighter: errorLighter ?? this.errorLighter,
      successDark: successDark ?? this.successDark,
      successBase: successBase ?? this.successBase,
      successLight: successLight ?? this.successLight,
      successLighter: successLighter ?? this.successLighter,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      staticBlack: Color.lerp(staticBlack, other.staticBlack, t)!,
      staticWhite: Color.lerp(staticWhite, other.staticWhite, t)!,
      primaryBase: Color.lerp(primaryBase, other.primaryBase, t)!,
      bgStrong950: Color.lerp(bgStrong950, other.bgStrong950, t)!,
      bgSurface800: Color.lerp(bgSurface800, other.bgSurface800, t)!,
      bgSub300: Color.lerp(bgSub300, other.bgSub300, t)!,
      bgSoft200: Color.lerp(bgSoft200, other.bgSoft200, t)!,
      bgWeak50: Color.lerp(bgWeak50, other.bgWeak50, t)!,
      bgWhite0: Color.lerp(bgWhite0, other.bgWhite0, t)!,
      textStrong950: Color.lerp(textStrong950, other.textStrong950, t)!,
      textSub600: Color.lerp(textSub600, other.textSub600, t)!,
      textSoft400: Color.lerp(textSoft400, other.textSoft400, t)!,
      textDisabled300: Color.lerp(textDisabled300, other.textDisabled300, t)!,
      textWhite0: Color.lerp(textWhite0, other.textWhite0, t)!,
      strokeStrong950: Color.lerp(strokeStrong950, other.strokeStrong950, t)!,
      strokeSub300: Color.lerp(strokeSub300, other.strokeSub300, t)!,
      strokeSoft200: Color.lerp(strokeSoft200, other.strokeSoft200, t)!,
      strokeWhite0: Color.lerp(strokeWhite0, other.strokeWhite0, t)!,
      informationDark: Color.lerp(informationDark, other.informationDark, t)!,
      informationBase: Color.lerp(informationBase, other.informationBase, t)!,
      informationLight: Color.lerp(informationLight, other.informationLight, t)!,
      informationLighter: Color.lerp(informationLighter, other.informationLighter, t)!,
      warningDark: Color.lerp(warningDark, other.warningDark, t)!,
      warningBase: Color.lerp(warningBase, other.warningBase, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      warningLighter: Color.lerp(warningLighter, other.warningLighter, t)!,
      errorDark: Color.lerp(errorDark, other.errorDark, t)!,
      errorBase: Color.lerp(errorBase, other.errorBase, t)!,
      errorLight: Color.lerp(errorLight, other.errorLight, t)!,
      errorLighter: Color.lerp(errorLighter, other.errorLighter, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      successBase: Color.lerp(successBase, other.successBase, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successLighter: Color.lerp(successLighter, other.successLighter, t)!,
    );
  }
}