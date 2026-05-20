
import 'package:car_care/features/technician_sos/domain/repositories/i_technician_sos_repository.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/share_technician_location_cubit/share_technician_location_sos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareTechnicianLocationSosCubit extends Cubit<ShareTechnicianLocationSosState> {
  final ITechnicianSosRepository _repo;

  ShareTechnicianLocationSosCubit(this._repo) : super(TechnicianLocationInitial());

  Future<void> shareLocation({
    required int sosId,
    required double lat,
    required double lng,
  }) async {
    emit(ShareLocationLoading());
    final result = await _repo.shareLocation(
    sosId,
     lat,
      lng,
    );
    result.fold(
      (l) => emit(ShareLocationError(l.message)),
      (_) => emit(ShareLocationSuccess()),
    );
  }
}