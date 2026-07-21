import 'package:car_care/features/spare_parts_store/customer/shops/domain/repositories/i_shops_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shop_details/shop_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopDetailsCubit extends Cubit<ShopDetailsState> {
  ShopDetailsCubit(this._repository) : super(ShopDetailsInitial());

  final IShopsRepository _repository;

  Future<void> fetchShopDetails(int shopId) async {
    emit(ShopDetailsLoading());

    final result = await _repository.getShopDetails(shopId);

    result.fold(
      (failure) => emit(ShopDetailsError(failure.message)),
      (shop) => emit(ShopDetailsLoaded(shop)),
    );
  }
}
