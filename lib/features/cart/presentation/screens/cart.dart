import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:project/features/cart/presentation/widgets/checkout_button.dart';
import 'package:project/features/cart/presentation/widgets/order_summary_section.dart';
import 'package:project/features/cart/presentation/widgets/promo_code_input.dart';
import '../cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CartError) {
                        return Center(child: Text(state.message));
                      } else if (state is CartLoaded) {
                        final cart = state.cart;
                        if (cart.items.isEmpty) {
                          return const Center(child: Text('عربة التسوق فارغة'));
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'عربة التسوق',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ...cart.items.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: CartItemCard(
                                    cartItemId: item.cartItemId,
                                    title: item.name,
                                    price: item.price,
                                    quantity: item.quantity,
                                    icon: Icons.fastfood, // Could map dynamically based on category
                                  ),
                                )),
                            const SizedBox(height: 30),
                            const PromoCodeInput(),
                            const SizedBox(height: 30),
                            const OrderSummarySection(),
                            const SizedBox(height: 20),
                            const CheckoutButton(),
                            const SizedBox(height: 100),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
