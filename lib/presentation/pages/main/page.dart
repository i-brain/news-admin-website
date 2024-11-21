import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/core/provider/drawer.dart';
import 'package:news_admin/core/services/di.dart';
import 'package:news_admin/presentation/pages/main/news/data/cubit/get_news_cubit.dart';
import 'package:news_admin/presentation/pages/main/news/widgets/body.dart';
import 'package:news_admin/presentation/widgets/custom_drawer.dart';
import '../../../core/constants/colors.dart';
import '../../../responsive.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<DrawerProvider>().scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(child: CustomDrawer()),
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
                        BlocProvider(
                          create: (context) => GetNewsCubit(getIt())..get(),
                          child: const NewsBody(),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
