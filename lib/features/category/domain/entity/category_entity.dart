import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String name;
  final String? slug;

  @override
  List<Object?> get props => [categoryId, name, slug];

  const CategoryEntity({
    this.categoryId,
    required this.name,
    required this.slug,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
      categoryId: json["categoryId"], name: json["name"], slug: json["slug"]);

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
      };

  @override
  String toString() {
    return 'CategoryEntity(categoryId: $categoryId, name: $name, slug: $slug)';
  }
}
