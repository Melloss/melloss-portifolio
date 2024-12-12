import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melloss_portifolio/presentation/views/desktop/desktop_view.dart';
import 'package:melloss_portifolio/presentation/views/inactive/inactive_view.dart';

import '../../presentation/views/landing/landing_view.dart';
import '../../presentation/views/splash/splash_view.dart';

class RouteName {
  static const landing = 'landing_screen';
  static const desktop = 'desktop_screen';
  static const inactive = 'inactive_screen';
  static const boot = 'boot_screen';
}

final goRouting = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteName.boot,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/landing',
      name: RouteName.landing,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 700),
        child: const LandingView(),
        transitionsBuilder: (context, animation, secondAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.linear;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/inactive',
      name: RouteName.inactive,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 700),
        child: InactiveView(
          routeName: state.extra as String,
        ),
        transitionsBuilder: (context, animation, secondAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.linear;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/desktop',
      name: RouteName.desktop,
      builder: (context, state) => const DesktopView(),
    )
  ],
);
