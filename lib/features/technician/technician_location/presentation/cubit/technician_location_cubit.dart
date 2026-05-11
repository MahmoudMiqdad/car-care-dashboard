import 'package:car_care/features/technician/technician_location/domain/repositories/i_technician_location_repository.dart';
import 'package:car_care/features/technician/technician_location/presentation/cubit/technician_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianLocationCubit extends Cubit<TechnicianLocationState> {
  final ITechnicianLocationRepository _repo;

  TechnicianLocationCubit(this._repo) : super(TechnicianLocationInitial());

  // ─── من صفحة البروفايل ────────────────────────────────────────────────────
  // API: POST /api/technician/location
  Future<void> updateLocation({
    required double lat,
    required double lng,
  }) async {
    emit(UpdateLocationLoading());
    final result = await _repo.updateLocation(lat: lat, lng: lng);
    result.fold(
      (l) => emit(UpdateLocationError(l.message)),
      (_) => emit(UpdateLocationSuccess()),
    );
  }

  // ─── من شاشة SOS النشطة ───────────────────────────────────────────────────
  // API: POST /api/sos/{sosId}/location
  Future<void> shareLocation({
    required int sosId,
    required double lat,
    required double lng,
  }) async {
    emit(ShareLocationLoading());
    final result = await _repo.shareLocation(
      sosId: sosId,
      lat: lat,
      lng: lng,
    );
    result.fold(
      (l) => emit(ShareLocationError(l.message)),
      (_) => emit(ShareLocationSuccess()),
    );
  }
}