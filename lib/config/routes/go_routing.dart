import 'package:go_router/go_router.dart';

import '../../presentation/screens/landing_screen.dart';
import '../../presentation/screens/splash_screen.dart';

class RouteName {
  static const landing = 'landing_screen';
}

final goRouting = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/landing',
      name: RouteName.landing,
      builder: (context, state) => const LandingScreen(),
    )
  ],
);
