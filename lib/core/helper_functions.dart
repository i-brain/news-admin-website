import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<dynamic> pushPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

bool isServerException(DioException exception) {
  return exception.response != null &&
      exception.response!.statusCode != null &&
      exception.response!.statusCode! >= 500;
}
