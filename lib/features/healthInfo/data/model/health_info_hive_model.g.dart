// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_info_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthInfoHiveModelAdapter extends TypeAdapter<HealthInfoHiveModel> {
  @override
  final int typeId = 2;

  @override
  HealthInfoHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthInfoHiveModel(
      id: fields[0] as String?,
      userId: fields[9] as String,
      age: fields[1] as int,
      height: fields[2] as int,
      weight: fields[3] as int,
      lastPeriodDate: fields[4] as DateTime,
      periodDays: fields[5] as int,
      periodInterval: fields[6] as int,
      isRegularPeriod: fields[7] as bool,
      hasCramps: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HealthInfoHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.lastPeriodDate)
      ..writeByte(5)
      ..write(obj.periodDays)
      ..writeByte(6)
      ..write(obj.periodInterval)
      ..writeByte(7)
      ..write(obj.isRegularPeriod)
      ..writeByte(8)
      ..write(obj.hasCramps)
      ..writeByte(9)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthInfoHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
