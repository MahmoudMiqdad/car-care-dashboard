
import 'package:car_care/features/shop_management/domain/entities/shop_management_entity.dart';
import 'package:car_care/features/shop_management/domain/repositories/i_shop_management_repository.dart';
import 'package:car_care/features/shop_management/presentation/cubit/shop_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  final IShopRepository _repo;
  ShopCubit(this._repo) : super(ShopInitial());

  List<ShopEntity> _currentList = [];
  String _currentFilter = 'all';

  Future<void> loadShops({String status = 'all'}) async {
    _currentFilter = status;
    emit(ShopLoading());
    final res = await _repo.getShops(status: status);
    res.fold(
      (l) => emit(ShopError(l.message)),
      (r) {
        _currentList = r;
        emit(ShopListLoaded(_currentList, _currentFilter));
      },
    );
  }

  Future<void> loadShopDetails(int id) async {
    emit(ShopLoading());
    final res = await _repo.getShop(id);
    res.fold(
      (l) => emit(ShopError(l.message)),
      (r) => emit(ShopDetailsLoaded(r)),
    );
  }

  Future<void> approveShop(int id) async {
    emit(ShopListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.approveShop(id);
    await _handleActionResult(res, successMessage: 'تم قبول المتجر بنجاح');
  }

  Future<void> rejectShop(int id, String reason) async {
    emit(ShopListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.rejectShop(id, reason);
    await _handleActionResult(res, successMessage: 'تم رفض المتجر');
  }

  Future<void> suspendShop(int id) async {
    emit(ShopListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.suspendShop(id);
    await _handleActionResult(res, successMessage: 'تم إيقاف المتجر');
  }

  Future<void> reactivateShop(int id) async {
    emit(ShopListActionLoading(_currentList, _currentFilter, id));
    final res = await _repo.reactivateShop(id);
    await _handleActionResult(res, successMessage: 'تمت إعادة تفعيل المتجر');
  }

  Future<void> _handleActionResult(dynamic res, {required String successMessage}) async {
    res.fold(
      (l) => emit(ShopError(l.message)),
      (ShopEntity updated) {
        _currentList = _currentList.map((s) => s.id == updated.id ? updated : s).toList();
        emit(ShopActionSuccess(updated, successMessage, _currentList, _currentFilter));
      },
    );
  }
}