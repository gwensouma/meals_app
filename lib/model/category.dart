import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meals/service/extensions.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  Category({required this.id, required this.title, this.color = Colors.orange});

  final String id;
  final String title;
  @ColorConverter()
  Color color;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) => HexColor.fromHex(json);
  @override
  String toJson(Color object) => object.value.toString();
}
