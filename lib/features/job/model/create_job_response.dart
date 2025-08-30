import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_job_response.freezed.dart';
part 'create_job_response.g.dart';

@freezed
abstract class CreateJobResponse with _$CreateJobResponse {
  const factory CreateJobResponse({
    required int id,
    required String title,
    required String description,
    required String latitude,
    required String longitude,
    @JsonKey(name: 'latitude_customer') required String latitudeCustomer,
    @JsonKey(name: 'longitude_customer') required String longitudeCustomer,
    required String budget,
    @JsonKey(name: 'is_skill') required bool isSkill,
    @JsonKey(name: 'image_path') required List<String> imagePath,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'created_at') required String createdAt,
    String? status,
    String? message,
  }) = _CreateJobResponse;

  factory CreateJobResponse.fromJson(Map<String, dynamic> json) => _$CreateJobResponseFromJson(json);
}
