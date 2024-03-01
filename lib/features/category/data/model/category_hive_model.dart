import 'package:crimson_cycle/config/constants/hive_table_constant.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'category_hive_model.g.dart';

final categoryHiveModelProvider = Provider(
  (ref) => CategoryHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.categoryTableId)
class CategoryHiveModel {
  @HiveField(0)
  final String categoryId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? slug;

  // empty constructor
  CategoryHiveModel.empty() : this(categoryId: '', name: '', slug: '');

  CategoryHiveModel({
    String? categoryId,
    required this.name,
     this.slug,
  }) : categoryId = categoryId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  CategoryEntity toEntity() =>
      CategoryEntity(categoryId: categoryId, name: name, slug: slug);

  // Convert Entity to Hive Object
  CategoryHiveModel toHiveModel(CategoryEntity entity) => CategoryHiveModel(
      // batchId: entity.batchId,
      name: entity.name,
      slug: entity.slug);

  // Convert Hive List to Entity List
  List<CategoryEntity> toEntityList(List<CategoryHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'categoryId: $categoryId, name: $name, slug: $slug';
  }
}
