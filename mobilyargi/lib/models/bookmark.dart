import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Bookmark {
  String usermail;
  String index;

  Bookmark({
    required this.usermail,
    required this.index,
  });
  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
