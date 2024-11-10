import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isSelected = false,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.primary,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 40).r,
          child: Row(
            children: [
              Icon(icon, size: 50.r, color: color),
              SizedBox(width: 8.w),
              Text(
                title,
                style: context.style.bodyLarge?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get color => isSelected ? Colors.white : Colors.blueGrey;
}
