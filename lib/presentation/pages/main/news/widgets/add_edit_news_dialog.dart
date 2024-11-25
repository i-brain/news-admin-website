import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/core/services/di.dart';
import 'package:news_admin/presentation/pages/main/category/data/get/cubit/cubit.dart';
import 'package:news_admin/presentation/pages/main/news/data/create_news/cubit/create_news_cubit.dart';
import 'package:news_admin/presentation/pages/main/news/data/create_news/request.dart';
import 'package:news_admin/presentation/pages/main/news/widgets/category_dropdown.dart';
import 'package:news_admin/presentation/pages/main/news/widgets/image_section.dart';
import 'package:news_admin/presentation/widgets/custom_text_field.dart';
import '../../../../widgets/custom_button.dart';
import '../../category/data/get/response.dart';
import '../data/edit_news/edit_news_cubit.dart';
import '../data/get_news/response.dart';

enum DialogType { create, edit }

class AddEditNewsDialog extends StatefulWidget {
  const AddEditNewsDialog({
    super.key,
    this.dialogType = DialogType.create,
    this.newsDetails,
  });
  final DialogType dialogType;
  final NewsDetails? newsDetails;

  static Future show(
    BuildContext context, {
    DialogType dialogType = DialogType.create,
    NewsDetails? newsDetails,
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
                create: (context) => CreateNewsCubit(getIt(), getIt()),
              ),
              BlocProvider(
                create: (context) => EditNewsCubit(getIt(), getIt()),
              ),
            ],
            child: AddEditNewsDialog(
              dialogType: dialogType,
              newsDetails: newsDetails,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<AddEditNewsDialog> createState() => _AddEditNewsDialogState();
}

class _AddEditNewsDialogState extends State<AddEditNewsDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final ValueNotifier<Category?> _categoryNotifier;
  late final ValueNotifier<Uint8List?> _imageNotifier;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.newsDetails?.title);
    _descriptionController = TextEditingController(
      text: widget.newsDetails?.details,
    );
    _categoryNotifier = ValueNotifier(widget.newsDetails?.category);
    _imageNotifier = ValueNotifier(null);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryNotifier.dispose();
    _imageNotifier.dispose();
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
              const SizedBox(height: 10),
              CustomTextField(
                controller: _descriptionController,
                hint: 'Description',
                maxLines: 4,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 10),
              BlocProvider(
                create: (context) => GetCategoryCubit(getIt())..get(),
                child: CategoryDropdown(valueNotifier: _categoryNotifier),
              ),
              const SizedBox(height: 32),
              ImageSection(
                imageNotifier: _imageNotifier,
                imageUrl: widget.newsDetails?.imageUrl,
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 200,
                  child: Builder(builder: (context) {
                    if (widget.dialogType == DialogType.create) {
                      return BlocConsumer<CreateNewsCubit, CreateNewsState>(
                        listener: (context, state) {
                          if (state is CreateNewsSuccess) {
                            Navigator.pop(context, true);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            onTap: _submitCreate,
                            title: 'Submit',
                            backgroundColor: Colors.green,
                            isLoading: state is CreateNewsLoading,
                          );
                        },
                      );
                    }
                    return BlocConsumer<EditNewsCubit, EditNewsState>(
                      listener: (context, state) {
                        if (state is EditNewsSuccess) {
                          Navigator.pop(context, true);
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          onTap: _submitEdit,
                          title: 'Submit',
                          backgroundColor: Colors.green,
                          isLoading: state is EditNewsLoading,
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
    if (_formKey.currentState!.validate() &&
        _validateCategory() &&
        _validateImage()) {
      final request = CreateNewsRequest(
        title: _titleController.text,
        details: _descriptionController.text,
        category: _categoryNotifier.value!,
      );

      context.read<CreateNewsCubit>().create(request, _imageNotifier.value!);
    }
  }

  void _submitEdit() {
    if (_formKey.currentState!.validate() &&
        _validateCategory() &&
        _validateImage()) {
      final request = CreateNewsRequest(
        title: _titleController.text,
        details: _descriptionController.text,
        category: _categoryNotifier.value!,
        imageUrl: widget.newsDetails?.imageUrl,
      );

      context.read<EditNewsCubit>().edit(
            widget.newsDetails!.id!,
            request,
            _imageNotifier.value,
          );
    }
  }

  bool _validateCategory() {
    return _categoryNotifier.value != null;
  }

  bool _validateImage() {
    return _imageNotifier.value != null || widget.newsDetails?.imageUrl != null;
  }
}
