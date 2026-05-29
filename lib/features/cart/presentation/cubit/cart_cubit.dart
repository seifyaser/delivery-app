import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/cart_models.dart';
import '../../data/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(CartInitial());

  Future<void> fetchCart() async {
    emit(CartLoading());
    final result = await _cartRepository.getCart();
    switch (result) {
      case Success(:final value):
        emit(CartLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(CartError(failure.message));
        break;
    }
  }

  Future<void> addToCart(AddToCartRequestModel request) async {
    emit(CartLoading());
    final result = await _cartRepository.addToCart(request);
    switch (result) {
      case Success(:final value):
        emit(CartLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(CartError(failure.message));
        break;
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    emit(CartLoading());
    final result = await _cartRepository.removeFromCart(cartItemId);
    switch (result) {
      case Success(:final value):
        emit(CartLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(CartError(failure.message));
        break;
    }
  }

  Future<void> applyCoupon(String code) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      emit(CartLoading());
      final result = await _cartRepository.applyCoupon(code);
      switch (result) {
        case Success():
          // Refresh cart after applying coupon
          await fetchCart();
          break;
        case FailureResult(:final failure):
          emit(CartError(failure.message));
          // Restore previous state if needed, or re-fetch cart
          await fetchCart();
          break;
      }
    }
  }
}
