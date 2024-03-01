import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/core/network/hive_service.dart';
import 'package:crimson_cycle/features/healthInfo/data/model/health_info_hive_model.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dependency Injection using Riverpod
final healthInfoLocalDataSourceProvider = Provider<HealthInfoLocalDataSource>((ref) {
  return HealthInfoLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      healthInfoHiveModel: ref.read(healthInfoHiveModelProvider)); // Assuming you have this provider defined
});

class HealthInfoLocalDataSource {
  final HiveService hiveService;
  final HealthInfoHiveModel healthInfoHiveModel;

  HealthInfoLocalDataSource({
    required this.hiveService,
    required this.healthInfoHiveModel,
  });

  Future<Either<Failure, bool>> addOrUpdateHealthInfo(String userId, HealthInfoEntity healthInfo) async {
  try {
    // Assuming HealthInfoHiveModel.fromEntity(healthInfo) is adjusted to include userId or
    // you manage user-specific data within the method logic here
    final hiveHealthInfo = HealthInfoHiveModel.fromEntity(healthInfo); // This is hypothetical and would require adjustment in your model
    
    // Add/Update to Hive, potentially using userId as part of the key or storage logic
    await hiveService.addOrUpdateHealthInfo(userId, hiveHealthInfo);
    
    return const Right(true);
  } catch (e) {
    return Left(Failure(error: e.toString()));
  }
}


  Future<Either<Failure, HealthInfoEntity?>> getHealthInfo(String userId) async {
    try {
      // Get from Hive
      final hiveHealthInfo = await hiveService.getHealthInfoById(userId);
      // Convert Hive Object to Entity if not null
      final healthInfoEntity = hiveHealthInfo?.toEntity();
      return Right(healthInfoEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

}
