import 'package:crimson_cycle/core/common/provider/network_provider.dart';
import 'package:crimson_cycle/core/failure/failure.dart';
import 'package:crimson_cycle/features/healthInfo/data/repository/healthInfo_local_repository.dart';
import 'package:crimson_cycle/features/healthInfo/data/repository/healthInfo_remote_repository.dart';
import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthInfoRepositoryProvider = Provider<IHealthInfoRepository>(
  (ref) {
    // Check for the internet connectivity
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available, use the remote repository
      return ref.watch(healthInfoRemoteRepoProvider);
    } else {
      // If internet is not available, use the local repository
      return ref.watch(healthInfoLocalRepoProvider);
    }
  },
);

abstract class IHealthInfoRepository {
  Future<Either<Failure, bool>> addOrUpdateHealthInfo(HealthInfoEntity healthInfo, String userId);
  Future<Either<Failure, HealthInfoEntity?>> getHealthInfo(String userId);
}
