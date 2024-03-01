import 'package:crimson_cycle/core/common/snackbar/my_snackbar.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:crimson_cycle/features/category/domain/use_case/category_use_case.dart';
import 'package:crimson_cycle/features/category/presentation/state/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, CategoryState>(
  (ref) {
    return CategoryViewModel(ref.read(categoryUsecaseProvider));
  },
);

class CategoryViewModel extends StateNotifier<CategoryState> {
  final CategoryUseCase categoryUseCase;

  CategoryViewModel(this.categoryUseCase) : super(CategoryState.initial()) {
    getAllCategories();
  }

  addCategory(CategoryEntity category) async {
    state.copyWith(isLoading: true);
    var data = await categoryUseCase.addCategory(category);

    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) async => await getAllCategories());
  }

  getAllCategories() async {
    state = state.copyWith(isLoading: true);
    var data = await categoryUseCase.getAllCategories();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) =>
          state = state.copyWith(isLoading: false, categories: r, error: null),
    );
  }

  // getStudentsByBatch(BuildContext context, String batchId) async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await categoryUseCase.getAllStudentsByBatch(batchId);

  //   data.fold(
  //     (l) => state = state.copyWith(isLoading: false, error: l.error),
  //     (r) {
  //       state = state.copyWith(isLoading: false, students: r, error: null);
  //       Navigator.pushNamed(context, AppRoute.batchStudentRoute);
  //     },
  //   );
  // }

  Future<void> deleteCategory(
      BuildContext context, CategoryEntity category) async {
    state.copyWith(isLoading: true);
    var data = await categoryUseCase.deleteCategory(category.categoryId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.categories.remove(category);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Category delete successfully',
          context: context,
        );
      },
    );
  }
}
