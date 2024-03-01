import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/category/data/data_source/category_remote_data_source.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:crimson_cycle/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRemoteRepoProvider = Provider<ICategoryRepository>(
  (ref) => CategoryRemoteRepositoryImpl(
    categoryRemoteDataSource: ref.read(categoryRemoteDataSourceProvider),
  ),
);

class CategoryRemoteRepositoryImpl implements ICategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRemoteRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    return categoryRemoteDataSource.addCategory(category);
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    return categoryRemoteDataSource.getAllCategories();
  }

  // @override
  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId) {
  //   return batchRemoteDataSource.getAllStudentsByBatch(batchId);
  // }

  @override
  Future<Either<Failure, bool>> deleteCategory(String id) {
    return categoryRemoteDataSource.deleteCategory(id);
  }
}
