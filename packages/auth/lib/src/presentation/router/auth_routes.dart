import 'package:auth/src/presentation/router/route_name.dart';
import 'package:auth/src/presentation/screens/login/login_screen.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';

final List<GoRoute> authRoutes = [
  GoRoute(
    path: AuthRouteName.login,
    pageBuilder: (context, state) {
      return TransitionUtil.slideTransitionPage(state: state, child: const LoginScreen());
    },
  ),
];
