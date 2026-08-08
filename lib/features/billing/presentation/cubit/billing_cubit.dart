import 'package:car_care/features/billing/domain/entities/billing_entity.dart';
import 'package:car_care/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:car_care/features/billing/presentation/constsnts/billing_setting_params.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class BillingSettingCubit extends Cubit<BillingSettingState> {
  final IBillingSettingRepository _repo;
  BillingSettingCubit(this._repo) : super(BillingSettingInitial());

  List<BillingSettingEntity> _currentList = [];
  String _isActiveFilter = 'all';
  String? _providerTypeFilter;
  int? _providerIdFilter;
  String? _billingTypeFilter;

  Future<void> loadBillingSettings({
    String isActiveFilter = 'all',
    String? providerType,
    int? providerId,
    String? billingType,
  }) async {
    _isActiveFilter = isActiveFilter;
    _providerTypeFilter = providerType;
    _providerIdFilter = providerId;
    _billingTypeFilter = billingType;
    emit(BillingSettingLoading());
    final res = await _repo.getBillingSettings(
      providerType: providerType,
      providerId: providerId,
      billingType: billingType,
      isActive: isActiveFilter == 'all' ? null : isActiveFilter == 'active',
    );
    res.fold(
      (l) => emit(BillingSettingError(l.message)),
      (r) {
        _currentList = r;
        emit(BillingSettingListLoaded(
          _currentList,
          _isActiveFilter,
          providerTypeFilter: _providerTypeFilter,
          billingTypeFilter: _billingTypeFilter,
        ));
      },
    );
  }

  Future<void> loadBillingSettingDetails(int id) async {
    emit(BillingSettingLoading());
    final res = await _repo.getBillingSetting(id);
    res.fold(
      (l) => emit(BillingSettingError(l.message)),
      (r) => emit(BillingSettingDetailsLoaded(r)),
    );
  }

  Future<void> createBillingSetting(BillingSettingParams params) async {
    emit(BillingSettingFormSubmitting());
    final res = await _repo.createBillingSetting(params);
    res.fold(
      (l) => emit(BillingSettingError(l.message)),
      (r) => emit(BillingSettingFormSuccess(r, 'تم إنشاء إعداد الفوترة بنجاح')),
    );
  }

  Future<void> updateBillingSetting(int id, BillingSettingParams params) async {
    emit(BillingSettingFormSubmitting());
    final res = await _repo.updateBillingSetting(id, params);
    res.fold(
      (l) => emit(BillingSettingError(l.message)),
      (r) => emit(BillingSettingFormSuccess(r, 'تم تحديث إعداد الفوترة بنجاح')),
    );
  }

  Future<void> deleteBillingSetting(int id) async {
    emit(BillingSettingListActionLoading(_currentList, _isActiveFilter, id));
    final res = await _repo.deleteBillingSetting(id);
    res.fold(
      (l) => emit(BillingSettingError(l.message)),
      (message) {
        _currentList = _currentList.where((s) => s.id != id).toList();
        emit(BillingSettingActionSuccess(
          message.isEmpty ? 'تم حذف إعداد الفوترة بنجاح' : message,
          _currentList,
          _isActiveFilter,
        ));
      },
    );
  }
}