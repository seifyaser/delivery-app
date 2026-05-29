import 'package:equatable/equatable.dart';

enum OrderStatus {
  PENDING,
  ACCEPTED,
  PREPARING,
  OUT_FOR_DELIVERY,
  DELIVERED,
  CANCELLED,
  REJECTED,
  UNKNOWN;

  static OrderStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING': return OrderStatus.PENDING;
      case 'ACCEPTED': return OrderStatus.ACCEPTED;
      case 'PREPARING': return OrderStatus.PREPARING;
      case 'OUT_FOR_DELIVERY': return OrderStatus.OUT_FOR_DELIVERY;
      case 'DELIVERED': return OrderStatus.DELIVERED;
      case 'CANCELLED': return OrderStatus.CANCELLED;
      case 'REJECTED': return OrderStatus.REJECTED;
      default: return OrderStatus.UNKNOWN;
    }
  }

  String get displayName {
    switch (this) {
      case OrderStatus.PENDING: return 'قيد الانتظار';
      case OrderStatus.ACCEPTED: return 'مقبول';
      case OrderStatus.PREPARING: return 'قيد التجهيز';
      case OrderStatus.OUT_FOR_DELIVERY: return 'في الطريق';
      case OrderStatus.DELIVERED: return 'تم التوصيل';
      case OrderStatus.CANCELLED: return 'ملغي';
      case OrderStatus.REJECTED: return 'مرفوض';
      case OrderStatus.UNKNOWN: return 'غير معروف';
    }
  }
}

class OrderStatusModel extends Equatable {
  final OrderStatus status;
  final DateTime timestamp;

  const OrderStatusModel({
    required this.status,
    required this.timestamp,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      status: OrderStatus.fromString(json['status'] ?? ''),
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [status, timestamp];
}

class OrderItemModel extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }

  @override
  List<Object?> get props => [productId, name, price, quantity];
}

class DriverModel extends Equatable {
  final String id;
  final String name;
  final String phone;

  const DriverModel({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, phone];
}

class OrderModel extends Equatable {
  final String id;
  final List<OrderItemModel> items;
  final double total;
  final OrderStatus status;
  final List<OrderStatusModel> timeline;
  final DriverModel? driver;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.timeline,
    this.driver,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      items: (json['items'] as List?)?.map((e) => OrderItemModel.fromJson(e)).toList() ?? [],
      total: (json['total'] ?? 0).toDouble(),
      status: OrderStatus.fromString(json['status'] ?? ''),
      timeline: (json['timeline'] as List?)?.map((e) => OrderStatusModel.fromJson(e)).toList() ?? [],
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [id, items, total, status, timeline, driver, createdAt];
}
