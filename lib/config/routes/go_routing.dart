import 'package:go_router/go_router.dart';

import '../../presentation/views/landing/landing_view.dart';
import '../../presentation/views/splash/splash_view.dart';

class RouteName {
  static const landing = 'landing_screen';
}

final goRouting = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/landing',
      name: RouteName.landing,
      builder: (context, state) => const LandingView(),
    )
  ],
);
