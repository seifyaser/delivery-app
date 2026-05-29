import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/products_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductsRepository _productsRepository;

  ProductDetailsCubit(this._productsRepository) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(String id) async {
    emit(ProductDetailsLoading());
    final result = await _productsRepository.getProductDetails(id);
    switch (result) {
      case Success(:final value):
        emit(ProductDetailsLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(ProductDetailsError(failure.message));
        break;
    }
  }
}
