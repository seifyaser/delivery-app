import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final String cartItemId;
  final String title;
  final double price;
  final int quantity;
  final IconData icon;

  const CartItemCard({
    super.key,
    this.cartItemId = '',
    required this.title,
    required this.price,
    required this.quantity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 36, color: Colors.orange),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                Text(
                  '$price ج.م',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          IconButton(
            onPressed: () {
              if (cartItemId.isNotEmpty) {
                context.read<CartCubit>().removeFromCart(cartItemId);
              }
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffF5F2F2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // In a real app we would call update quantity.
                // For now, based on requirements, we only have add/remove endpoints mentioned.
                Icon(Icons.remove, color: Colors.orange.shade700, size: 20),
                const SizedBox(width: 10),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Icon(Icons.add, color: Colors.orange.shade700, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
