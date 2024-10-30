import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/presentation/pages/home/widgets/add_edit_news_body.dart';

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
          Expanded(
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
                          padding: EdgeInsets.all(32).r,
                        ),
                        onPressed: () => AddEditNewsBody.show(context),
                        label: Text('Add news',
                            style: context.style.bodySmall
                                ?.copyWith(color: Colors.white)),
                        icon: Icon(Icons.add, color: Colors.white, size: 36.r),
                      )
                    ],
                  ),
                ),
                ColoredBox(
                  color: Colors.blueGrey,
                  child: CustomTable(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(10),
          2: FlexColumnWidth(2),
        },
        children: List.generate(
          3,
          (index) => _buildTableRow(context, index: index, title: 'Some title'),
        )
        //  [

        //   _buildTableRow(),
        //   _buildRow(['1', 'Lorem ipsum', 'Row 1, Col 3']),
        //   _buildRow(['2', 'Mazel toc', 'Row 2, Col 3']),
        //   _buildRow(['3', 'Huge tornado', 'Row 3, Col 3']),
        // ],
        );
  }

  TableRow _buildTableRow(BuildContext context,
      {required int index, required String title}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Center(
            child: Text(
              "$index",
              style: context.style.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Center(
            child: Text(title,
                style: context.style.bodyMedium?.copyWith(color: Colors.white),
                textAlign: TextAlign.center),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TableActionButton(
                icon: Icons.edit,
                color: Colors.orange,
                onTap: () {},
              ),
              TableActionButton(
                icon: Icons.delete_outlined,
                color: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TableActionButton extends StatelessWidget {
  const TableActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
  });
  final IconData icon;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12).r,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

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
