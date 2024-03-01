import 'package:crimson_cycle/features/category/data/model/category_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_category_dto.g.dart';

@JsonSerializable()
class GetAllCategoryDTO {
  final bool success;
  final int? count;
  final List<CategoryApiModel> category;

  GetAllCategoryDTO({
    required this.success,
    this.count,
    required this.category,
  });

  Map<String, dynamic> toJson() => _$GetAllCategoryDTOToJson(this);

  factory GetAllCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoryDTOFromJson(json);
}
