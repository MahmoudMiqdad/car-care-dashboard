import 'package:car_care/features/spare_parts_store/customer/cart/domain/repositories/i_cart_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/presentation/cubit/add_to_cart/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit(this._repository) : super(AddToCartInitial());

  final ICartRepository _repository;

  Future<void> addToCart({required int productId, required int quantity}) async {
    emit(AddToCartLoading());

    final result = await _repository.addToCart(
      productId: productId,
      quantity: quantity,
    );

    result.fold(
      (failure) => emit(AddToCartError(failure.message)),
      (item) => emit(AddToCartSuccess(item)),
    );
  }
}
