import 'package:flutter/material.dart';
import 'package:project/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:project/features/cart/presentation/widgets/checkout_button.dart';
import 'package:project/features/cart/presentation/widgets/order_summary_section.dart';
import 'package:project/features/cart/presentation/widgets/promo_code_input.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'عربة التسوق',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24),
                      CartItemCard(
                        title: 'برجر كلاسيك',
                        price: 12.99,
                        quantity: 1,
                        icon: Icons.lunch_dining,
                      ),
                      SizedBox(height: 16),
                      CartItemCard(
                        title: 'بطاطس بالثوم',
                        price: 4.50,
                        quantity: 2,
                        icon: Icons.fastfood,
                      ),
                      SizedBox(height: 30),
                      PromoCodeInput(),
                      SizedBox(height: 30),
                      OrderSummarySection(),
                      SizedBox(height: 20),
                      CheckoutButton(),
                      const SizedBox(height: 100),
                    ],
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
