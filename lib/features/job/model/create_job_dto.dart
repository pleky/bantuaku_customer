import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_job_dto.freezed.dart';
part 'create_job_dto.g.dart';

@freezed
abstract class CreateJobDto with _$CreateJobDto {
  const factory CreateJobDto({
    required List<String> files,
    required String title,
    required String description,
    required String latitude,
    required String longitude,
    @JsonKey(name: 'latitude_customer') required String latitudeCustomer,
    @JsonKey(name: 'longitude_customer') required String longitudeCustomer,
    required String address,
    required String budget,
    String? skill,
  }) = _CreateJobDto;

  factory CreateJobDto.fromJson(Map<String, dynamic> json) => _$CreateJobDtoFromJson(json);
}

extension CreateJobDtoExtension on CreateJobDto {
  FormData toFormData() {
    final formData = FormData.fromMap({
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'latitude_customer': latitudeCustomer,
      'longitude_customer': longitudeCustomer,
      'address': address,
      'budget': budget,
      'skill': skill,
    });

    if (files.isNotEmpty) {
      final fileList = files.map((filePath) {
        return MultipartFile.fromFileSync(
          filePath,
          filename: filePath.split('/').last,
        );
      }).toList();

      formData.files.addAll(fileList.map((file) => MapEntry('image_path[]', file)));
    }

    return formData;
  }
}
