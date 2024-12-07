import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/core/extension.dart';

import '../dialogs/error.dart';
import '../pages/login/data/cubit/login_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.valueNotifier,
    this.popOnClick = false,
  });
  final ValueNotifier<int> valueNotifier;
  final bool popOnClick;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.flutter_dash, size: 60),
                    Text(
                      'Mews',
                      style: context.style.titleLarge,
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    if (user != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 10),
                            Text(
                              '${user.displayName}',
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
          Column(
            children: List.generate(
              drawerTiles.length,
              (index) => DrawerListTile(
                info: drawerTiles[index],
                onTap: () {
                  valueNotifier.value = index;
                  if (popOnClick) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LogoutFailure) {
                showErrorDialog(context, state.message);
              }
            },
            child: DrawerListTile(
              info: DrawerTileInfo('Logout', Icons.logout),
              onTap: () {
                context.read<LoginCubit>().logout();
              },
            ),
          )
        ],
      ),
    );
  }

  List<DrawerTileInfo> get drawerTiles => [
        DrawerTileInfo('News', Icons.newspaper),
        DrawerTileInfo('Category', Icons.category),
        DrawerTileInfo('Users', Icons.people),
      ];
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.info,
    required this.onTap,
  });

  final DrawerTileInfo info;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(info.icon),
      title: Text(info.title, style: const TextStyle(color: Colors.white54)),
    );
  }
}

class DrawerTileInfo {
  final String title;
  final IconData icon;

  DrawerTileInfo(this.title, this.icon);
}
