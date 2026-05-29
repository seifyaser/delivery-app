import 'package:flutter/material.dart';
import 'package:project/features/home/data/dummy_data.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: homeCategories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, index) {
          final item = homeCategories[index];

          return Column(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xffF4E6DA),
                child: Icon(item["icon"] as IconData, color: Colors.brown),
              ),
              const SizedBox(height: 8),
              Text(item["title"] as String),
            ],
          );
        },
      ),
    );
  }
}
