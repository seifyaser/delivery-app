import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/token_service.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final TokenService _tokenService;

  AuthCubit(this._authRepository, this._tokenService) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final hasToken = await _tokenService.hasToken();
    if (hasToken) {
      final result = await _authRepository.getMe();
      switch (result) {
        case Success(:final value):
          emit(AuthAuthenticated(value));
          break;
        case FailureResult():
          await _tokenService.deleteToken();
          emit(const AuthUnauthenticated('Session expired. Please login again.'));
          break;
      }
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> login(LoginRequestModel request) async {
    emit(AuthLoading());
    final result = await _authRepository.login(request);
    
    switch (result) {
      case Success(:final value):
        await _tokenService.saveToken(value.token);
        emit(AuthAuthenticated(value.user));
        break;
      case FailureResult(:final failure):
        emit(AuthError(failure.message));
        break;
    }
  }

  Future<void> register(RegisterRequestModel request) async {
    emit(AuthLoading());
    final result = await _authRepository.register(request);
    
    switch (result) {
      case Success(:final value):
        await _tokenService.saveToken(value.token);
        emit(AuthAuthenticated(value.user));
        break;
      case FailureResult(:final failure):
        emit(AuthError(failure.message));
        break;
    }
  }

  Future<void> logout() async {
    await _tokenService.deleteToken();
    emit(const AuthUnauthenticated());
  }
}
