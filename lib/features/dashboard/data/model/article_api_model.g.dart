// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as int?,
      articleName: json['articleName'] as String,
      articleDescription: json['articleDescription'] as String,
      articleImageUrl: json['articleImageUrl'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'articleName': instance.articleName,
      'articleDescription': instance.articleDescription,
      'articleImageUrl': instance.articleImageUrl,
      'createdAt': instance.createdAt,
    };
