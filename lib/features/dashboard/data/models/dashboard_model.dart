class HealthCheckModel {
  final bool? success;
  final String? status;
  final String? app;
  final String? database;
  final String? instance;
  final String? serverTime;

  HealthCheckModel({
    this.success,
    this.status,
    this.app,
    this.database,
    this.instance,
    this.serverTime,
  });

  factory HealthCheckModel.fromJson(Map<String, dynamic> json) => HealthCheckModel(
        success: json['success'],
        status: json['status'],
        app: json['app'],
        database: json['database'],
        instance: json['instance'],
        serverTime: json['server_time'],
      );
}

class AdvertisementModel {
  final int? id;
  final String? title;
  final String? imageUrl;
  final String? placement;
  final String? linkUrl;
  final int? sortOrder;

  AdvertisementModel({
    this.id,
    this.title,
    this.imageUrl,
    this.placement,
    this.linkUrl,
    this.sortOrder,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
        id: json['id'],
        title: json['title'],
        imageUrl: json['image_url'],
        placement: json['placement'],
        linkUrl: json['link_url'],
        sortOrder: json['sort_order'],
      );
}

class AdvertisementListModel {
  final bool? success;
  final List<AdvertisementModel> data;

  AdvertisementListModel({this.success, required this.data});

  factory AdvertisementListModel.fromJson(Map<String, dynamic> json) => AdvertisementListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => AdvertisementModel.fromJson(e)).toList()
            : [],
      );
}

// ---------------- Dashboard Summary ----------------

class DashboardSummaryModel {
  final bool? success;
  final UsersStatsModel? users;
  final ProvidersStatsModel? providers;
  final OperationsStatsModel? operations;

  DashboardSummaryModel({this.success, this.users, this.providers, this.operations});

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return DashboardSummaryModel(
      success: json['success'],
      users: data['users'] != null ? UsersStatsModel.fromJson(data['users']) : null,
      providers: data['providers'] != null ? ProvidersStatsModel.fromJson(data['providers']) : null,
      operations: data['operations'] != null ? OperationsStatsModel.fromJson(data['operations']) : null,
    );
  }
}

class UsersStatsModel {
  final int? totalUsers;
  final int? totalCustomers;

  UsersStatsModel({this.totalUsers, this.totalCustomers});

  factory UsersStatsModel.fromJson(Map<String, dynamic> json) => UsersStatsModel(
        totalUsers: json['total_users'],
        totalCustomers: json['total_customers'],
      );
}

class ProviderTypeStatsModel {
  final int? total;
  final int? pending;
  final int? approved;
  final int? rejected;
  final int? suspended;

  ProviderTypeStatsModel({this.total, this.pending, this.approved, this.rejected, this.suspended});

  factory ProviderTypeStatsModel.fromJson(Map<String, dynamic> json) => ProviderTypeStatsModel(
        total: json['total'],
        pending: json['pending'],
        approved: json['approved'],
        rejected: json['rejected'],
        suspended: json['suspended'],
      );
}

class ProvidersStatsModel {
  final ProviderTypeStatsModel? technicians;
  final ProviderTypeStatsModel? carWashers;
  final ProviderTypeStatsModel? fuelProviders;
  final ProviderTypeStatsModel? shops;

  ProvidersStatsModel({this.technicians, this.carWashers, this.fuelProviders, this.shops});

  factory ProvidersStatsModel.fromJson(Map<String, dynamic> json) => ProvidersStatsModel(
        technicians: json['technicians'] != null ? ProviderTypeStatsModel.fromJson(json['technicians']) : null,
        carWashers: json['car_washers'] != null ? ProviderTypeStatsModel.fromJson(json['car_washers']) : null,
        fuelProviders: json['fuel_providers'] != null ? ProviderTypeStatsModel.fromJson(json['fuel_providers']) : null,
        shops: json['shops'] != null ? ProviderTypeStatsModel.fromJson(json['shops']) : null,
      );
}

class OperationTypeStatsModel {
  final int? total;
  final int? pending;
  final int? completed;

  OperationTypeStatsModel({this.total, this.pending, this.completed});

  factory OperationTypeStatsModel.fromJson(Map<String, dynamic> json) => OperationTypeStatsModel(
        total: json['total'],
        pending: json['pending'],
        completed: json['completed'],
      );
}

class OperationsTotalsModel {
  final int? completedOperations;
  final int? pendingOperations;

  OperationsTotalsModel({this.completedOperations, this.pendingOperations});

  factory OperationsTotalsModel.fromJson(Map<String, dynamic> json) => OperationsTotalsModel(
        completedOperations: json['completed_operations'],
        pendingOperations: json['pending_operations'],
      );
}

class OperationsStatsModel {
  final OperationTypeStatsModel? maintenanceRequests;
  final OperationTypeStatsModel? sosRequests;
  final OperationTypeStatsModel? fuelOrders;
  final OperationTypeStatsModel? carwashBookings;
  final OperationTypeStatsModel? sparePartsOrders;
  final OperationsTotalsModel? totals;

