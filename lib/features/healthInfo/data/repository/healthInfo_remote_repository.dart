import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/healthInfo/data/data_source/healthInfo_remote_data_source.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:crimson_cycle/features/healthInfo/domain/repository/healthInfo_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthInfoRemoteRepoProvider = Provider<IHealthInfoRepository>(
  (ref) => HealthInfoRemoteRepositoryImpl(
    healthInfoRemoteDataSource: ref.read(healthInfoRemoteDataSourceProvider),
  ),
);

class HealthInfoRemoteRepositoryImpl implements IHealthInfoRepository {
  final HealthInfoRemoteDataSource healthInfoRemoteDataSource;

  HealthInfoRemoteRepositoryImpl({required this.healthInfoRemoteDataSource});


  @override
  Future<Either<Failure, HealthInfoEntity?>> getHealthInfo(String userId) {
    return healthInfoRemoteDataSource.getHealthInfo(userId);
  }
  
  @override
  Future<Either<Failure, bool>> addOrUpdateHealthInfo(HealthInfoEntity healthInfo, String userId) {
        return healthInfoRemoteDataSource.addOrUpdateHealthInfo(healthInfo, userId);

  }
  
 

}
