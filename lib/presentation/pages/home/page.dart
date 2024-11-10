import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/presentation/pages/home/news/body.dart';
import 'widgets/drawer_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 0.2.sh,
            child: ColoredBox(
              color: context.colors.primary,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flutter_dash,
                        size: 100.r,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Cold News',
                        style: context.style.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  DrawerItem(
                    title: "News",
                    icon: Icons.newspaper,
                    isSelected: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const NewsBody()
        ],
      ),
    );
  }
}
