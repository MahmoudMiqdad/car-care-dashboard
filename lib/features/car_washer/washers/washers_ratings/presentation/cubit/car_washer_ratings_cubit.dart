import 'package:car_care/features/car_washer/washers/washers_ratings/domain/repositories/i_car_washer_ratings_repository.dart';
import 'package:car_care/features/car_washer/washers/washers_ratings/presentation/cubit/car_washer_ratings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarWasherRatingsCubit extends Cubit<CarWasherRatingsState> {
  CarWasherRatingsCubit(this._repo) : super(CarWasherRatingsInitial());
  final ICarWasherRatingsRepository _repo;

  Future<void> fetchRatings(int carWasherId) async {
    emit(CarWasherRatingsLoading());
    final result = await _repo.getRatings(carWasherId);
    result.fold(
      (failure) => emit(CarWasherRatingsError(failure.message)),
      (ratings) => emit(CarWasherRatingsLoaded(ratings)),
    );
  }
}
