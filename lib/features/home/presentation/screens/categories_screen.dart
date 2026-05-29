import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/features/home/data/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter out the 'More' item if present
    final List<CategoryModel> categories = homeCategories
        .where((c) => c.title != 'المزيد')
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: AppBar(
        title: const Text(
          'التصنيفات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];

            return GestureDetector(
              onTap: () {
                context.push(RoutesPaths.categoryProducts, extra: item.title);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xffF4E6DA),
                    child: Icon(item.icon, color: Colors.brown, size: 32),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
