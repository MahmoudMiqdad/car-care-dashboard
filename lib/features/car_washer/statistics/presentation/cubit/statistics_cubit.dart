import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_statistics_repository.dart';
import 'statistics_state.dart';

class CarWasherStatisticsCubit extends Cubit<StatisticsState> {
  CarWasherStatisticsCubit(this._repo) : super(StatisticsInitial());

  final ICarWasherStatisticsRepository _repo;

  Future<void> load() async {
    emit(StatisticsLoading());

    final result = await _repo.getStatistics();

    result.fold(
      (failure) => emit(StatisticsError(failure.message)),
      (data) => emit(StatisticsLoaded(data)),
    );
  }
}