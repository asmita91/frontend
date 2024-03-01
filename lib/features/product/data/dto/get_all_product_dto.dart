import 'package:crimson_cycle/features/product/data/model/product_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_product_dto.g.dart';

@JsonSerializable()
class GetAllProductDTO {
  final bool success;
  final int? count;
  final List<ProductApiModel> products;

  GetAllProductDTO({
    required this.success,
    this.count,
    required this.products,
  });

  Map<String, dynamic> toJson() => _$GetAllProductDTOToJson(this);

  factory GetAllProductDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProductDTOFromJson(json);
}
