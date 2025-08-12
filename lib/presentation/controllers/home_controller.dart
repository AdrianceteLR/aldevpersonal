import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/providers/finance_provider.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  AsyncValue<Map<String, double>> build() {
    return ref.watch(financeSummaryProvider);
  }

  void refreshData() {
    ref.refresh(financeSummaryProvider);
  }
}