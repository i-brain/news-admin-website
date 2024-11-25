import '../../../category/data/get/response.dart';

class CreateNewsRequest {
  final String title;
  String? imageUrl;
  final String details;
  final Category category;

  CreateNewsRequest({
    required this.title,
    required this.details,
    required this.category,
    this.imageUrl,
  });

  void setImageUrl(String url) {
    imageUrl = url;
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "imageUrl": imageUrl,
        "details": details,
        "category": category.toJson(),
      };
}
