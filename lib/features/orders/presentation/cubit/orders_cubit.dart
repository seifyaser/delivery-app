import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/order_models.dart';
import '../../data/repositories/orders_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _ordersRepository;

  OrdersCubit(this._ordersRepository) : super(OrdersInitial());

  Future<void> fetchMyOrders() async {
    emit(OrdersLoading());
    final result = await _ordersRepository.getMyOrders();
    switch (result) {
      case Success(:final value):
        emit(OrdersLoaded(value));
        break;
      case FailureResult(:final failure):
        emit(OrdersError(failure.message));
        break;
    }
  }

  Future<void> createOrder(Map<String, dynamic> request) async {
    emit(OrdersLoading());
    final result = await _ordersRepository.createOrder(request);
    switch (result) {
      case Success(:final value):
        emit(OrderCreated(value));
        break;
      case FailureResult(:final failure):
        emit(OrdersError(failure.message));
        break;
    }
  }
}
