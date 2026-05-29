import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _categoriesRepository;

  CategoriesCubit(this._categoriesRepository) : super(CategoriesInitial());

  Future<void> fetchMainCategories() async {
    emit(CategoriesLoading());
    final result = await _categoriesRepository.getMainCategories();
    switch (result) {
      case Success(:final value):
        emit(CategoriesLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(CategoriesError(failure.message));
        break;
    }
  }

  Future<void> fetchSubCategories(String categoryId) async {
    emit(SubCategoriesLoading());
    final result = await _categoriesRepository.getSubCategories(categoryId);
    switch (result) {
      case Success(:final value):
        emit(SubCategoriesLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(CategoriesError(failure.message));
        break;
    }
  }
}
