import 'package:crimson_cycle/features/healthInfo/domain/entity/healthInfo_entity.dart';
import 'package:crimson_cycle/features/healthInfo/domain/use_case/healthInfo_usecase.dart';
import 'package:crimson_cycle/features/healthInfo/presentation/state/healthInfi_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthInfoViewModelProvider = StateNotifierProvider.family<HealthInfoViewModel, HealthInfoState, String>(
  (ref, userId) {
    return HealthInfoViewModel(
      ref.read(healthInfoUseCaseProvider),
      userId: userId,
    );
  },
);


class HealthInfoViewModel extends StateNotifier<HealthInfoState> {
  final HealthInfoUseCase healthInfoUseCase;
  final String userId;

  HealthInfoViewModel(this.healthInfoUseCase, {required this.userId})
      : super(HealthInfoState.initial()) {
    getHealthInfo(userId);
  }

  void addOrUpdateHealthInfo(HealthInfoEntity healthInfo) async {
    state = state.copyWith(isLoading: true);
    final result = await healthInfoUseCase.addOrUpdateHealthInfo(
        healthInfo.userId, healthInfo);

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (_) => getHealthInfo(healthInfo.userId),
    );
  }

  void getHealthInfo(String userId) async {
    state = state.copyWith(isLoading: true);
    final result = await healthInfoUseCase.getHealthInfo(userId);

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (healthInfo) => state =
          state.copyWith(isLoading: false, healthInfo: healthInfo, error: null),
    );
  }
}
