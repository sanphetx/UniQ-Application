import 'dart:async';
import 'package:core/core.dart';
import 'package:core/src/models/token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_q_application/src/app_module.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppModule.init();
      await AppEnvironment.initConfig();

      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      FlutterError.onError = (details) {
        if (kDebugMode) {
          FlutterError.dumpErrorToConsole(details);
        } else {
          // TODO: Send error to crash reporting service
        }
      };

      runApp(const App());
    },
    (error, stackTrace) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(FlutterErrorDetails(exception: error, stack: stackTrace));
      } else {
        // TODO: Log to crash reporting service
      }
    },
  );
}
