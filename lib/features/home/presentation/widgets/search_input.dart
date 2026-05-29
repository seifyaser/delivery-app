import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black.withOpacity(.12),
          ),
        ],
      ),
      child: const TextField(
        autofocus: true,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: 'ابحث عن منتج...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
