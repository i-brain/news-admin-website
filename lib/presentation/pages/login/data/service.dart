import 'repository.dart';
import 'request.dart';

abstract class IAuthService {
  Future<void> login(LoginRequest request);
  Future<void> logout();
}

class AuthService implements IAuthService {
  AuthService(this.repository);
  final IAuthRepository repository;

  @override
  Future<void> login(LoginRequest request) {
    return repository.login(request);
  }

  @override
  Future<void> logout() {
    return repository.logout();
  }
}
