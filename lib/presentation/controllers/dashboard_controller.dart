import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/providers/dashboard_navigation_provider.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  int build() {
    return ref.watch(dashboardNavProvider);
  }

  void navigateToTab(int index) {
    ref.read(dashboardNavProvider.notifier).state = index;
  }
}