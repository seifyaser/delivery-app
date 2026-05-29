import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(url, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.put(url, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(url, data: data, queryParameters: queryParameters);
  }
}
