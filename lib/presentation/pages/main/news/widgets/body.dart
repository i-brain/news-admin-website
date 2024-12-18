// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/presentation/dialogs/yes_no_dialog.dart';
import 'package:news_admin/presentation/pages/main/news/data/delete_news/delete_news_cubit.dart';
import 'package:news_admin/presentation/pages/main/news/data/get_news/cubit/get_news_cubit.dart';
import 'package:news_admin/presentation/pages/main/news/data/get_news/response.dart';
import 'package:news_admin/presentation/pages/main/news/widgets/add_edit_news_dialog.dart';
import '../../../../../core/constants/colors.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({super.key});

  @override
  State<NewsBody> createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
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
                onPressed: () async {
                  bool? isNewsCreated = await AddEditNewsDialog.show(context);
                  if (isNewsCreated == true) {
                    context.read<GetNewsCubit>().get();
                  }
                },
                icon: const Icon(Icons.add_box_outlined, color: Colors.green),
              ),
            ],
          ),
          BlocBuilder<GetNewsCubit, GetNewsState>(
            builder: (context, state) {
              if (state is GetNewsSuccess) {
                final newsList = state.news;
                return SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    columns: const [
                      DataColumn(
                        label: Text("ID"),
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
                      (index) => _tableRow(context, newsList[index]),
                    ),
                  ),
                );
              }

              if (state is GetNewsFailure) {
                return Center(child: Text(state.message.toString()));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  DataRow _tableRow(BuildContext context, NewsDetails newsDetails) {
    return DataRow(
      cells: [
        DataCell(Text(newsDetails.id.toString())),
        DataCell(Text(newsDetails.title.toString(), maxLines: 1)),
        DataCell(Text(newsDetails.details.toString(), maxLines: 1)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  AddEditNewsDialog.show(
                    context,
                    newsDetails: newsDetails,
                    dialogType: DialogType.edit,
                  ).then(
                    (isEdited) {
                      if (isEdited == true) {
                        context.read<GetNewsCubit>().get();
                      }
                    },
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.orange),
              ),
              BlocListener<DeleteNewsCubit, DeleteNewsState>(
                listener: (context, state) {
                  if (state is DeleteNewsSuccess) {
                    context.read<GetNewsCubit>().get();
                  }
                },
                child: IconButton(
                  onPressed: () => _handleDelete(newsDetails.id!),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleDelete(int id) {
    showYesNoDialog(
      context,
      title: 'Do you want to delete this news?',
      onYes: () => Navigator.pop(context, true),
    ).then(
      (isDeleted) {
        if (isDeleted == true) {
          context.read<DeleteNewsCubit>().delete(id);
        }
      },
    );
  }
}
