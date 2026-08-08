// advertisement_cubit.dart
import 'dart:typed_data';
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';
import 'package:car_care/features/advertisement/domain/repositories/i_advertisement_repository.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  final IAdvertisementRepository _repo;
  AdvertisementCubit(this._repo) : super(AdvertisementInitial());

  List<AdvertisementEntity> _currentList = [];

  Future<void> loadAdvertisements({bool? isActive, String? placement}) async {
    emit(AdvertisementLoading());
    final res = await _repo.getAdvertisements(isActive: isActive, placement: placement);
    res.fold(
      (l) => emit(AdvertisementError(l.message)),
      (r) {
        _currentList = r;
        emit(AdvertisementListLoaded(_currentList));
      },
    );
  }

  Future<void> loadAdvertisementDetails(int id) async {
    emit(AdvertisementLoading());
    final res = await _repo.getAdvertisement(id);
    res.fold(
      (l) => emit(AdvertisementError(l.message)),
      (r) => emit(AdvertisementDetailsLoaded(r)),
    );
  }

  Future<void> createAdvertisement({
    required String title,
    required String placement,
    String? linkUrl,
    String? startsAt,
    String? endsAt,
    int? sortOrder,
    required Uint8List imageBytes,
    required String imageFileName,
  }) async {
    emit(AdvertisementSubmitting());
    final res = await _repo.createAdvertisement(
      title: title,
      placement: placement,
      linkUrl: linkUrl,
      startsAt: startsAt,
      endsAt: endsAt,
      sortOrder: sortOrder,
      imageBytes: imageBytes,
      imageFileName: imageFileName,
    );
    res.fold(
      (l) => emit(AdvertisementError(l.message)),
      (r) {
        _currentList = [r, ..._currentList];
        emit(AdvertisementActionSuccess(r, 'تم إنشاء الإعلان بنجاح', _currentList));
      },
    );
  }

  Future<void> updateAdvertisement({
    required int id,
    String? title,
    String? placement,
    bool? isActive,
    int? sortOrder,
    Uint8List? imageBytes,
    String? imageFileName,
  }) async {
    emit(AdvertisementSubmitting());
    final res = await _repo.updateAdvertisement(
      id: id,
      title: title,
      placement: placement,
      isActive: isActive,
      sortOrder: sortOrder,
      imageBytes: imageBytes,
      imageFileName: imageFileName,
    );
    await _handleActionResult(res, successMessage: 'تم تحديث الإعلان بنجاح');
  }

  Future<void> activateAdvertisement(int id) async {
    emit(AdvertisementListActionLoading(_currentList, id));
    final res = await _repo.activateAdvertisement(id);
    await _handleActionResult(res, successMessage: 'تم تفعيل الإعلان');
  }

  Future<void> deactivateAdvertisement(int id) async {
    emit(AdvertisementListActionLoading(_currentList, id));
    final res = await _repo.deactivateAdvertisement(id);
    await _handleActionResult(res, successMessage: 'تم إلغاء تفعيل الإعلان');
  }

  Future<void> deleteAdvertisement(int id) async {
    emit(AdvertisementListActionLoading(_currentList, id));
    final res = await _repo.deleteAdvertisement(id);
    res.fold(
      (l) => emit(AdvertisementError(l.message)),
      (_) {
        _currentList = _currentList.where((a) => a.id != id).toList();
        emit(AdvertisementDeleted(id, _currentList));
      },
    );
  }

  Future<void> _handleActionResult(dynamic res, {required String successMessage}) async {
    res.fold(
      (l) => emit(AdvertisementError(l.message)),
      (AdvertisementEntity updated) {
        _currentList = _currentList.map((a) => a.id == updated.id ? updated : a).toList();
        emit(AdvertisementActionSuccess(updated, successMessage, _currentList));
      },
    );
  }
}