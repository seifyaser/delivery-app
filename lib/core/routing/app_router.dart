import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/core/widgets/navbar/floating_navbar_scaffold.dart';
import 'package:project/features/home/presentation/screens/home.dart';
import 'package:project/features/cart/presentation/screens/cart.dart';
import 'package:project/features/orders/presentation/screens/empty_orders_screen.dart';
import 'package:project/features/profile/presentation/screens/profile.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutesPaths.home,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return FloatingNavbarScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: RoutesPaths.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutesPaths.cart,
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: RoutesPaths.orders,
          builder: (context, state) => const OrdersScreen(),
        ),
        GoRoute(
          path: RoutesPaths.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('No route found for ${state.uri}'))),
);
