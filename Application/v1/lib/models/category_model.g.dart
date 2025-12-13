// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      iconUrl: json['iconUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      followerCount: (json['followerCount'] as num?)?.toInt(),
      isFeatured: json['isFeatured'] as bool?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      specialColor: json['specialColor'] as String?,
      followers: json['followers'] as List?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'slug': instance.slug,
      'iconUrl': instance.iconUrl,
      'bannerUrl': instance.bannerUrl,
      'followerCount': instance.followerCount,
      'isFeatured': instance.isFeatured,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'specialColor': instance.specialColor,
      'followers': instance.followers,
    };
