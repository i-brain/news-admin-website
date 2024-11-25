// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../dialogs/yes_no_dialog.dart';
import '../data/delete/cubit.dart';
import '../data/get/cubit/cubit.dart';
import '../data/get/response.dart';
import 'add_edit_category_dialog.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
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
                "Category",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () async {
                  bool? isCategoryCreated =
                      await AddEditCategoryDialog.show(context);
                  if (isCategoryCreated == true) {
                    context.read<GetCategoryCubit>().get();
                  }
                },
                icon: const Icon(Icons.add_box_outlined, color: Colors.green),
              ),
            ],
          ),
          BlocBuilder<GetCategoryCubit, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategorySuccess) {
                final categories = state.categories;
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
                          label: Text("Action"),
                          headingRowAlignment: MainAxisAlignment.center),
                    ],
                    rows: List.generate(
                      categories.length,
                      (index) => _tableRow(context, categories[index]),
                    ),
                  ),
                );
              }

              if (state is GetCategoryFailure) {
                return Center(child: Text(state.message.toString()));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  DataRow _tableRow(BuildContext context, Category categoryDetails) {
    return DataRow(
      cells: [
        DataCell(Text(categoryDetails.id.toString())),
        DataCell(Text(categoryDetails.name.toString(), maxLines: 1)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  AddEditCategoryDialog.show(
                    context,
                    categoryDetails: categoryDetails,
                    dialogType: DialogType.edit,
                  ).then(
                    (isEdited) {
                      if (isEdited == true) {
                        context.read<GetCategoryCubit>().get();
                      }
                    },
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.orange),
              ),
              BlocListener<DeleteCategoryCubit, DeleteCategoryState>(
                listener: (context, state) {
                  if (state is DeleteCategorySuccess) {
                    context.read<GetCategoryCubit>().get();
                  }
                },
                child: IconButton(
                  onPressed: () => _handleDelete(categoryDetails.id),
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
      title: 'Do you want to delete this category?',
      onYes: () => Navigator.pop(context, true),
    ).then(
      (isDeleted) {
        if (isDeleted == true) {
          context.read<DeleteCategoryCubit>().delete(id);
        }
      },
    );
  }
}
