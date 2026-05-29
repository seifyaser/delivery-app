import '../../../../core/network/api_service.dart';
import '../../../../core/network/endpoints.dart';
import '../models/order_models.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getMyOrders();
  Future<OrderModel> getOrderDetails(String id);
  Future<OrderModel> createOrder(Map<String, dynamic> request);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiService _apiService;

  OrdersRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<OrderModel>> getMyOrders() async {
    final response = await _apiService.get(Endpoints.myOrders);
    final data = response.data as List;
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<OrderModel> getOrderDetails(String id) async {
    final response = await _apiService.get(Endpoints.orderDetails(id));
    return OrderModel.fromJson(response.data);
  }

  @override
  Future<OrderModel> createOrder(Map<String, dynamic> request) async {
    final response = await _apiService.post(Endpoints.orders, data: request);
    return OrderModel.fromJson(response.data);
  }
}
