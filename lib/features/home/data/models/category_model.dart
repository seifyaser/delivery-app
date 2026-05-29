import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final IconData icon;

  const CategoryModel({required this.title, required this.icon});
}

// dummy data
const List<CategoryModel> homeCategories = [
  CategoryModel(icon: Icons.kebab_dining, title: "شاورما"),
  CategoryModel(icon: Icons.lunch_dining, title: "ساندوتشات"),
  CategoryModel(icon: Icons.local_pizza, title: "بيتزا"),
  CategoryModel(icon: Icons.local_cafe, title: "مشروبات"),
  CategoryModel(icon: Icons.fastfood, title: "وجبات"),
  CategoryModel(icon: Icons.ramen_dining, title: "كريب"),
  CategoryModel(icon: Icons.restaurant, title: "برجر"),
  CategoryModel(icon: Icons.restaurant, title: "بطاطس"),
  CategoryModel(icon: Icons.arrow_forward, title: "المزيد"),
];
