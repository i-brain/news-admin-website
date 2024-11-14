import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_admin/core/provider/drawer.dart';
import 'package:news_admin/presentation/pages/main/page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mews Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF212332),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: const Color(0xFF2A2D3E),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DrawerProvider()),
        ],
        child: const MainPage(),
      ),
    );
  }
}
