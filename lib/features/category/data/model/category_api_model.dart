import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_api_model.g.dart';

final categoryApiModelProvider = Provider<CategoryApiModel>(
  (ref) => const CategoryApiModel.empty(),
);

@JsonSerializable()
class CategoryApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? categoryId;
  final String name;
  final String? slug;

  const CategoryApiModel(
      {required this.categoryId, required this.name, required this.slug});
  const CategoryApiModel.empty()
      : categoryId = '',
        name = '',
        slug = '';

  Map<String, dynamic> toJson() => _$CategoryApiModelToJson(this);

  factory CategoryApiModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryApiModelFromJson(json);

  // Convert API Object to Entity
  CategoryEntity toEntity() => CategoryEntity(
        categoryId: categoryId,
        name: name,
        slug: slug,
      );

  // Convert Entity to API Object
  CategoryApiModel fromEntity(CategoryEntity entity) => CategoryApiModel(
      categoryId: entity.categoryId ?? '',
      name: entity.name,
      slug: entity.slug);

  // Convert API List to Entity List
  List<CategoryEntity> toEntityList(List<CategoryApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [categoryId, name, slug];
}
