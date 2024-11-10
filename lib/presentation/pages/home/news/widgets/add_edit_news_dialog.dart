import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/presentation/widgets/custom_dropdown.dart';
import 'package:news_admin/presentation/widgets/custom_text_field.dart';
import '../../../../widgets/custom_button.dart';

class AddEditNewsDialog extends StatefulWidget {
  const AddEditNewsDialog({super.key});
  static Future show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const SimpleDialog(
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        children: [
          AddEditNewsDialog(),
        ],
      ),
    );
  }

  @override
  State<AddEditNewsDialog> createState() => _AddEditNewsDialogState();
}

class _AddEditNewsDialogState extends State<AddEditNewsDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final ValueNotifier<String?> _categoryNotifier;
  late final ValueNotifier<Uint8List?> _imageNotifier;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryNotifier = ValueNotifier(null);
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
          padding: const EdgeInsets.all(48).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16).r,
                child: Text('Title', style: context.style.bodyLarge),
              ),
              CustomTextField(
                  controller: _titleController, hint: 'Enter title here'),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.only(left: 16).r,
                child: Text('Description', style: context.style.bodyLarge),
              ),
              CustomTextField(
                controller: _descriptionController,
                hint: 'Enter description here',
                maxLines: 4,
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: 20.h),
              CustomDropdown(
                list: _categories,
                valueNotifier: _categoryNotifier,
                hint: 'Select Category',
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _pickImage,
                    child: Row(
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          color: Colors.blue,
                          size: 50.r,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          'Upload Image',
                          style: context.style.bodyLarge
                              ?.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 140.r,
                    width: 140.r,
                    child: ValueListenableBuilder(
                      valueListenable: _imageNotifier,
                      builder: (context, value, child) {
                        if (_imageNotifier.value != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              _imageNotifier.value!,
                              height: 140.r,
                              width: 140.r,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return Icon(Icons.photo, size: 140.r);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Center(
                child: CustomButton(
                  onTap: _submitForm,
                  title: 'Submit',
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final fromPicker = await ImagePickerWeb.getImageAsBytes();
    _imageNotifier.value = fromPicker;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _validateCategory()) {
      // Handle form submission
    }
  }

  bool _validateCategory() {
    return _categoryNotifier.value != null;
  }

  List<String> get _categories =>
      ['Politics', 'Sports', 'Technology', 'Health'];
}
