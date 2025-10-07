import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionUtil {
  static CustomTransitionPage<void> slideTransitionPage<T>({
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
}
