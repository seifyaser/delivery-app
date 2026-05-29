import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final String cartItemId;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String? variantId;
  final List<String> addonIds;

  const CartItemModel({
    required this.cartItemId,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.variantId,
    this.addonIds = const [],
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      cartItemId: json['cartItemId'] ?? '',
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      variantId: json['variantId'],
      addonIds: (json['addonIds'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [cartItemId, productId, name, price, quantity, variantId, addonIds];
}

class CartModel extends Equatable {
  final String id;
  final List<CartItemModel> items;
  final double subtotal;
  final double discount;
  final double total;
  final String? appliedCoupon;

  const CartModel({
    required this.id,
    this.items = const [],
    this.subtotal = 0,
    this.discount = 0,
    this.total = 0,
    this.appliedCoupon,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      items: (json['items'] as List?)?.map((e) => CartItemModel.fromJson(e)).toList() ?? [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      appliedCoupon: json['appliedCoupon'],
    );
  }

  @override
  List<Object?> get props => [id, items, subtotal, discount, total, appliedCoupon];
}

class AddToCartRequestModel extends Equatable {
  final String productId;
  final int quantity;
  final String? variantId;
  final List<String> addonIds;

  const AddToCartRequestModel({
    required this.productId,
    required this.quantity,
    this.variantId,
    this.addonIds = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      if (variantId != null) 'variantId': variantId,
      'addonIds': addonIds,
    };
  }

  @override
  List<Object?> get props => [productId, quantity, variantId, addonIds];
}

class CouponResponseModel extends Equatable {
  final bool success;
  final String message;
  final double discountApplied;

  const CouponResponseModel({
    required this.success,
    required this.message,
    required this.discountApplied,
  });

  factory CouponResponseModel.fromJson(Map<String, dynamic> json) {
    return CouponResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      discountApplied: (json['discountApplied'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [success, message, discountApplied];
}
