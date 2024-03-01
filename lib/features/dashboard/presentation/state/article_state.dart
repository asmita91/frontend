import 'package:crimson_cycle/features/dashboard/data/model/article_api_model.dart';

class ArticleState {
  final List<Article> articles;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  ArticleState({
    required this.articles,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory ArticleState.initial() {
    return ArticleState(
      articles: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  ArticleState copyWith({
    List<Article>? articles,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return ArticleState(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
