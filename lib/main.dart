import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_admin/core/services/di.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return initializeDependencies();
}
