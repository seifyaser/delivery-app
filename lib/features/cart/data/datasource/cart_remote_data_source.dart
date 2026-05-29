import '../../../../core/network/api_service.dart';
import '../../../../core/network/endpoints.dart';
import '../models/cart_models.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addToCart(AddToCartRequestModel request);
  Future<CartModel> removeFromCart(String cartItemId);
  Future<CouponResponseModel> applyCoupon(String code);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiService _apiService;

  CartRemoteDataSourceImpl(this._apiService);

  @override
  Future<CartModel> getCart() async {
    final response = await _apiService.get(Endpoints.cart);
    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> addToCart(AddToCartRequestModel request) async {
    final response = await _apiService.post(Endpoints.cartAdd, data: request.toJson());
    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> removeFromCart(String cartItemId) async {
    final response = await _apiService.delete(Endpoints.cartRemove, data: {'cartItemId': cartItemId});
    return CartModel.fromJson(response.data);
  }

  @override
  Future<CouponResponseModel> applyCoupon(String code) async {
    final response = await _apiService.post(Endpoints.applyCoupon, data: {'code': code});
    return CouponResponseModel.fromJson(response.data);
  }
}
