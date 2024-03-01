import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String productName;
  final String productDescription;
  final num? productPrice;
  final CategoryEntity? category;
  final DateTime? createdAt;

  @override
  List<Object?> get props =>
      [id, productName, productDescription, productPrice, createdAt, category];

  const ProductEntity(
      {this.id,
      required this.productName,
      required this.productDescription,
      this.productPrice,
      this.category,
      required this.createdAt});

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
      id: json["id"],
      productName: json["productName"],
      productDescription: json["productDescription"],
      productPrice: json["productPrice"],
      category: CategoryEntity.fromJson(json["category"]),
      createdAt: json["createdAt"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "productDescription": productDescription,
        "productPrice": productPrice,
        "category": category == null ? null : category!.toJson(),
        "createdAt": createdAt
      };
}
