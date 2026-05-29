import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/result.dart';
import '../datasource/orders_remote_data_source.dart';
import '../models/order_models.dart';

abstract class OrdersRepository {
  Future<Result<List<OrderModel>>> getMyOrders();
  Future<Result<OrderModel>> getOrderDetails(String id);
  Future<Result<OrderModel>> createOrder(Map<String, dynamic> request);
}

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<OrderModel>>> getMyOrders() async {
    try {
      final orders = await _remoteDataSource.getMyOrders();
      return Success(orders);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<OrderModel>> getOrderDetails(String id) async {
    try {
      final order = await _remoteDataSource.getOrderDetails(id);
      return Success(order);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<OrderModel>> createOrder(Map<String, dynamic> request) async {
    try {
      final order = await _remoteDataSource.createOrder(request);
      return Success(order);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }
}
