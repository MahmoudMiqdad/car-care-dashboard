import 'package:bloc/bloc.dart';
import 'package:car_care/core/service/pusher_service.dart';


import 'package:car_care/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:car_care/features/sos/presentation/cubit/tracking_cubit/tracking_state.dart';
import 'package:latlong2/latlong.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final ISosRepository _repo;
  final PusherService _pusher;
  int? _currentSosId;

  TrackingCubit(this._repo, this._pusher) : super(TrackingInitial());

  /// تحميل بيانات الـ SOS + الاشتراك بـ real-time
  Future<void> loadTracking(int sosId) async {
    _currentSosId = sosId;
    emit(TrackingLoading());

    // 1. جيب البيانات الأولية من الـ API
    final res = await _repo.trackSos(sosId);

    res.fold(
      (failure) => emit(TrackingError(failure.message)),
      (data) async {
        emit(TrackingLoaded(data));

        // 2. اشترك على Pusher لتلقي التحديثات اللحظية
        await _pusher.subscribeToSosTracking(
          sosId: sosId,
          onLocationUpdate: (lat, lng) {
            final current = state;
            if (current is TrackingLoaded) {
              emit(current.copyWith(liveLocation: LatLng(lat, lng)));
            }
          },
        );
      },
    );
  }

  @override
  Future<void> close() async {
    if (_currentSosId != null) {
      await _pusher.unsubscribeFromSos(_currentSosId!);
    }
    return super.close();
  }
}
