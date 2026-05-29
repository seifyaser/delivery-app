import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';

class PromoCodeInput extends StatefulWidget {
  const PromoCodeInput({super.key});

  @override
  State<PromoCodeInput> createState() => _PromoCodeInputState();
}

class _PromoCodeInputState extends State<PromoCodeInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        bool isLoading = state is CartLoading;
        String? appliedCoupon;
        if (state is CartLoaded) {
          appliedCoupon = state.cart.appliedCoupon;
        }

        if (appliedCoupon != null && appliedCoupon.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xffF4E2AE),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('كود الخصم المطبق: $appliedCoupon', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                const Icon(Icons.check_circle, color: Colors.deepOrange),
              ],
            ),
          );
        }

        return Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_offer, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'كود الخصم',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: isLoading
                  ? null
                  : () {
                      final code = _controller.text.trim();
                      if (code.isNotEmpty) {
                        context.read<CartCubit>().applyCoupon(code);
                      }
                    },
              child: Container(
                width: 110,
                height: 60,
                decoration: BoxDecoration(
                  color: isLoading ? Colors.grey : const Color(0xffF4E2AE),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.deepOrange, strokeWidth: 2),
                        )
                      : const Text(
                          'تطبيق',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
