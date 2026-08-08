class AdvertisementEntity {
  final int? id;
  final String? title;
  final String? imageUrl;
  final String? placement;
  final String? linkUrl;
  final int? sortOrder;

  const AdvertisementEntity({
    this.id,
    this.title,
    this.imageUrl,
    this.placement,
    this.linkUrl,
    this.sortOrder,
  });
}

class UsersStatsEntity {
  final int? totalUsers;
  final int? totalCustomers;
  const UsersStatsEntity({this.totalUsers, this.totalCustomers});
}

class ProviderTypeStatsEntity {
  final int? total;
  final int? pending;
  final int? approved;
  final int? rejected;
  final int? suspended;
  const ProviderTypeStatsEntity({this.total, this.pending, this.approved, this.rejected, this.suspended});
}

class ProvidersStatsEntity {
  final ProviderTypeStatsEntity? technicians;
  final ProviderTypeStatsEntity? carWashers;
  final ProviderTypeStatsEntity? fuelProviders;
  final ProviderTypeStatsEntity? shops;
  const ProvidersStatsEntity({this.technicians, this.carWashers, this.fuelProviders, this.shops});
}

class OperationTypeStatsEntity {
  final int? total;
  final int? pending;
  final int? completed;
  const OperationTypeStatsEntity({this.total, this.pending, this.completed});
}

class OperationsTotalsEntity {
  final int? completedOperations;
  final int? pendingOperations;
  const OperationsTotalsEntity({this.completedOperations, this.pendingOperations});
}

class OperationsStatsEntity {
  final OperationTypeStatsEntity? maintenanceRequests;
  final OperationTypeStatsEntity? sosRequests;
  final OperationTypeStatsEntity? fuelOrders;
  final OperationTypeStatsEntity? carwashBookings;
  final OperationTypeStatsEntity? sparePartsOrders;
  final OperationsTotalsEntity? totals;

  const OperationsStatsEntity({
    this.maintenanceRequests,
    this.sosRequests,
    this.fuelOrders,
    this.carwashBookings,
    this.sparePartsOrders,
    this.totals,
  });
}

class DashboardSummaryEntity {
  final UsersStatsEntity? users;
  final ProvidersStatsEntity? providers;
  final OperationsStatsEntity? operations;
  const DashboardSummaryEntity({this.users, this.providers, this.operations});
}

class BucketEntity {
  final String? bucket;
  final int? total;
  const BucketEntity({this.bucket, this.total});
}

class DashboardRangeEntity {
  final String? from;
  final String? to;
  final String? groupBy;
  const DashboardRangeEntity({this.from, this.to, this.groupBy});
}

class DashboardOperationsEntity {
  final DashboardRangeEntity? range;
  final List<BucketEntity> maintenance;
  final List<BucketEntity> sos;
  final List<BucketEntity> fuel;
  final List<BucketEntity> carWash;
  final List<BucketEntity> spareParts;

  const DashboardOperationsEntity({
    this.range,
    this.maintenance = const [],
    this.sos = const [],
    this.fuel = const [],
    this.carWash = const [],
    this.spareParts = const [],
  });
}
class RevenueRangeEntity {
  final String? from;
  final String? to;
  const RevenueRangeEntity({this.from, this.to});
}

class GrossRevenueEntity {
  final double? maintenance;
  final double? fuel;
  final double? carWash;
  final double? spareParts;
  final double? sos;
  final double? total;

  const GrossRevenueEntity({
    this.maintenance,
    this.fuel,
    this.carWash,
    this.spareParts,
    this.sos,
    this.total,
  });
}

class DashboardRevenueEntity {
  final RevenueRangeEntity? range;
  final GrossRevenueEntity? grossRevenue;
  final double? platformCommission;
  final double? netProfit;
  final String? currency;

  const DashboardRevenueEntity({
    this.range,
    this.grossRevenue,
    this.platformCommission,
    this.netProfit,
    this.currency,
  });
}