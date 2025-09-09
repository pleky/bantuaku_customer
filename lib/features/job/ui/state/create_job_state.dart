import 'package:bantuaku_customer/features/job/model/skill_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'create_job_state.freezed.dart';

@freezed
abstract class CreateJobState with _$CreateJobState {
  const factory CreateJobState({
    @Default(false) bool isLoading,
    List<SkillResponse>? skills,
    @Default(false) bool isError,
    @Default(false) bool isSuccess,
    Position? currentLocation,
  }) = _CreateJobState;
}
