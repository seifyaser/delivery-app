import 'package:equatable/equatable.dart';

class VariantModel extends Equatable {
  final String id;
  final String name;
  final double price;

  const VariantModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}

class AddonModel extends Equatable {
  final String id;
  final String name;
  final double price;

  const AddonModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}

class ProductModel extends Equatable {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final String? image;
  final double? defaultPrice;
  final List<VariantModel> variants;
  final List<AddonModel> addons;
  final List<AddonModel> customAddons;

  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    this.image,
    this.defaultPrice,
    this.variants = const [],
    this.addons = const [],
    this.customAddons = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      defaultPrice: json['defaultPrice'] != null ? (json['defaultPrice']).toDouble() : null,
      variants: (json['variants'] as List?)?.map((e) => VariantModel.fromJson(e)).toList() ?? [],
      addons: (json['addons'] as List?)?.map((e) => AddonModel.fromJson(e)).toList() ?? [],
      customAddons: (json['customAddons'] as List?)?.map((e) => AddonModel.fromJson(e)).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        categoryId,
        name,
        description,
        image,
        defaultPrice,
        variants,
        addons,
        customAddons,
      ];
}
