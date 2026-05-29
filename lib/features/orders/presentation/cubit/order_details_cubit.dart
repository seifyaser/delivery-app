import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/order_models.dart';
import '../../data/repositories/orders_repository.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrdersRepository _ordersRepository;

  OrderDetailsCubit(this._ordersRepository) : super(OrderDetailsInitial());

  Future<void> fetchOrderDetails(String id) async {
    emit(OrderDetailsLoading());
    final result = await _ordersRepository.getOrderDetails(id);
    switch (result) {
      case Success(:final value):
        emit(OrderDetailsLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(OrderDetailsError(failure.message));
        break;
    }
  }
}
