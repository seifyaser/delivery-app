import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/result.dart';
import '../datasource/products_remote_data_source.dart';
import '../models/product_model.dart';

abstract class ProductsRepository {
  Future<Result<List<ProductModel>>> getProducts({String? categoryId});
  Future<Result<ProductModel>> getProductDetails(String id);
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<ProductModel>>> getProducts({String? categoryId}) async {
    try {
      final products = await _remoteDataSource.getProducts(categoryId: categoryId);
      return Success(products);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<ProductModel>> getProductDetails(String id) async {
    try {
      final product = await _remoteDataSource.getProductDetails(id);
      return Success(product);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }
}
