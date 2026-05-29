import '../../../../core/network/api_service.dart';
import '../../../../core/network/endpoints.dart';
import '../models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getMainCategories();
  Future<List<SubCategoryModel>> getSubCategories(String categoryId);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiService _apiService;

  CategoriesRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<CategoryModel>> getMainCategories() async {
    final response = await _apiService.get(Endpoints.categoriesMain);
    final data = response.data as List;
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<List<SubCategoryModel>> getSubCategories(String categoryId) async {
    final response = await _apiService.get(Endpoints.subCategories(categoryId));
    final data = response.data as List;
    return data.map((e) => SubCategoryModel.fromJson(e)).toList();
  }
}
