import 'package:crimson_cycle/features/category/data/model/category_api_model.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

final productApiModelProvider = Provider<ProductApiModel>((ref) {
  return ProductApiModel(
    productName: '',
    productDescription: '',
    productPrice: 0,
  );
});

@JsonSerializable()
class ProductApiModel {
  @JsonKey(name: '_id')
  final String? productId;
  final String productName;
  final String productDescription;
  final num? productPrice;
  final CategoryApiModel? category;
  final DateTime? createdAt;

  ProductApiModel({
    this.productId,
    required this.productName,
    required this.productDescription,
     this.productPrice,
    this.category,
    this.createdAt,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  ProductEntity toEntity(ProductApiModel productApiModel) => ProductEntity(
      id: productId,
      productName: productName,
      productDescription: productDescription,
      productPrice: productPrice!,
      category: category?.toEntity(),
      createdAt: createdAt);

  // Convert AuthApiModel list to AuthEntity list
  // List<ProductEntity> listFromJson(List<ProductApiModel> models) =>
  //     models.map((model) => model.toEntity()).toList();

  List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity(model)).toList();

  @override
  String toString() {
    return 'ProductApiModel(id: $productId, productName: $productName, productDescription: $productDescription,  productPrice: $productPrice, category: $category)';
  }
}
