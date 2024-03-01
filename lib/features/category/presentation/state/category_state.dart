import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final String? error;

  CategoryState({
    required this.isLoading,
    required this.categories,
    this.error,
  });

  factory CategoryState.initial() {
    return CategoryState(
      isLoading: false,
      categories: [],
    );
  }

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    String? error,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }
}
