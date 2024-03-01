import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:crimson_cycle/features/product/domain/repository/product_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUseCaseProvider = Provider<ProductUseCase>(
  (ref) => ProductUseCase(
    productRepository: ref.watch(productRepositoryProvider),
  ),
);

class ProductUseCase {
  final IProductRepository productRepository;

  ProductUseCase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productRepository.getAllProducts();
  }

  Future<Either<Failure, bool>> addProduct(ProductEntity product) {
    return productRepository.addProduct(product);
  }

  // Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
  //     String batchId) {
  //   return batchRepository.getAllStudentsByBatch(batchId);
  // }

  Future<Either<Failure, bool>> deleteProduct(String id) async {
    return productRepository.deleteProduct(id);
  }
}
