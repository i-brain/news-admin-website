class DefaultPostResponse {
  final bool success;
  final String? message;

  DefaultPostResponse({
    required this.success,
    required this.message,
  });

  factory DefaultPostResponse.fromJson(Map<String, dynamic> json) =>
      DefaultPostResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
