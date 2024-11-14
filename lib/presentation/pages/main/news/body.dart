import 'package:flutter/material.dart';
import 'package:news_admin/presentation/pages/main/news/widgets/add_edit_news_dialog.dart';
import '../../../../core/constants/colors.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "News",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () => AddEditNewsDialog.show(context),
                icon: const Icon(Icons.add_box_outlined, color: Colors.green),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: const [
                DataColumn(
                  label: Text(""),
                ),
                DataColumn(
                  label: Text("Title"),
                ),
                DataColumn(
                  label: Text("Description"),
                ),
                DataColumn(
                    label: Text("Action"),
                    headingRowAlignment: MainAxisAlignment.center),
              ],
              rows: List.generate(
                newsList.length,
                (index) => tableRow(context, newsList[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow tableRow(BuildContext context, NewsDetails fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.index.toString())),
      DataCell(Text(fileInfo.title)),
      DataCell(Text(fileInfo.description)),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                AddEditNewsDialog.show(context);
              },
              icon: const Icon(Icons.edit, color: Colors.orange),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    ],
  );
}

class NewsDetails {
  final String description, title;
  final int index;

  NewsDetails(
    this.index, {
    required this.description,
    required this.title,
  });
}

List newsList = [
  NewsDetails(
    1,
    title: "XD File",
    description: "assets/icons/xd_file.svg",
  ),
  NewsDetails(
    2,
    title: "XD File",
    description: "assets/icons/xd_file.svg",
  ),
  NewsDetails(
    3,
    title: "XD File",
    description: "assets/icons/xd_file.svg",
  ),
];
