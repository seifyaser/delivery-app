import '../../../../core/network/api_service.dart';
import '../../../../core/network/endpoints.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<LoginResponseModel> register(RegisterRequestModel request);
  Future<UserModel> getMe();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _apiService.post(
      Endpoints.login,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<LoginResponseModel> register(RegisterRequestModel request) async {
    final response = await _apiService.post(
      Endpoints.register,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getMe() async {
    final response = await _apiService.get(Endpoints.me);
    return UserModel.fromJson(response.data);
  }
}
