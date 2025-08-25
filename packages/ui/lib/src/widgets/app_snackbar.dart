import 'package:another_flushbar/flushbar.dart';
import 'package:ui/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

enum AppSnackBarType { infomation, success, failure }

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    AppSnackBarType type = AppSnackBarType.infomation,
  }) {
    switch (type) {
      case AppSnackBarType.infomation:
        _AppSnackBarInner.show(
          context: context,
          message: message,
          iconData: Remix.information_2_fill,
          backgroundColor: context.appColors.primaryBase,
        );
        break;
      case AppSnackBarType.success:
        _AppSnackBarInner.show(
          context: context,
          message: message,
          iconData: Remix.checkbox_circle_fill,
          backgroundColor: context.appColors.successBase,
        );
        break;
      case AppSnackBarType.failure:
        _AppSnackBarInner.show(
          context: context,
          message: message,
          iconData: Remix.error_warning_fill,
          backgroundColor: context.appColors.errorBase,
        );
        break;
    }
  }
}

class _AppSnackBarInner {
  _AppSnackBarInner._();

  static void show({
    required BuildContext context,
    required String message,
    required IconData iconData,
    Color? backgroundColor,
    Color? messageColor,
  }) {
    backgroundColor ??= context.appColors.primaryBase;
    messageColor ??= context.appColors.staticWhite;

    final flushbar = Flushbar(
      padding: EdgeInsets.only(
        top: context.appSpacing.xs,
        left: context.appSpacing.sm,
        right: context.appSpacing.sm,
        bottom: context.appSpacing.x2s,
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageSize: context.appTypography.regular.textDefault.fontSize,
      animationDuration: const Duration(milliseconds: 300),
      messageText: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.appSpacing.x6s),
              child: Icon(
                iconData,
                color: context.appColors.staticWhite,
                size: context.appTypography.regular.text16.fontSize,
              ),
            ),
            SizedBox(width: context.appSpacing.x4s),
            Flexible(
              child: Text(
                message,
                style: context.appTypography.regular.textDefault.copyWith(
                  color: messageColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    flushbar.show(context);
  }
}
