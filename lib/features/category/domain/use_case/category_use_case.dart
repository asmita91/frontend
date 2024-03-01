import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:crimson_cycle/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryUsecaseProvider = Provider<CategoryUseCase>(
  (ref) => CategoryUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
  ),
);

class CategoryUseCase {
  final ICategoryRepository categoryRepository;

  CategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    return categoryRepository.getAllCategories();
  }

  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    return categoryRepository.addCategory(category);
  }

  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId) {
  //   return batchRepository.getAllStudentsByBatch(batchId);
  // }

  Future<Either<Failure, bool>> deleteCategory(String id) async {
    return categoryRepository.deleteCategory(id);
  }
}
