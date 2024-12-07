import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_admin/core/provider/drawer.dart';
import 'package:news_admin/core/services/di.dart';
import 'package:news_admin/presentation/pages/login/data/cubit/login_cubit.dart';
import 'package:news_admin/presentation/pages/login/page.dart';
import 'package:news_admin/presentation/pages/main/page.dart';
import 'package:news_admin/presentation/pages/main/users/data/delete/cubit/delete_user_cubit.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DeleteUserCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(getIt()),
        ),
      ],
      child: MaterialApp(
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
          child: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return const MainPage();
              }
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
