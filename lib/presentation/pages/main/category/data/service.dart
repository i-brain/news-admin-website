import '../../news/data/create_news/response.dart';
import 'create/request.dart';
import 'get/response.dart';
import 'repository.dart';

abstract class ICategoryService {
  Future<GetCategoryResponse> getAll();
  Future<DefaultPostResponse> create(CreateCategoryRequest request);
  Future<DefaultPostResponse> edit(int id, CreateCategoryRequest request);
  Future<DefaultPostResponse> delete(int id);
}

class CategoryService implements ICategoryService {
  CategoryService(this.repository);
  final ICategoryRepository repository;
  @override
  Future<GetCategoryResponse> getAll() {
    return repository.getAll();
  }

  @override
  Future<DefaultPostResponse> create(CreateCategoryRequest request) {
    return repository.create(request);
  }

  @override
  Future<DefaultPostResponse> edit(int id, CreateCategoryRequest request) {
    return repository.edit(id, request);
  }

  @override
  Future<DefaultPostResponse> delete(int id) {
    return repository.delete(id);
  }
}
