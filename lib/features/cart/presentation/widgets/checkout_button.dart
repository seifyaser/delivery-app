import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes_paths.dart';
import '../../../home/presentation/cubit/location/location_cubit.dart';
import '../../../orders/presentation/cubit/orders_cubit.dart';
import '../cubit/cart_cubit.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء الطلب بنجاح!')),
          );
          // Refresh cart since it's probably empty now
          context.read<CartCubit>().fetchCart();
          context.go(RoutesPaths.orders);
        } else if (state is OrdersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, ordersState) {
        final isCreatingOrder = ordersState is OrdersLoading;

        return GestureDetector(
          onTap: isCreatingOrder
              ? null
              : () {
                  final locationState = context.read<LocationCubit>().state;
                  if (locationState is LocationSuccess) {
                    final address = locationState.location.fullAddress;
                    context.read<OrdersCubit>().createOrder({'address': address});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء تحديد موقع التوصيل أولاً')),
                    );
                    context.read<LocationCubit>().getCurrentLocation();
                  }
                },
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isCreatingOrder ? Colors.grey : Colors.deepOrange,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: isCreatingOrder
                      ? Colors.transparent
                      : Colors.deepOrange.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: isCreatingOrder
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'إتمام الطلب ←',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
