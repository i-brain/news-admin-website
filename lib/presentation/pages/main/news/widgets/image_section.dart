import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:news_admin/core/extension.dart';
import '../../../../../responsive.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.imageNotifier, this.imageUrl});
  final ValueNotifier<Uint8List?> imageNotifier;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imageNotifier,
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
                    style:
                        context.style.bodyLarge?.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ),
            if ((imageNotifier.value != null || imageUrl != null) &&
                !Responsive.isMobile(context))
              SizedBox(
                height: 140,
                width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageNotifier.value != null
                      ? Image.memory(
                          imageNotifier.value!,
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          imageUrl!,
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _pickImage() async {
    final fromPicker = await ImagePickerWeb.getImageAsBytes();
    imageNotifier.value = fromPicker;
  }
}
