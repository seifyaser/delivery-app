import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes_paths.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';

class CategoriesGrid extends StatefulWidget {
  const CategoriesGrid({super.key});

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().fetchMainCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesError) {
          return Center(child: Text(state.message));
        } else if (state is CategoriesLoaded) {
          final categories = state.categories;
          final displayedCategories = categories.length > 7
              ? categories.take(7).toList()
              : categories;
          final showMore = categories.length > 7;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              itemCount: displayedCategories.length + (showMore ? 1 : 0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) {
                if (showMore && index == 7) {
                  return GestureDetector(
                    onTap: () => context.push(RoutesPaths.categories),
                    child: const Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Color(0xffF4E6DA),
                          child: Icon(Icons.more_horiz, color: Colors.brown),
                        ),
                        SizedBox(height: 8),
                        Text("المزيد"),
                      ],
                    ),
                  );
                }

                final item = displayedCategories[index];
                return GestureDetector(
                  onTap: () => context.push(RoutesPaths.categoryProducts, extra: item.id),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: const Color(0xffF4E6DA),
                        backgroundImage: item.image != null ? NetworkImage(item.image!) : null,
                        child: item.image == null ? const Icon(Icons.category, color: Colors.brown) : null,
                      ),
                      const SizedBox(height: 8),
                      Text(item.name, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
