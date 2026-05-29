import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../cubit/product_details_cubit.dart';
import '../../data/models/product_model.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/data/models/cart_models.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductDetailsCubit>()..fetchProductDetails(productId),
      child: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends StatefulWidget {
  const _ProductDetailsView();

  @override
  State<_ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<_ProductDetailsView> {
  VariantModel? _selectedVariant;
  final Set<AddonModel> _selectedAddons = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: AppBar(
        title: const Text('تفاصيل المنتج', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            
            // Auto-select first variant if exist and none is selected
            if (product.variants.isNotEmpty && _selectedVariant == null) {
              _selectedVariant = product.variants.first;
            }

            final priceStr = product.variants.isNotEmpty && _selectedVariant != null
                ? _selectedVariant!.price.toString()
                : (product.defaultPrice?.toString() ?? '0');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.image != null)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          product.image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$priceStr ج.م',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                  ),
                  const Divider(height: 32),

                  if (product.variants.isNotEmpty) ...[
                    const Text('اختر الحجم/النوع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...product.variants.map((v) => RadioListTile<VariantModel>(
                          title: Text(v.name),
                          subtitle: Text('${v.price} ج.م'),
                          value: v,
                          groupValue: _selectedVariant,
                          onChanged: (val) {
                            setState(() {
                              _selectedVariant = val;
                            });
                          },
                        )),
                    const Divider(height: 32),
                  ],

                  if (product.addons.isNotEmpty || product.customAddons.isNotEmpty) ...[
                    const Text('الإضافات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...product.addons.map((a) => _buildAddonCheckbox(a)),
                    ...product.customAddons.map((a) => _buildAddonCheckbox(a)),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoaded) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add to cart
                  final variantId = _selectedVariant?.id;
                  if (state.product.variants.isNotEmpty && variantId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء اختيار الحجم/النوع')),
                    );
                    return;
                  }
                  
                  final request = AddToCartRequestModel(
                    productId: state.product.id,
                    quantity: 1, // Default quantity for now
                    variantId: variantId,
                    addonIds: _selectedAddons.map((e) => e.id).toList(),
                  );
                  
                  context.read<CartCubit>().addToCart(request);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم الإضافة للسلة')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('إضافة للسلة', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAddonCheckbox(AddonModel addon) {
    return CheckboxListTile(
      title: Text(addon.name),
      subtitle: Text('${addon.price} ج.م'),
      value: _selectedAddons.contains(addon),
      onChanged: (val) {
        setState(() {
          if (val == true) {
            _selectedAddons.add(addon);
          } else {
            _selectedAddons.remove(addon);
          }
        });
      },
    );
  }
}
