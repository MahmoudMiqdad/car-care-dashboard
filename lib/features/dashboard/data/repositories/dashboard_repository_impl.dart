import 'package:car_care/features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:car_care/features/dashboard/data/models/dashboard_model.dart';
import 'package:car_care/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:car_care/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class DashboardRepositoryImpl implements IDashboardRepository {
  final DashboardRemoteDataSource _remote;
  DashboardRepositoryImpl(this._remote);

  Future<Either<Failure, T>> _call<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  ProviderTypeStatsEntity _mapProviderType(ProviderTypeStatsModel? m) => ProviderTypeStatsEntity(
        total: m?.total,
        pending: m?.pending,
        approved: m?.approved,
        rejected: m?.rejected,
        suspended: m?.suspended,
      );

  OperationTypeStatsEntity _mapOperationType(OperationTypeStatsModel? m) => OperationTypeStatsEntity(
        total: m?.total,
        pending: m?.pending,
        completed: m?.completed,
      );

  List<BucketEntity> _mapBuckets(List<BucketModel> list) =>
      list.map((e) => BucketEntity(bucket: e.bucket, total: e.total)).toList();

  DashboardRangeEntity? _mapRange(DashboardRangeModel? m) =>
      m == null ? null : DashboardRangeEntity(from: m.from, to: m.to, groupBy: m.groupBy);

  @override
  Future<Either<Failure, DashboardSummaryEntity>> getDashboardSummary() => _call(() async {
        final m = await _remote.getDashboardSummary();
        return DashboardSummaryEntity(
          users: UsersStatsEntity(
            totalUsers: m.users?.totalUsers,
            totalCustomers: m.users?.totalCustomers,
          ),
          providers: ProvidersStatsEntity(
            technicians: _mapProviderType(m.providers?.technicians),
            carWashers: _mapProviderType(m.providers?.carWashers),
            fuelProviders: _mapProviderType(m.providers?.fuelProviders),
            shops: _mapProviderType(m.providers?.shops),
          ),
          operations: OperationsStatsEntity(
            maintenanceRequests: _mapOperationType(m.operations?.maintenanceRequests),
            sosRequests: _mapOperationType(m.operations?.sosRequests),
            fuelOrders: _mapOperationType(m.operations?.fuelOrders),
            carwashBookings: _mapOperationType(m.operations?.carwashBookings),
            sparePartsOrders: _mapOperationType(m.operations?.sparePartsOrders),
            totals: OperationsTotalsEntity(
              completedOperations: m.operations?.totals?.completedOperations,
              pendingOperations: m.operations?.totals?.pendingOperations,
            ),
          ),
        );
      });

  @override
  Future<Either<Failure, DashboardOperationsEntity>> getDashboardOperations({
    String? period,
    String? groupBy,
    String? from,
    String? to,
  }) =>
      _call(() async {
        final m = await _remote.getDashboardOperations(
          period: period,
          groupBy: groupBy,
          from: from,
          to: to,
        );
        return DashboardOperationsEntity(
          range: _mapRange(m.range),
          maintenance: _mapBuckets(m.maintenance),
          sos: _mapBuckets(m.sos),
          fuel: _mapBuckets(m.fuel),
          carWash: _mapBuckets(m.carWash),
          spareParts: _mapBuckets(m.spareParts),
        );
      });

@override
  Future<Either<Failure, DashboardRevenueEntity>> getDashboardRevenue({String? from, String? to}) =>
      _call(() async {
        final m = await _remote.getDashboardRevenue(from: from, to: to);
        return DashboardRevenueEntity(
          range: m.range != null ? RevenueRangeEntity(from: m.range!.from, to: m.range!.to) : null,
          grossRevenue: m.grossRevenue != null
              ? GrossRevenueEntity(
                  maintenance: m.grossRevenue!.maintenance,
                  fuel: m.grossRevenue!.fuel,
                  carWash: m.grossRevenue!.carWash,
                  spareParts: m.grossRevenue!.spareParts,
                  sos: m.grossRevenue!.sos,
                  total: m.grossRevenue!.total,
                )
              : null,
          platformCommission: m.platformCommission,
          netProfit: m.netProfit,
          currency: m.currency,
        );
      });

  @override
  Future<Either<Failure, List<AdvertisementEntity>>> getActiveAdvertisements() => _call(() async {
        final m = await _remote.getActiveAdvertisements();
        return m.data
            .map((e) => AdvertisementEntity(
                  id: e.id,
                  title: e.title,
                  imageUrl: e.imageUrl,
                  placement: e.placement,
                  linkUrl: e.linkUrl,
                  sortOrder: e.sortOrder,
                ))
            .toList();
      });
}