import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/fuel_provider/share_location_fuel/data/data_sources/share_location_fuel_remote_data_source.dart';
import 'package:car_care/features/fuel_provider/share_location_fuel/domain/repositories/i_share_location_fuel_repository.dart';
import 'package:dartz/dartz.dart';

class ShareFuelProviderLocationRepositoryImpl
    implements IShareFuelProviderLocationRepository {
  final ShareFuelProviderLocationRemoteDataSource _remote;
  ShareFuelProviderLocationRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, void>> shareLocation({
    required int orderId,
    required double lat,
    required double lng,
  }) async {
    try {
      await _remote.shareLocation(orderId: orderId, lat: lat, lng: lng);
      return const Right(null);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (e) {
      return Left(Failure(message: 'حدث خطأ غير متوقع'));
    }
  }
}