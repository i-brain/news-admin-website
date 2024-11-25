import 'package:flutter/material.dart';
import 'package:news_admin/core/extension.dart';

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
            child: Row(
              children: [
                const Icon(Icons.flutter_dash, size: 60),
                Text(
                  'Mews',
                  style: context.style.titleLarge,
                ),
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
          )
        ],
      ),
    );
  }

  List<DrawerTileInfo> get drawerTiles => [
        DrawerTileInfo('News', Icons.newspaper),
        DrawerTileInfo('Category', Icons.category),
        DrawerTileInfo('Users', Icons.people),
        DrawerTileInfo('Settings', Icons.settings),
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
