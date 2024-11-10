import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/presentation/dialogs/yes_no_dialog.dart';

class NewsTable extends StatelessWidget {
  const NewsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blueGrey,
      child: Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(10),
            2: FlexColumnWidth(2),
          },
          children: List.generate(
            3,
            (index) =>
                _buildTableRow(context, index: index, title: 'Some title'),
          )),
    );
  }

  TableRow _buildTableRow(
    BuildContext context, {
    required int index,
    required String title,
  }) {
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
              _TableActionButton(
                icon: Icons.edit,
                color: Colors.orange,
                onTap: () {},
              ),
              _TableActionButton(
                icon: Icons.delete_outlined,
                color: Colors.red,
                onTap: () => showYesNoDialog(
                  context,
                  title: 'Do you want to permenantly delete selected news?',
                  onYes: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _TableActionButton extends StatelessWidget {
  const _TableActionButton({
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
