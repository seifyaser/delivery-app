import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/auth_models.dart';

abstract class AuthRepository {
  Future<Result<LoginResponseModel>> login(LoginRequestModel request);
  Future<Result<LoginResponseModel>> register(RegisterRequestModel request);
  Future<Result<UserModel>> getMe();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<LoginResponseModel>> login(LoginRequestModel request) async {
    try {
      final response = await _remoteDataSource.login(request);
      return Success(response);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<LoginResponseModel>> register(RegisterRequestModel request) async {
    try {
      final response = await _remoteDataSource.register(request);
      return Success(response);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<UserModel>> getMe() async {
    try {
      final response = await _remoteDataSource.getMe();
      return Success(response);
    } catch (e) {
      return FailureResult(ErrorHandler.handle(e));
    }
  }
}
