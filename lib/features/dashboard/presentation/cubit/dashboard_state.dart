import 'package:car_care/features/dashboard/domain/entities/dashboard_entity.dart';

enum DashboardUpdatingSection { operations, revenue }

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardSummaryEntity summary;
  final DashboardOperationsEntity operations;
  final DashboardRevenueEntity revenue;
  final List<AdvertisementEntity> advertisements;
  final String currentPeriod;
  final String? operationsFrom;
  final String? operationsTo;
  final String? revenueFrom;
  final String? revenueTo;

  DashboardLoaded({
    required this.summary,
    required this.operations,
    required this.revenue,
    required this.advertisements,
    required this.currentPeriod,
    this.operationsFrom,
    this.operationsTo,
    this.revenueFrom,
    this.revenueTo,
  });

  DashboardLoaded copyWith({
    DashboardSummaryEntity? summary,
    DashboardOperationsEntity? operations,
    DashboardRevenueEntity? revenue,
    List<AdvertisementEntity>? advertisements,
    String? currentPeriod,
    bool clearOperationsRange = false,
    String? operationsFrom,
    String? operationsTo,
    bool clearRevenueRange = false,
    String? revenueFrom,
    String? revenueTo,
  }) {
    return DashboardLoaded(
      summary: summary ?? this.summary,
      operations: operations ?? this.operations,
      revenue: revenue ?? this.revenue,
      advertisements: advertisements ?? this.advertisements,
      currentPeriod: currentPeriod ?? this.currentPeriod,
      operationsFrom: clearOperationsRange ? null : (operationsFrom ?? this.operationsFrom),
      operationsTo: clearOperationsRange ? null : (operationsTo ?? this.operationsTo),
      revenueFrom: clearRevenueRange ? null : (revenueFrom ?? this.revenueFrom),
      revenueTo: clearRevenueRange ? null : (revenueTo ?? this.revenueTo),
    );
  }
}

/// يبين وقت تحديث قسم معيّن (operations/revenue) بس البيانات القديمة تبقى ظاهرة بالخلفية
class DashboardSectionUpdating extends DashboardState {
  final DashboardLoaded previous;
  final DashboardUpdatingSection section;
  DashboardSectionUpdating(this.previous, this.section);
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}