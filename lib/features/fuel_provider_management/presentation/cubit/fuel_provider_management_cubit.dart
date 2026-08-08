
import 'package:car_care/features/fuel_provider_management/domain/entities/fuel_provider_management_entity.dart';
import 'package:car_care/features/fuel_provider_management/domain/repositories/i_fuel_provider_management_repository.dart';

import 'package:car_care/features/fuel_provider_management/presentation/cubit/fuel_provider_management_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FuelProviderCubit extends Cubit<FuelProviderState> {
  final IFuelProviderRepository _repo;
  FuelProviderCubit(this._repo) : super(FuelProviderInitial());

  List<FuelProviderEntity> _currentList = [];
  String _currentFilter = 'all';

  Future<void> loadFuelProviders({String status = 'all'}) async {
    _currentFilter = status;
    emit(FuelProviderLoading());
    final res = await _repo.getFuelProviders(status: status);
    res.fold(
      (l) => emit(FuelProviderError(l.message)),
      (r) {
        _currentList = r;
        emit(FuelProviderListLoaded(_currentList, _currentFilter));
      },
    );
  }

  Future<void> loadFuelProviderDetails(int id) async {
    emit(FuelProviderLoading());
    final res = await _repo.getFuelProvider(id);
    res.fold(
      (l) => emit(FuelProviderError(l.message)),
      (r) => emit(FuelProviderDetailsLoaded(r)),
    );
  }

  Future<void> approveFuelProvider(int id) async {
    emit(FuelProviderListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.approveFuelProvider(id);
    await _handleActionResult(res, successMessage: 'تم قبول مزود الخدمة بنجاح');
  }

  Future<void> rejectFuelProvider(int id, String reason) async {
    emit(FuelProviderListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.rejectFuelProvider(id, reason);
    await _handleActionResult(res, successMessage: 'تم رفض مزود الخدمة');
  }

  Future<void> suspendFuelProvider(int id) async {
    emit(FuelProviderListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.suspendFuelProvider(id);
    await _handleActionResult(res, successMessage: 'تم إيقاف مزود الخدمة');
  }

  Future<void> reactivateFuelProvider(int id) async {
    emit(FuelProviderListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.reactivateFuelProvider(id);
    await _handleActionResult(res, successMessage: 'تمت إعادة تفعيل مزود الخدمة');
  }

  Future<void> _handleActionResult(dynamic res, {required String successMessage}) async {
    res.fold(
      (l) => emit(FuelProviderError(l.message)),
      (FuelProviderEntity updated) {
        _currentList = _currentList.map((p) => p.id == updated.id ? updated : p).toList();
        emit(FuelProviderActionSuccess(updated, successMessage, _currentList, _currentFilter));
      },
    );
  }
}