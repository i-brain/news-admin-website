import 'repository.dart';
import 'update/request.dart';

abstract class IUserService {
  Future<void> delete(String id);
  Future<void> update(UpdateUserRequest request);
}

class UserService implements IUserService {
  UserService(this.repository);
  final IUserRepository repository;

  @override
  Future<void> delete(String id) {
    return repository.delete(id);
  }

  @override
  Future<void> update(UpdateUserRequest request) {
    return repository.update(request);
  }
}
