import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback? onTap;

  const ProductListTile({
    super.key,
    required this.title,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image at corner
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.fastfood, color: Colors.orange, size: 40),
            ),
            const SizedBox(width: 16),
            // Meal name & price in a column beside image
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow in circle to enter to meal details
            const CircleAvatar(
              backgroundColor: Color(0xffF2D7B0),
              child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}
