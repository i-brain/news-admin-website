import 'package:dio/dio.dart';
import 'di.dart';
import 'secure_storage.dart';

class JwtInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getIt<SecureStorageService>().token;
    options.headers.addAll(
      {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    // log(options.path);

    handler.next(options);
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(
      {
        "Content-Type": "application/json",
      },
    );

    // log(options.path);

    handler.next(options);
  }
}
