import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Bookmark {
  String usermail;
  String index;

  final GestureTapCallback? onTap;
  Bookmark({
    required this.usermail,
    required this.index,
    this.onTap,
  });
  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
