// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      userId: json['_id'] as String?,
      image: json['image'] as String?,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'image': instance.image,
      'email': instance.email,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'password': instance.password,
    };
