import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.g.dart';
part 'job_model.freezed.dart';

@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    required String id,
    required String title,
    required String description,
    required String company,
    required String location,
    required String date,
    required String status,
    required String price,
    required String createdAt,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
}

const joblistData = [
  JobModel(
    id: '1',
    title: 'Software Engineer',
    description: 'Develop and maintain software applications.',
    company: 'Tech Company',
    location: 'Remote',
    date: '2023-01-01',
    status: 'DONE',
    price: '100000',
    createdAt: '2023-01-01',
  ),
  JobModel(
    id: '2',
    title: 'Product Manager',
    description: 'Lead product development and strategy.',
    company: 'Another Tech Company',
    location: 'On-site',
    date: '2023-02-01',
    status: 'CANCELED',
    price: '0',
    createdAt: '2023-02-01',
  ),
  JobModel(
    id: '3',
    title: 'Data Scientist',
    description: 'Analyze and interpret complex data.',
    company: 'Data Company',
    location: 'Remote',
    date: '2023-03-01',
    status: 'CANCELED',
    price: '0',
    createdAt: '2023-03-01',
  ),
];
