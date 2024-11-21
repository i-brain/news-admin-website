import 'package:dio/dio.dart';
import 'response.dart';

abstract class INewsRepository {
  Future<GetNewsResponse> getAll();
}

class NewsRepository implements INewsRepository {
  NewsRepository(this.dio);
  final Dio dio;

  @override
  Future<GetNewsResponse> getAll() async {
    final result = await dio.get('');

    return GetNewsResponse.fromJson(result.data);
  }
}
