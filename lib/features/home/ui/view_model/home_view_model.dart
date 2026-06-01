import 'package:bantuaku_customer/features/authentication/repository/auth_repository.dart';
import 'package:bantuaku_customer/features/home/ui/state/home_state.dart';
import 'package:flutter/rendering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<HomeState> build() {
    return HomeState();
  }
}
