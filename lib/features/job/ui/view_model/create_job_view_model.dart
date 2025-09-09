import 'package:bantuaku_customer/features/job/model/create_job_dto.dart';
import 'package:bantuaku_customer/features/job/model/skill_response.dart';
import 'package:bantuaku_customer/features/job/repository/job_repository.dart';
import 'package:bantuaku_customer/features/job/ui/state/create_job_state.dart';
import 'package:bantuaku_customer/utils/location_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_job_view_model.g.dart';

@riverpod
class CreateJobViewModel extends _$CreateJobViewModel {
  @override
  FutureOr<CreateJobState> build() async {
    // Saat provider pertama kali dibuat, langsung load data
    _getCurrentLocation();

    return Future.value(CreateJobState(
      currentLocation: state.value?.currentLocation,
    ));
  }

  /// Public method untuk refresh data
  Future<List<SkillResponse>> fetchSkills() async {
    final jobRepo = ref.read(jobRepositoryProvider);
    return jobRepo.getSkills();
  }

  Future<void> _getCurrentLocation() async {
    final LocationHelper locationHelper = LocationHelper();
    final location = await locationHelper.getCurrentLocation();

    state =
        AsyncValue.data(state.value?.copyWith(currentLocation: location) ?? CreateJobState(currentLocation: location));
  }

  Future<void> handleCreateJob(CreateJobDto payload) async {
    state = const AsyncValue.loading();
    final jobRepo = ref.read(jobRepositoryProvider);
    final result = await AsyncValue.guard(() => jobRepo.createJobPosting(payload));

    if (result is AsyncError) {
      state = AsyncValue.error(result.error.toString(), StackTrace.current);
      return;
    }

    state = AsyncValue.data(
        state.value?.copyWith(isLoading: false, isSuccess: true) ?? CreateJobState(isLoading: false, isSuccess: true));
  }
}
