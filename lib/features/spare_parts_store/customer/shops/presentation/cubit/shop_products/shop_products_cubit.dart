import 'package:car_care/features/spare_parts_store/customer/shops/domain/repositories/i_shops_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shop_products/shop_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopProductsCubit extends Cubit<ShopProductsState> {
  ShopProductsCubit(this._repository) : super(ShopProductsInitial());

  final IShopsRepository _repository;

  Future<void> fetchShopProducts(int shopId) async {
    emit(ShopProductsLoading());

    final result = await _repository.getShopProducts(shopId);

    result.fold(
      (failure) => emit(ShopProductsError(failure.message)),
      (products) {
        if (products.isEmpty) {
          emit(ShopProductsEmpty());
        } else {
          emit(ShopProductsLoaded(products));
        }
      },
    );
  }
}
