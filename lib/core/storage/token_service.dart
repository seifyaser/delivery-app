import 'secure_storage_service.dart';

class TokenService {
  final SecureStorageService _storageService;
  static const String _tokenKey = 'jwt_token';

  const TokenService(this._storageService);

  Future<void> saveToken(String token) async {
    await _storageService.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storageService.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storageService.delete(key: _tokenKey);
  }
  
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
