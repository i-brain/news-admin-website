import 'package:flutter/material.dart';
import 'package:news_admin/core/extension.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
          DrawerListTile(
            title: "News",
            icon: Icons.newspaper,
            press: () {},
          ),
          DrawerListTile(
            title: "Category",
            icon: Icons.category,
            press: () {},
          ),
          DrawerListTile(
            title: "Users",
            icon: Icons.people,
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icons.settings,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(color: Colors.white54)),
    );
  }
}
