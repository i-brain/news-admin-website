import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/core/provider/drawer.dart';
import 'package:news_admin/core/services/di.dart';
import 'package:news_admin/presentation/pages/main/category/widgets/body.dart';
import 'package:news_admin/presentation/pages/main/news/data/delete_news/delete_news_cubit.dart';
import 'package:news_admin/presentation/pages/main/news/data/get_news/cubit/get_news_cubit.dart';
import 'package:news_admin/presentation/pages/main/news/widgets/body.dart';
import 'package:news_admin/presentation/pages/main/users/widgets/body.dart';
import 'package:news_admin/presentation/widgets/custom_drawer.dart';
import '../../../core/constants/colors.dart';
import '../../../responsive.dart';
import 'category/data/delete/cubit.dart';
import 'category/data/get/cubit/cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ValueNotifier<int> _drawerIndexNotifier;
  @override
  void initState() {
    super.initState();
    _drawerIndexNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    _drawerIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<DrawerProvider>().scaffoldKey,
      drawer: CustomDrawer(
        valueNotifier: _drawerIndexNotifier,
        popOnClick: true,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: CustomDrawer(valueNotifier: _drawerIndexNotifier),
              ),
            Expanded(
                flex: 5,
                child: SafeArea(
                  child: SingleChildScrollView(
                    primary: false,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!Responsive.isDesktop(context))
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed:
                                context.read<DrawerProvider>().controlMenu,
                          ),
                        const SizedBox(height: defaultPadding),
                        //Body
                        ValueListenableBuilder(
                          valueListenable: _drawerIndexNotifier,
                          builder: (context, index, child) => bodyList[index],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> get bodyList => [
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetNewsCubit(getIt())..get(),
            ),
            BlocProvider(
              create: (context) => DeleteNewsCubit(getIt()),
            ),
          ],
          child: const NewsBody(),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetCategoryCubit(getIt())..get(),
            ),
            BlocProvider(
              create: (context) => DeleteCategoryCubit(getIt()),
            ),
          ],
          child: const CategoryBody(),
        ),
        const UsersBody()
      ];
}
