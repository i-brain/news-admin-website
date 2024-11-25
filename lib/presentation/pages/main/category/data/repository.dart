import 'package:dio/dio.dart';
import '../../news/data/create_news/response.dart';
import 'create/request.dart';
import 'get/response.dart';

abstract class ICategoryRepository {
  Future<GetCategoryResponse> getAll();
  Future<DefaultPostResponse> create(CreateCategoryRequest request);
  Future<DefaultPostResponse> edit(int id, CreateCategoryRequest request);
  Future<DefaultPostResponse> delete(int id);
}

class CategoryRepository implements ICategoryRepository {
  CategoryRepository(this.dio);
  final Dio dio;

  @override
  Future<GetCategoryResponse> getAll() async {
    final result = await dio.get('/category');
    return GetCategoryResponse.fromJson(result.data);
  }

  @override
  Future<DefaultPostResponse> create(CreateCategoryRequest request) async {
    final result = await dio.post('/category', data: request);

    return DefaultPostResponse.fromJson(result.data);
  }

  @override
  Future<DefaultPostResponse> edit(
      int id, CreateCategoryRequest request) async {
    final result = await dio.put('/category/$id', data: request);

    return DefaultPostResponse.fromJson(result.data);
  }

  @override
  Future<DefaultPostResponse> delete(int id) async {
    final result = await dio.delete('/category/$id');

    return DefaultPostResponse.fromJson(result.data);
  }
}
