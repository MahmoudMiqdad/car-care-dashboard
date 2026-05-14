import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/statistics_entity.dart';
import '../../domain/repositories/i_statistics_repository.dart';
import '../data_sources/statistics_remote_data_source.dart';

class CarWasherStatisticsRepositoryImpl implements ICarWasherStatisticsRepository {
  const CarWasherStatisticsRepositoryImpl(this._remote);
  final CarWasherStatisticsRemoteDataSource _remote;

  @override
  Future<Either<Failure, StatisticsEntity>> getStatistics() async {
    try {
      final result = await _remote.getStatistics();
      return Right(result);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب الإحصائيات'));
    }
  }
}