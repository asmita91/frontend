import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? userId;

  final String? image;
  final String email;
  final String lastName;

  final String firstName;
  final String? password;

  AuthApiModel({
    this.userId,
    this.image,
    required this.firstName,
    required this.email,
    required this.lastName,
    this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To entity
  factory AuthApiModel.toEntity(AuthApiModel apiModel) {
    return AuthApiModel(
        userId: apiModel.userId,
        image: apiModel.image,
        firstName: apiModel.firstName,
        password: apiModel.password,
        email: apiModel.email,
        lastName: apiModel.lastName);
  }

  // From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      userId: entity.id,
      image: entity.image,
      email: entity.email,
      lastName: entity.lastName,
      firstName: entity.firstName,
      password: entity.password,
    );
  }
}
