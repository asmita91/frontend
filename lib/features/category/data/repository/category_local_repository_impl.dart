import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/category/data/data_source/category_local_data_source.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:crimson_cycle/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final categoryLocalRepoProvider = Provider<ICategoryRepository>((ref) {
  return CategoryLocalRepositoryImpl(
    categoryLocalDataSource: ref.read(categoryLocalDataSourceProvider),
  );
});

class CategoryLocalRepositoryImpl implements ICategoryRepository {
  final CategoryLocalDataSource categoryLocalDataSource;

  CategoryLocalRepositoryImpl({
    required this.categoryLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    return categoryLocalDataSource.addCategory(category);
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    return categoryLocalDataSource.getAllCategories();
  }

  // @override
  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId) {
  //   // TODO: implement getAllStudentsByBatch
  //   throw UnimplementedError();
  // }
  @override
  Future<Either<Failure, bool>> deleteCategory(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }
}
