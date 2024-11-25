class GetCategoryResponse {
  final bool success;
  final String? message;
  final List<Category> data;

  GetCategoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetCategoryResponse(
        success: json["success"],
        message: json["message"],
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
