import 'package:car_care/features/technician_sos/domain/repositories/i_technician_sos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'technician_sos_state.dart';

class TechnicianSosCubit extends Cubit<TechnicianSosState> {
  final ITechnicianSosRepository _repo;

  TechnicianSosCubit(this._repo) : super(TechnicianInitial());

  Future<void> getAvailableRequests() async {
    emit(TechnicianLoading());
    final res = await _repo.getAvailableRequests();
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (r) => emit(TechnicianAvailableLoaded(r)),
    );
  }

  Future<void> getRequest(int id) async {
    emit(TechnicianLoading());
    final res = await _repo.getRequest(id);
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (r) => emit(TechnicianRequestLoaded(r)),
    );
  }

  Future<void> acceptRequest(int id) async {
    emit(TechnicianLoading());
    final res = await _repo.acceptRequest(id);
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (r) => emit(TechnicianAccepted(r)),
    );
  }

  Future<void> myRequests() async {
    emit(TechnicianLoading());
    final res = await _repo.myRequests();
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (r) => emit(TechnicianAvailableLoaded(r)),
    );
  }

  Future<void> changeStatus(int sosId, String newStatus) async {
    emit(TechnicianLoading());

    // خطوة 1: ابعت التحديث
    final updateRes = await _repo.updateStatus(sosId, newStatus);

    updateRes.fold(
      (l) => emit(TechnicianError(l.message)),
      (_) async {
        // خطوة 2: جيب الطلب المحدث
        final requestRes = await _repo.getRequest(sosId);
        requestRes.fold(
          (l) => emit(TechnicianError(l.message)),
          (r) => emit(TechnicianRequestLoaded(r)),
        );
      },
    );
  }
}