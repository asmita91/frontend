import 'package:crimson_cycle/config/constants/hive_table_constant.dart';
import 'package:crimson_cycle/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(4)
  final String firstName;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final String email;

  @HiveField(7)
  final String lastName;

  // Constructor
  AuthHiveModel(
      {String? userId,
      required this.firstName,
      required this.password,
      required this.email,
      required this.lastName})
      : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(userId: '', firstName: '', password: '', email: '', lastName: '');

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
      id: userId,
      firstName: firstName,
      password: password,
      email: email,
      lastName: lastName);

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
      userId: const Uuid().v4(),
      firstName: entity.firstName,
      password: entity.password,
      email: entity.email,
      lastName: lastName);

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId,   firstName: $firstName, password: $password, email: $email, lastName:$lastName ';
  }
}
