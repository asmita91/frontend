import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// This is necessary for the generator to work.
part 'article_api_model.g.dart';

@JsonSerializable()
class Article extends Equatable {
  final int? id;
  final String articleName;
  final String articleDescription;
   final String articleImageUrl;
  final String createdAt;

  const Article({
     this.id,
    required this.articleName,
    required this.articleDescription,
    required this.articleImageUrl,
    required this.createdAt,
  });

  // fromJson
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  List<Object?> get props => [id, articleName, articleDescription, createdAt];
}
