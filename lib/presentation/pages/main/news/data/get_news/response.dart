import '../../../category/data/get/response.dart';

class GetNewsResponse {
  final bool success;
  final String? message;
  final List<NewsDetails> data;

  GetNewsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetNewsResponse.fromJson(Map<String, dynamic> json) =>
      GetNewsResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NewsDetails>.from(
                json["data"]!.map((x) => NewsDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsDetails {
  final int? id;
  final String? title;
  final String? imageUrl;
  final String? details;
  final Category? category;

  NewsDetails({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.details,
    required this.category,
  });

  factory NewsDetails.fromJson(Map<String, dynamic> json) => NewsDetails(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        details: json["details"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "details": details,
        "category": category?.toJson(),
      };
}
