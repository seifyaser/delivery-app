import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/result.dart';
import '../datasource/cart_remote_data_source.dart';
import '../models/cart_models.dart';

abstract class CartRepository {
  Future<Result<CartModel>> getCart();
  Future<Result<CartModel>> addToCart(AddToCartRequestModel request);
  Future<Result<CartModel>> removeFromCart(String cartItemId);
  Future<Result<CouponResponseModel>> applyCoupon(String code);
}

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CartModel>> getCart() async {
    try {
      final cart = await _remoteDataSource.getCart();
      return Success(cart);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<CartModel>> addToCart(AddToCartRequestModel request) async {
    try {
      final cart = await _remoteDataSource.addToCart(request);
      return Success(cart);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<CartModel>> removeFromCart(String cartItemId) async {
    try {
      final cart = await _remoteDataSource.removeFromCart(cartItemId);
      return Success(cart);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<CouponResponseModel>> applyCoupon(String code) async {
    try {
      final response = await _remoteDataSource.applyCoupon(code);
      return Success(response);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }
}
