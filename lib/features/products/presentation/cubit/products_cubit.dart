import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _productsRepository;

  ProductsCubit(this._productsRepository) : super(ProductsInitial());

  Future<void> fetchProducts({String? categoryId}) async {
    emit(ProductsLoading());
    final result = await _productsRepository.getProducts(categoryId: categoryId);
    switch (result) {
      case Success(:final value):
        emit(ProductsLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(ProductsError(failure.message));
        break;
    }
  }
}
