import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';
import 'widgets/add_edit_news_dialog.dart';
import 'widgets/table.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(32).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("News", style: context.style.titleMedium),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(32).r,
                  ),
                  onPressed: () => AddEditNewsDialog.show(context),
                  label: Text('Add news',
                      style: context.style.bodySmall
                          ?.copyWith(color: Colors.white)),
                  icon: Icon(Icons.add, color: Colors.white, size: 36.r),
                )
              ],
            ),
          ),
          const NewsTable()
        ],
      ),
    );
  }
}
