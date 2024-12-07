import 'package:news_admin/presentation/pages/main/users/data/response.dart';

class UpdateUserRequest {
  final String id;
  final Role role;

  UpdateUserRequest({
    required this.id,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        "role": role.value,
      };
}
