import 'package:crimson_cycle/core/common/provider/network_provider.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/category/data/repository/category_local_repository_impl.dart';
import 'package:crimson_cycle/features/category/data/repository/category_remote_repository_impl.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final categoryRepositoryProvider = Provider<ICategoryRepository>(
  (ref) {
    // return ref.watch(batchLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(categoryRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(categoryLocalRepoProvider);
    }
  },
);

abstract class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, bool>> addCategory(CategoryEntity category);
  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId);
        Future<Either<Failure, bool>> deleteCategory(String id);
}
