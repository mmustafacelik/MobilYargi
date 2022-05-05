import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UsersInfo {
  String mail;
  String nickname;
  bool isAdmin;
  List<String>? likedsubjects;
  List<String>? comments;
  UsersInfo({
    required this.mail,
    required this.nickname,
    required this.isAdmin,
  });
}
