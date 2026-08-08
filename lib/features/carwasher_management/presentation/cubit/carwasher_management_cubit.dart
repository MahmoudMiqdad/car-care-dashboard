
import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';
import 'package:car_care/features/carwasher_management/domain/repositories/i_carwasher_management_repository.dart';

import 'package:car_care/features/carwasher_management/presentation/cubit/carwasher_management_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CarwasherCubit extends Cubit<CarwasherState> {
  final ICarwasherRepository _repo;
  CarwasherCubit(this._repo) : super(CarwasherInitial());

  List<CarwasherEntity> _currentList = [];
  String _currentFilter = 'all';

  Future<void> loadCarwashers({String status = 'all'}) async {
    _currentFilter = status;
    emit(CarwasherLoading());
    final res = await _repo.getCarwashers(status: status);
    res.fold(
      (l) => emit(CarwasherError(l.message)),
      (r) {
        _currentList = r;
        emit(CarwasherListLoaded(_currentList, _currentFilter));
      },
    );
  }

  Future<void> loadCarwasherDetails(int id) async {
    emit(CarwasherLoading());
    final res = await _repo.getCarwasher(id);
    res.fold(
      (l) => emit(CarwasherError(l.message)),
      (r) => emit(CarwasherDetailsLoaded(r)),
    );
  }

  Future<void> approveCarwasher(int id) async {
    emit(CarwasherListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.approveCarwasher(id);
    await _handleActionResult(res, successMessage: 'تم قبول مزود الخدمة بنجاح');
  }

  Future<void> rejectCarwasher(int id, String reason) async {
    emit(CarwasherListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.rejectCarwasher(id, reason);
    await _handleActionResult(res, successMessage: 'تم رفض مزود الخدمة');
  }

  Future<void> suspendCarwasher(int id) async {
    emit(CarwasherListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.suspendCarwasher(id);
    await _handleActionResult(res, successMessage: 'تم إيقاف مزود الخدمة');
  }

  Future<void> reactivateCarwasher(int id) async {
    emit(CarwasherListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.reactivateCarwasher(id);
    await _handleActionResult(res, successMessage: 'تمت إعادة تفعيل مزود الخدمة');
  }

  Future<void> _handleActionResult(dynamic res, {required String successMessage}) async {
    res.fold(
      (l) => emit(CarwasherError(l.message)),
      (CarwasherEntity updated) {
        _currentList = _currentList.map((c) => c.id == updated.id ? updated : c).toList();
        emit(CarwasherActionSuccess(updated, successMessage, _currentList, _currentFilter));
      },
    );
  }
}