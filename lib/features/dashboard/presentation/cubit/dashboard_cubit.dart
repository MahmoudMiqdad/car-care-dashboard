import 'package:car_care/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:car_care/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final IDashboardRepository _repo;
  DashboardCubit(this._repo) : super(DashboardInitial());

  DashboardLoaded? _last;

  Future<void> loadDashboard({String period = 'month'}) async {
    emit(DashboardLoading());

    final summaryRes = await _repo.getDashboardSummary();
    final operationsRes = await _repo.getDashboardOperations(period: period);
    final revenueRes = await _repo.getDashboardRevenue();
    final adsRes = await _repo.getActiveAdvertisements();

    if (summaryRes.isLeft()) {
      return summaryRes.fold((l) => emit(DashboardError(l.message)), (_) {});
    }
    if (operationsRes.isLeft()) {
      return operationsRes.fold((l) => emit(DashboardError(l.message)), (_) {});
    }
    if (revenueRes.isLeft()) {
      return revenueRes.fold((l) => emit(DashboardError(l.message)), (_) {});
    }
    if (adsRes.isLeft()) {
      return adsRes.fold((l) => emit(DashboardError(l.message)), (_) {});
    }

    final loaded = DashboardLoaded(
      summary: summaryRes.getOrElse(() => throw Exception()),
      operations: operationsRes.getOrElse(() => throw Exception()),
      revenue: revenueRes.getOrElse(() => throw Exception()),
      advertisements: adsRes.getOrElse(() => throw Exception()),
      currentPeriod: period,
    );

    _last = loaded;
    emit(loaded);
  }

  /// اختيار period جاهز (week/month/year) — بيلغي فلتر التاريخ المخصص
  Future<void> changeOperationsPeriod(String period) async {
    if (_last == null) return;
    emit(DashboardSectionUpdating(_last!, DashboardUpdatingSection.operations));

    final res = await _repo.getDashboardOperations(period: period);
    res.fold(
      (l) => emit(DashboardError(l.message)),
      (r) {
        _last = _last!.copyWith(
          operations: r,
          currentPeriod: period,
          clearOperationsRange: true,
        );
        emit(_last!);
      },
    );
  }

  /// فلتر تاريخ مخصص لقسم الـ Operations
  Future<void> applyOperationsDateRange({String? from, String? to}) async {
    if (_last == null) return;
    emit(DashboardSectionUpdating(_last!, DashboardUpdatingSection.operations));

    final res = await _repo.getDashboardOperations(from: from, to: to);
    res.fold(
      (l) => emit(DashboardError(l.message)),
      (r) {
        _last = _last!.copyWith(
          operations: r,
          operationsFrom: from,
          operationsTo: to,
        );
        emit(_last!);
      },
    );
  }

  /// فلتر تاريخ مخصص لقسم الـ Revenue
  Future<void> applyRevenueDateRange({String? from, String? to}) async {
    if (_last == null) return;
    emit(DashboardSectionUpdating(_last!, DashboardUpdatingSection.revenue));

    final res = await _repo.getDashboardRevenue(from: from, to: to);
    res.fold(
      (l) => emit(DashboardError(l.message)),
      (r) {
        _last = _last!.copyWith(
          revenue: r,
          revenueFrom: from,
          revenueTo: to,
        );
        emit(_last!);
      },
    );
  }
}