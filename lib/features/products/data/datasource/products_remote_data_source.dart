import '../../../../core/network/api_service.dart';
import '../../../../core/network/endpoints.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts({String? categoryId});
  Future<ProductModel> getProductDetails(String id);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiService _apiService;

  ProductsRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<ProductModel>> getProducts({String? categoryId}) async {
    final queryParams = categoryId != null ? {'categoryId': categoryId} : null;
    final response = await _apiService.get(Endpoints.products, queryParameters: queryParams);
    final data = response.data as List;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<ProductModel> getProductDetails(String id) async {
    final response = await _apiService.get(Endpoints.productDetails(id));
    return ProductModel.fromJson(response.data);
  }
}
