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
        "Accept-Language": 'az',
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Device": "app"
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
        "Accept-Language": 'az',
        "Accept": "application/json",
        "Device": "app",
      },
    );

    // log(options.path);

    handler.next(options);
  }
}
