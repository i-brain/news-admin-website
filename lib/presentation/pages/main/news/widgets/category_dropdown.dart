import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/presentation/pages/main/category/data/get/cubit/cubit.dart';
import 'package:news_admin/presentation/pages/main/category/data/get/response.dart';
import 'package:news_admin/presentation/widgets/custom_dropdown.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key, required this.valueNotifier});
  final ValueNotifier<Category?> valueNotifier;
  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoryCubit, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategorySuccess) {
          final categories = state.categories;
          return CustomDropdown(
            list: categories.map((category) => category.name).toList(),
            initiValue: widget.valueNotifier.value?.name,
            onTap: (value) {
              widget.valueNotifier.value =
                  categories.firstWhere((category) => category.name == value);
            },
            hint: 'Select Category',
          );
        }
        return CustomDropdown(
          list: const [],
          onTap: (value) {},
          hint: 'Loading...',
        );
      },
    );
  }
}
