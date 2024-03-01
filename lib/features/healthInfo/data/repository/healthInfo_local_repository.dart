import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/healthInfo/data/data_source/healthInfo_local_data_source.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:crimson_cycle/features/healthInfo/domain/repository/healthInfo_repository_impl.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthInfoLocalRepoProvider = Provider<IHealthInfoRepository>((ref) {
  return HealthInfoLocalRepositoryImpl(
    healthInfoLocalDataSource: ref.read(healthInfoLocalDataSourceProvider),
  );
});

class HealthInfoLocalRepositoryImpl implements IHealthInfoRepository {
  final HealthInfoLocalDataSource healthInfoLocalDataSource;

  HealthInfoLocalRepositoryImpl({
    required this.healthInfoLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addOrUpdateHealthInfo(HealthInfoEntity healthInfo, String userId) {
    return healthInfoLocalDataSource.addOrUpdateHealthInfo(userId,healthInfo);
  }

  @override
  Future<Either<Failure, HealthInfoEntity?>> getHealthInfo(String userId) {
    return healthInfoLocalDataSource.getHealthInfo(userId);
  }

}
