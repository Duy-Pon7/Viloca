import 'package:vietour/core/common/entities/user.dart';

//Mô hình dữ liệu của người dùng, chuyển đổi từ JSON sang đối tượng Dart
class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }
  factory UserModel.empty() {
    return UserModel(id: '', email: '', name: '');
  }
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
