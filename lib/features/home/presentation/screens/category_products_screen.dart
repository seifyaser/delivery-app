import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/routing/routes_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:project/features/home/presentation/widgets/product_list_tile.dart';
import '../../../products/presentation/cubit/products_cubit.dart';
import '../../../../core/di/injection.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  const CategoryProductsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()..fetchProducts(categoryId: categoryId),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F5F2),
        appBar: AppBar(
          title: const Text('المنتجات', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsError) {
              return Center(child: Text(state.message));
            } else if (state is ProductsLoaded) {
              final products = state.products;
              if (products.isEmpty) {
                return const Center(child: Text('لا توجد منتجات'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  // If variants are empty, use defaultPrice
                  final priceStr = product.variants.isEmpty 
                      ? (product.defaultPrice?.toString() ?? '0') + ' ج.م'
                      : 'يبدأ من ' + (product.variants.first.price.toString()) + ' ج.م';

                  return ProductListTile(
                    title: product.name,
                    price: priceStr,
                    onTap: () {
                      // Navigate to product details
                      context.push(RoutesPaths.details, extra: product.id);
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
