import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:crimson_cycle/features/healthInfo/domain/repository/healthInfo_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthInfoUseCaseProvider = Provider<HealthInfoUseCase>(
  (ref) => HealthInfoUseCase(
    healthInfoRepository: ref.watch(healthInfoRepositoryProvider),
  ),
);

class HealthInfoUseCase {
  final IHealthInfoRepository healthInfoRepository;

  HealthInfoUseCase({required this.healthInfoRepository});

  Future<Either<Failure, bool>> addOrUpdateHealthInfo(String userId, HealthInfoEntity healthInfo) {
    return healthInfoRepository.addOrUpdateHealthInfo(healthInfo, userId);
  }

  Future<Either<Failure, HealthInfoEntity?>> getHealthInfo(String userId) {
    return healthInfoRepository.getHealthInfo(userId);
  }

}
