import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/presentation/widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';

class AddEditNewsBody extends StatefulWidget {
  const AddEditNewsBody({super.key});
  static Future show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const SimpleDialog(
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        children: [
          AddEditNewsBody(),
        ],
      ),
    );
  }

  @override
  State<AddEditNewsBody> createState() => _AddEditNewsBodyState();
}

class _AddEditNewsBodyState extends State<AddEditNewsBody> {
  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final ValueNotifier<Uint8List?> _imageNotifier;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _imageNotifier = ValueNotifier(null);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(56).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16).r,
                child: Text('Title', style: context.style.bodyLarge),
              ),
              CustomTextField(controller: _titleController, hint: 'Title'),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    'Qiymət: ',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: _priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      hint: 'Title',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _pickImage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  label: const Text(
                    'Şəkil seç',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.image, color: Colors.white),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: SizedBox(
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
                            fit: BoxFit.fill,
                          ),
                        );
                      }
                      return Icon(Icons.photo, size: 140.r);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onTap: () {},
                title: 'Təsdiqlə',
                backgroundColor: Colors.green,
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
}
