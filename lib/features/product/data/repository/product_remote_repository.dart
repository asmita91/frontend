import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/product/data/data_source/product_remote_data_source.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:crimson_cycle/features/product/domain/repository/product_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteRepoProvider = Provider<IProductRepository>(
  (ref) => ProductRemoteRepoImpl(
    productRemoteDataSource: ref.read(productRemoteDataSourceProvider),
  ),
);

class ProductRemoteRepoImpl implements IProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepoImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productRemoteDataSource.getAllProducts();
  }

  // @override
  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId) {
  //   return batchRemoteDataSource.getAllStudentsByBatch(batchId);
  // }

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) {
    return productRemoteDataSource.deleteProduct(id);
  }

  @override
  Future<Either<Failure, bool>> addProduct(ProductEntity product) {
    return productRemoteDataSource.addProduct(product);
  }
}
