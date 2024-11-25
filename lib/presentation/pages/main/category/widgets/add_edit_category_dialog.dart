import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/di.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../data/create/cubit/cubit.dart';
import '../data/create/request.dart';
import '../data/edit/cubit.dart';
import '../data/get/response.dart';

enum DialogType { create, edit }

class AddEditCategoryDialog extends StatefulWidget {
  const AddEditCategoryDialog({
    super.key,
    this.dialogType = DialogType.create,
    this.categoryDetails,
  });
  final DialogType dialogType;
  final Category? categoryDetails;

  static Future show(
    BuildContext context, {
    DialogType dialogType = DialogType.create,
    Category? categoryDetails,
  }) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CreateCategoryCubit(getIt()),
              ),
              BlocProvider(
                create: (context) => EditCategoryCubit(getIt()),
              ),
            ],
            child: AddEditCategoryDialog(
              dialogType: dialogType,
              categoryDetails: categoryDetails,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<AddEditCategoryDialog> createState() => _AddEditCategoryDialogState();
}

class _AddEditCategoryDialogState extends State<AddEditCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.categoryDetails?.name);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.6,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _titleController,
                hint: 'Title',
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 200,
                  child: Builder(builder: (context) {
                    if (widget.dialogType == DialogType.create) {
                      return BlocConsumer<CreateCategoryCubit,
                          CreateCategoryState>(
                        listener: (context, state) {
                          if (state is CreateCategorySuccess) {
                            Navigator.pop(context, true);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            onTap: _submitCreate,
                            title: 'Submit',
                            backgroundColor: Colors.green,
                            isLoading: state is CreateCategoryLoading,
                          );
                        },
                      );
                    }
                    return BlocConsumer<EditCategoryCubit, EditCategoryState>(
                      listener: (context, state) {
                        if (state is EditCategorySuccess) {
                          Navigator.pop(context, true);
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          onTap: _submitEdit,
                          title: 'Submit',
                          backgroundColor: Colors.green,
                          isLoading: state is EditCategoryLoading,
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitCreate() {
    if (_formKey.currentState!.validate()) {
      final request = CreateCategoryRequest(name: _titleController.text);

      context.read<CreateCategoryCubit>().create(request);
    }
  }

  void _submitEdit() {
    if (_formKey.currentState!.validate()) {
      final request = CreateCategoryRequest(name: _titleController.text);

      context
          .read<EditCategoryCubit>()
          .edit(widget.categoryDetails!.id, request);
    }
  }
}
