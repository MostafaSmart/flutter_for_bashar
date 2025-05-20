import '../../domain/entities/user.dart';

/// نموذج المستخدم
class UserModel extends User {
  const UserModel({
    required int id,
    required String username,
    required String email,
  }) : super(
          id: id,
          username: username,
          email: email,
        );

  /// إنشاء نموذج من JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  /// تحويل النموذج إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
