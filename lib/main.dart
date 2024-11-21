import 'package:flutter/material.dart';
import 'package:news_admin/core/services/di.dart';
import 'app.dart';

void main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  return initializeDependencies();
}
