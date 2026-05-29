import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String? image;

  const CategoryModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, name, image];
}

class SubCategoryModel extends Equatable {
  final String id;
  final String categoryId;
  final String name;
  final String? image;

  const SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    this.image,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, categoryId, name, image];
}
