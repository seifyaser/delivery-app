import 'package:flutter/material.dart';
import 'package:project/features/home/presentation/widgets/product_list_tile.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy products for the category
    final dummyProducts = [
      {"title": "شاورما عربي", "price": "45 ج.م"},
      {"title": "وجبة شاورما", "price": "70 ج.م"},
      {"title": "كريب دجاج", "price": "55 ج.م"},
      {"title": "بطاطس سوري", "price": "20 ج.م"},
      {"title": "بيتزا مارجريتا", "price": "60 ج.م"},
      {"title": "برجر لحم", "price": "80 ج.م"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: AppBar(
        title: const Text('المنتجات', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return ProductListTile(
            title: product['title']!,
            price: product['price']!,
            onTap: () {
              // Add navigation to meal details here when implemented
            },
          );
        },
      ),
    );
  }
}