  OperationsStatsModel({
    this.maintenanceRequests,
    this.sosRequests,
    this.fuelOrders,
    this.carwashBookings,
    this.sparePartsOrders,
    this.totals,
  });

  factory OperationsStatsModel.fromJson(Map<String, dynamic> json) => OperationsStatsModel(
        maintenanceRequests: json['maintenance_requests'] != null
            ? OperationTypeStatsModel.fromJson(json['maintenance_requests'])
            : null,
        sosRequests: json['sos_requests'] != null ? OperationTypeStatsModel.fromJson(json['sos_requests']) : null,
        fuelOrders: json['fuel_orders'] != null ? OperationTypeStatsModel.fromJson(json['fuel_orders']) : null,
        carwashBookings:
            json['carwash_bookings'] != null ? OperationTypeStatsModel.fromJson(json['carwash_bookings']) : null,
        sparePartsOrders: json['spare_parts_orders'] != null
            ? OperationTypeStatsModel.fromJson(json['spare_parts_orders'])
            : null,
        totals: json['totals'] != null ? OperationsTotalsModel.fromJson(json['totals']) : null,
      );
}

// ---------------- Dashboard Operations (time series) ----------------

class BucketModel {
  final String? bucket;
  final int? total;

  BucketModel({this.bucket, this.total});

  factory BucketModel.fromJson(Map<String, dynamic> json) => BucketModel(
        bucket: json['bucket'],
        total: json['total'],
      );
}

class DashboardRangeModel {
  final String? from;
  final String? to;
  final String? groupBy;

  DashboardRangeModel({this.from, this.to, this.groupBy});

  factory DashboardRangeModel.fromJson(Map<String, dynamic> json) => DashboardRangeModel(
        from: json['from'],
        to: json['to'],
        groupBy: json['group_by'],
      );
}

class DashboardOperationsModel {
  final bool? success;
  final DashboardRangeModel? range;
  final List<BucketModel> maintenance;
  final List<BucketModel> sos;
  final List<BucketModel> fuel;
  final List<BucketModel> carWash;
  final List<BucketModel> spareParts;

  DashboardOperationsModel({
    this.success,
    this.range,
    this.maintenance = const [],
    this.sos = const [],
    this.fuel = const [],
    this.carWash = const [],
    this.spareParts = const [],
  });

  factory DashboardOperationsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    List<BucketModel> parse(String key) =>
        data[key] != null ? List.from(data[key]).map((e) => BucketModel.fromJson(e)).toList() : [];

    return DashboardOperationsModel(
      success: json['success'],
      range: data['range'] != null ? DashboardRangeModel.fromJson(data['range']) : null,
      maintenance: parse('maintenance'),
      sos: parse('sos'),
      fuel: parse('fuel'),
      carWash: parse('car_wash'),
      spareParts: parse('spare_parts'),
    );
  }
}
// ---------------- Dashboard Revenue ----------------

class RevenueRangeModel {
  final String? from;
  final String? to;

  RevenueRangeModel({this.from, this.to});

  factory RevenueRangeModel.fromJson(Map<String, dynamic> json) => RevenueRangeModel(
        from: json['from'],
        to: json['to'],
      );
}

class GrossRevenueModel {
  final double? maintenance;
  final double? fuel;
  final double? carWash;
  final double? spareParts;
  final double? sos;
  final double? total;

  GrossRevenueModel({
    this.maintenance,
    this.fuel,
    this.carWash,
    this.spareParts,
    this.sos,
    this.total,
  });

  factory GrossRevenueModel.fromJson(Map<String, dynamic> json) => GrossRevenueModel(
        maintenance: (json['maintenance'] as num?)?.toDouble(),
        fuel: (json['fuel'] as num?)?.toDouble(),
        carWash: (json['car_wash'] as num?)?.toDouble(),
        spareParts: (json['spare_parts'] as num?)?.toDouble(),
        sos: (json['sos'] as num?)?.toDouble(),
        total: (json['total'] as num?)?.toDouble(),
      );
}

class DashboardRevenueModel {
  final bool? success;
  final RevenueRangeModel? range;
  final GrossRevenueModel? grossRevenue;
  final double? platformCommission;
  final double? netProfit;
  final String? currency;

  DashboardRevenueModel({
    this.success,
    this.range,
    this.grossRevenue,
    this.platformCommission,
    this.netProfit,
    this.currency,
  });

  factory DashboardRevenueModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return DashboardRevenueModel(
      success: json['success'],
      range: data['range'] != null ? RevenueRangeModel.fromJson(data['range']) : null,
      grossRevenue: data['gross_revenue'] != null ? GrossRevenueModel.fromJson(data['gross_revenue']) : null,
      platformCommission: (data['platform_commission'] as num?)?.toDouble(),
      netProfit: (data['net_profit'] as num?)?.toDouble(),
      currency: data['notes'] != null ? data['notes']['currency'] : null,
    );
  }
}