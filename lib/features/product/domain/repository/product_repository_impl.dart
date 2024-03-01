import 'package:crimson_cycle/core/common/provider/network_provider.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/product/data/repository/product_remote_repository.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<IProductRepository>(
  (ref) {
    // return ref.watch(batchLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(productRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(productRemoteRepoProvider);
    }
  },
);

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, bool>> addProduct(ProductEntity product);
  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId);
        Future<Either<Failure, bool>> deleteProduct(String id);
}
