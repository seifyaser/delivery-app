import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/features/home/presentation/widgets/categories_grid.dart';
import 'package:project/features/home/presentation/widgets/home_header.dart';
import 'package:project/features/home/presentation/widgets/navbar.dart';
import 'package:project/features/home/presentation/widgets/product_card.dart';
import 'package:project/features/home/presentation/widgets/sections_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routePath = RoutesPaths.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const HomeHeader(),

              const SizedBox(height: 20),

              const CategoriesGrid(),

              const SizedBox(height: 20),

              const SectionHeader(title: 'جرب الجديد', actionText: 'عرض الكل'),

              const SizedBox(height: 20),

              SizedBox(
                height: 280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ProductCard(title: 'شاورما عربي', price: '45 ج.م'),
                    ProductCard(title: 'وجبة شاورما', price: '70 ج.م'),
                    ProductCard(title: 'كريب دجاج', price: '55 ج.م'),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
