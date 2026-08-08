import 'package:car_care/features/technician_management/domain/entities/technician_entity.dart';
import 'package:car_care/features/technician_management/domain/repositories/i_technician_repository.dart';
import 'package:car_care/features/technician_management/presentation/cubit/technician_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianCubit extends Cubit<TechnicianState> {
  final ITechnicianRepository _repo;
  TechnicianCubit(this._repo) : super(TechnicianInitial());

  List<TechnicianEntity> _currentList = [];
  String _currentFilter = 'all';

  Future<void> loadTechnicians({String status = 'all'}) async {
    _currentFilter = status;
    emit(TechnicianLoading());
    final res = await _repo.getTechnicians(status: status);
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (r) {
        _currentList = r;
        emit(TechnicianListLoaded(_currentList, _currentFilter));
      },
    );
  }

  Future<void> loadTechnicianDetails(int id) async {
    emit(TechnicianLoading());
    final res = await _repo.getTechnician(id);
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (r) => emit(TechnicianDetailsLoaded(r)),
    );
  }

  Future<void> approveTechnician(int id) async {
    emit(TechnicianListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.approveTechnician(id);
    await _handleActionResult(res, successMessage: 'تم قبول الفني بنجاح');
  }

  Future<void> rejectTechnician(int id, String reason) async {
    emit(TechnicianListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.rejectTechnician(id, reason);
    await _handleActionResult(res, successMessage: 'تم رفض الفني');
  }

  Future<void> suspendTechnician(int id) async {
    emit(TechnicianListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.suspendTechnician(id);
    await _handleActionResult(res, successMessage: 'تم إيقاف الفني');
  }

  Future<void> reactivateTechnician(int id) async {
    emit(TechnicianListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.reactivateTechnician(id);
    await _handleActionResult(res, successMessage: 'تمت إعادة تفعيل الفني');
  }

  Future<void> _handleActionResult(
    dynamic res, {
    required String successMessage,
  }) async {
    res.fold(
      (l) => emit(TechnicianError(l.message)),
      (TechnicianEntity updated) {
        _currentList = _currentList
            .map((t) => t.id == updated.id ? updated : t)
            .toList();
        emit(TechnicianActionSuccess(
          updated,
          successMessage,
          _currentList,
          _currentFilter,
        ));
      },
    );
  }
}
