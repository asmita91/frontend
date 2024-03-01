import 'package:crimson_cycle/features/dashboard/data/data_source/article_remote_data_source.dart';
import 'package:crimson_cycle/features/dashboard/presentation/state/article_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleViewModelProvider =
    StateNotifierProvider<ArticleViewModel, ArticleState>((ref) {
  final articleDataSource = ref.read(articleDataSourceProvider);
  return ArticleViewModel(articleDataSource);
});

class ArticleViewModel extends StateNotifier<ArticleState> {
  final ArticleDataSource _articleDataSource;
  ArticleViewModel(
    this._articleDataSource,
  ) : super(
          ArticleState.initial(),
        ) {
    getArticles();
  }

  Future resetState() async {
    state = ArticleState.initial();
    getArticles();
  }

  Future getArticles() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final articles = currentState.articles;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // Get data from data source
      final result = await _articleDataSource.getArticles(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              articles: [...articles, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
