import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/responsive.dart';
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
        backgroundColor: Colors.white,
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
              CustomDropdown(
                list: _categories,
                valueNotifier: _categoryNotifier,
                hint: 'Select Category',
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder(
                valueListenable: _imageNotifier,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _pickImage,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              color: Colors.blue,
                              size: 50,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Upload Image',
                              style: context.style.bodyLarge
                                  ?.copyWith(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      if (_imageNotifier.value != null &&
                          !Responsive.isMobile(context))
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              _imageNotifier.value!,
                              height: 140,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 200,
                  child: CustomButton(
                    onTap: _submitForm,
                    title: 'Submit',
                    backgroundColor: Colors.green,
                  ),
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
