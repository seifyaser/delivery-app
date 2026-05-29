import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/core/widgets/navbar/navbar_item.dart';

class FloatingNavbarScaffold extends StatelessWidget {
  final Widget child;

  const FloatingNavbarScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Current route to highlight the active tab
    final String location = GoRouterState.of(context).uri.path;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF8F5F2),
      body: Stack(
        children: [
          // The current screen
          child,

          // The floating navbar
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'الرئيسية',
                    isActive: location == RoutesPaths.home,
                    onTap: () => context.go(RoutesPaths.home),
                  ),
                  NavItem(
                    icon: Icons.shopping_cart_outlined,
                    activeIcon: Icons.shopping_cart,
                    label: 'عربتي',
                    isActive: location == RoutesPaths.cart,
                    onTap: () => context.go(RoutesPaths.cart),
                  ),
                  NavItem(
                    icon: Icons.receipt_long_outlined,
                    activeIcon: Icons.receipt_long,
                    label: 'طلباتي',
                    isActive: location == RoutesPaths.orders,
                    onTap: () => context.go(RoutesPaths.orders),
                  ),
                  NavItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'حسابي',
                    isActive: location == RoutesPaths.profile,
                    onTap: () => context.go(RoutesPaths.profile),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
