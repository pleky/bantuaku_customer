import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_model.freezed.dart';
part 'worker_model.g.dart';

@freezed
abstract class WorkerModel with _$WorkerModel {
  const factory WorkerModel({
    required String id,
    required String name,
    required String profilePictureUrl,
    required double rating,
  }) = _WorkerModel;

  factory WorkerModel.fromJson(Map<String, dynamic> json) => _$WorkerModelFromJson(json);
}

List<WorkerModel> dummyWorkers = [
  WorkerModel(
    id: '1',
    name: 'Alice',
    profilePictureUrl: 'https://example.com/alice.jpg',
    rating: 4.5,
  ),
  WorkerModel(
    id: '2',
    name: 'Bob',
    profilePictureUrl: 'https://example.com/bob.jpg',
    rating: 4.0,
  ),
  WorkerModel(
    id: '3',
    name: 'Charlie',
    profilePictureUrl: 'https://example.com/charlie.jpg',
    rating: 3.5,
  ),
  WorkerModel(
    id: '4',
    name: 'Charlie',
    profilePictureUrl: 'https://example.com/charlie.jpg',
    rating: 3.5,
  ),
  WorkerModel(
    id: '5',
    name: 'Ethan',
    profilePictureUrl: 'https://example.com/ethan.jpg',
    rating: 4.8,
  ),
  WorkerModel(
    id: '6',
    name: 'Frank',
    profilePictureUrl: 'https://example.com/frank.jpg',
    rating: 4.2,
  ),
  WorkerModel(
    id: '7',
    name: 'Grace',
    profilePictureUrl: 'https://example.com/grace.jpg',
    rating: 4.1,
  ),
];
