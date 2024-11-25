import 'package:dio/dio.dart';
import 'package:news_admin/presentation/pages/main/news/data/create_news/request.dart';
import 'package:news_admin/presentation/pages/main/news/data/create_news/response.dart';
import 'get_news/response.dart';

abstract class INewsRepository {
  Future<GetNewsResponse> getAll();
  Future<DefaultPostResponse> create(CreateNewsRequest request);
  Future<DefaultPostResponse> edit(int id, CreateNewsRequest request);
  Future<DefaultPostResponse> delete(int id);
}

class NewsRepository implements INewsRepository {
  NewsRepository(this.dio);
  final Dio dio;

  @override
  Future<GetNewsResponse> getAll() async {
    final result = await dio.get('');
    return GetNewsResponse.fromJson(result.data);
  }

  @override
  Future<DefaultPostResponse> create(CreateNewsRequest request) async {
    final result = await dio.post('', data: request);

    return DefaultPostResponse.fromJson(result.data);
  }

  @override
  Future<DefaultPostResponse> edit(int id, CreateNewsRequest request) async {
    final result = await dio.put('/$id', data: request);

    return DefaultPostResponse.fromJson(result.data);
  }

  @override
  Future<DefaultPostResponse> delete(int id) async {
    final result = await dio.delete('/$id');

    return DefaultPostResponse.fromJson(result.data);
  }
}
