// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 1)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String? profilePic;

  UserHiveModel({
    required this.userName,
    required this.email,
    required this.password,
     this.profilePic,
  });






  UserHiveModel copyWith({
    String? userName,
    String? email,
    String? password,
    String? profilePic,
  }) {
    return UserHiveModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'password': password,
      'profilePic': profilePic,
    };
  }

  factory UserHiveModel.fromMap(Map<String, dynamic> map) {
    return UserHiveModel(
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePic: map['profilePic'] != null ? map['profilePic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserHiveModel.fromJson(String source) => UserHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserHiveModel(userName: $userName, email: $email, password: $password, profilePic: $profilePic)';
  }

  @override
  bool operator ==(covariant UserHiveModel other) {
    if (identical(this, other)) return true;

    return
      other.userName == userName &&
      other.email == email &&
      other.password == password &&
      other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      profilePic.hashCode;
  }
}
