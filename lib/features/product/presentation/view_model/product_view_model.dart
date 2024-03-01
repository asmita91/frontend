import 'package:crimson_cycle/core/common/snackbar/my_snackbar.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:crimson_cycle/features/product/domain/use_case/product_usecase.dart';
import 'package:crimson_cycle/features/product/presentation/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
  (ref) {
    return ProductViewModel(ref.read(productUseCaseProvider));
  },
);

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductUseCase productUseCase;

  ProductViewModel(this.productUseCase) : super(ProductState.initial()) {
    getAllProducts();
  }

  addProduct(ProductEntity product) async {
    state = state.copyWith(isLoading: true);
    var data = await productUseCase.addProduct(product);

    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) async => await getAllProducts());
  }

  Future<void> getAllProducts() async {
    state = state.copyWith(isLoading: true);
    var data = await productUseCase.getAllProducts();
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        print("Error fetching data: $l");
      },
      (r) {
        state = state.copyWith(isLoading: false, products: r, error: null);
        print("Data in viewModel $r");
      },
    );
  }

  // getStudentsByBatch(BuildContext context, String batchId) async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await batchUseCase.getAllStudentsByBatch(batchId);

  //   data.fold(
  //     (l) => state = state.copyWith(isLoading: false, error: l.error),
  //     (r) {
  //       state = state.copyWith(isLoading: false, students: r, error: null);
  //       Navigator.pushNamed(context, AppRoute.batchStudentRoute);
  //     },
  //   );
  // }

  Future<void> deleteProduct(
      BuildContext context, ProductEntity product) async {
    state = state.copyWith(isLoading: true);
    var data = await productUseCase.deleteProduct(product.id!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.products.remove(product);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Product delete successfully',
          context: context,
        );
      },
    );
  }

  void reset() {
    state = state.copyWith(isLoading: false, error: null, products: []);
  }

  resetState() {
    state = state.copyWith(isLoading: false, error: null, products: []);
  }
}
