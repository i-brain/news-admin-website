import 'create_news/request.dart';
import 'create_news/response.dart';
import 'get_news/response.dart';
import 'repository.dart';

abstract class INewsService {
  Future<GetNewsResponse> getAll();
  Future<DefaultPostResponse> create(CreateNewsRequest request);
  Future<DefaultPostResponse> edit(int id, CreateNewsRequest request);
  Future<DefaultPostResponse> delete(int id);
}

class NewsService implements INewsService {
  NewsService(this.repository);
  final INewsRepository repository;
  @override
  Future<GetNewsResponse> getAll() {
    return repository.getAll();
  }

  @override
  Future<DefaultPostResponse> create(CreateNewsRequest request) {
    return repository.create(request);
  }

  @override
  Future<DefaultPostResponse> edit(int id, CreateNewsRequest request) {
    return repository.edit(id, request);
  }

  @override
  Future<DefaultPostResponse> delete(int id) {
    return repository.delete(id);
  }
}
