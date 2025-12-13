import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String? id;
  final String name;
  final String? description;
  final String? slug;
  final String? iconUrl;
  final String? bannerUrl;
  final int? followerCount;
  final bool? isFeatured;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? specialColor;
  final List? followers;

  CategoryModel({
    this.id,
    required this.name,
    this.description,
    this.slug,
    this.iconUrl,
    this.bannerUrl,
    this.followerCount,
    this.isFeatured,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.specialColor,
    this.followers,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
