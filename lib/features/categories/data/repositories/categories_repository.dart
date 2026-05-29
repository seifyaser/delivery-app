import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/result.dart';
import '../datasource/categories_remote_data_source.dart';
import '../models/category_model.dart';

abstract class CategoriesRepository {
  Future<Result<List<CategoryModel>>> getMainCategories();
  Future<Result<List<SubCategoryModel>>> getSubCategories(String categoryId);
}

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoriesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<CategoryModel>>> getMainCategories() async {
    try {
      final categories = await _remoteDataSource.getMainCategories();
      return Success(categories);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<List<SubCategoryModel>>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _remoteDataSource.getSubCategories(categoryId);
      return Success(subCategories);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }
}
