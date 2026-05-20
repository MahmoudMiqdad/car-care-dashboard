
import 'package:car_care/features/technician/technician_profile/domain/repositories/i_technician_profile_repository.dart';
import 'package:car_care/features/technician/technician_profile/presentation/cubit/cubit/technician_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianLocationCubit extends Cubit<TechnicianLocationState> {
  final ITechnicianProfileRepository _repo;

  TechnicianLocationCubit(this._repo) : super(TechnicianLocationInitial());


  Future<void> technicianLocation({
    required double lat,
    required double lng,
  }) async {
    emit(UpdateLocationLoading());
    final result = await _repo.technicianLocation( lat,  lng);
    result.fold(
      (l) => emit(UpdateLocationError(l.message)),
      (_) => emit(UpdateLocationSuccess()),
    );
  }


}