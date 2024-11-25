class CreateCategoryRequest {
  final String name;

  CreateCategoryRequest({
    required this.name,
  });

  factory CreateCategoryRequest.fromJson(Map<String, dynamic> json) =>
      CreateCategoryRequest(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
