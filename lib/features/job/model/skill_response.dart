// generate freezed

import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_response.freezed.dart';
part 'skill_response.g.dart';

@freezed
abstract class SkillResponse with _$SkillResponse {
  const factory SkillResponse({
    required int id,
    @JsonKey(name: "nama_skill") required String namaSkill,
    @JsonKey(name: 'is_aktif') required bool isAktif,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _SkillResponse;

  factory SkillResponse.fromJson(Map<String, dynamic> json) => _$SkillResponseFromJson(json);
}

// create extension to convert to list of skillResponse from dio response
extension SkillResponseListExtension on List<SkillResponse> {
  static List<SkillResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SkillResponse.fromJson(json)).toList();
  }
}
