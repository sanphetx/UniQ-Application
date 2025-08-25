import 'package:auth/auth.dart';
import 'package:base_pos/src/presentation/router/route_name.dart';
import 'package:base_pos/src/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root_navigator_key');

final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: AuthRouteName.login,
    routes: <RouteBase>[...authRoutes],
  );
}

CustomTransitionPage<void> slideTransitionPage<T>({
  required Widget child,
  required GoRouterState state,
  AxisDirection direction = AxisDirection.left,
}) {
  final offsetFromDirection = switch (direction) {
    AxisDirection.up => const Offset(0, 1),
    AxisDirection.down => const Offset(0, -1),
    AxisDirection.left => const Offset(1, 0),
    AxisDirection.right => const Offset(-1, 0),
  };

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.easeInOut;
      final tween = Tween<Offset>(begin: offsetFromDirection, end: Offset.zero).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
