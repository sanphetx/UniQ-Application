import 'package:ui/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoader {
  AppLoader._();

  static bool _isLoading = false;
  static const loadingRouteSettings = RouteSettings(name: '/loading');

  static void startLoading(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        routeSettings: loadingRouteSettings,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(context.appSpacing.x2s),
                decoration: BoxDecoration(
                  color: context.appColors.staticWhite,
                  boxShadow: context.appShadows.xs,
                  borderRadius: BorderRadius.circular(
                    context.appBorders.borderRadiusMd,
                  ),
                ),
                child: SizedBox(
                  width: context.appSpacing.xs,
                  height: context.appSpacing.xs,
                  child: CircularProgressIndicator(
                    color: context.appColors.bgStrong950,
                    backgroundColor: context.appColors.bgSoft200,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3.r,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void stopLoading(BuildContext context) {
    if (_isLoading) {
      _isLoading = false;

      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
