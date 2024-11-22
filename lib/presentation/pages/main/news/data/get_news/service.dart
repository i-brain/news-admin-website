import 'response.dart';
import 'repository.dart';

abstract class INewsService {
  Future<GetNewsResponse> getAll();
}

class NewsService implements INewsService {
  NewsService(this.service);
  final INewsRepository service;

  @override
  Future<GetNewsResponse> getAll() {
    return service.getAll();
  }
}
