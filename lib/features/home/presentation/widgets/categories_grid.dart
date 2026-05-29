import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:project/features/home/data/models/category_model.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> displayedCategories = homeCategories.length > 7
        ? [
            ...homeCategories.take(7),
            const CategoryModel(title: "المزيد", icon: Icons.more_horiz),
          ]
        : homeCategories;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: displayedCategories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, index) {
          final item = displayedCategories[index];

          return GestureDetector(
            onTap: () {
              if (item.title == "المزيد") {
                context.push(RoutesPaths.categories);
              } else {
                context.push(RoutesPaths.categoryProducts, extra: item.title);
              }
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: const Color(0xffF4E6DA),
                  child: Icon(item.icon, color: Colors.brown),
                ),
                const SizedBox(height: 8),
                Text(item.title),
              ],
            ),
          );
        },
      ),
    );
  }
}
