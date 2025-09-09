import 'package:flutter/widgets.dart';
import 'package:bantuaku_customer/features/common/remote/api_client.dart';
import 'package:bantuaku_customer/features/job/model/create_job_dto.dart';
import 'package:bantuaku_customer/features/job/model/skill_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'job_repository.g.dart';

@riverpod
JobRepository jobRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return JobRepository(apiClient);
}

class JobRepository {
  final ApiClient apiClient;

  JobRepository(this.apiClient);

  Future<bool> createJobPosting(CreateJobDto payload) async {
    try {
      debugPrint("Creating job with payload: ${payload.toJson()}");

      await apiClient.post(
        '/customer/job-posting',
        data: payload.toFormData(),
      );

      return true;
    } on BadRequestException catch (e) {
      throw e.message;
    } catch (e) {
      throw Exception('Unexpected error occurred during job creation: ${e.toString()}');
    }
  }

  Future<List<SkillResponse>> getSkills() async {
    try {
      final response = await apiClient.get('/skills');
      final res = SkillResponseListExtension.fromJsonList(response['data']);
      return res;
    } catch (e) {
      print(e.toString());
      throw Exception('Unexpected error occurred while fetching skills');
    }
  }
}
