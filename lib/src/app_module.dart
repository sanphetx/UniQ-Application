import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart' hide State;
import 'package:ui/ui.dart';
import 'package:uni_q_application/src/presentation/router/router.dart';

final globalBlocProviders = <BlocProvider>[];

class AppModule {
  AppModule._();

  static Future<void> init() async {
    final List<BaseModule> modules = [CoreModule(), AuthModule()];

    for (final module in modules) {
     await module.init();
    }
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          extensions: <ThemeExtension<dynamic>>[AppTheme(tokens: AppTokens.light)],
        ),
        builder: (context, child) => child!,
      ),
    );
  }
}
