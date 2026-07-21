import 'package:car_care/features/spare_parts_store/customer/checkout/domain/repositories/i_checkout_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/presentation/cubit/create_order/create_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this._repository) : super(CreateOrderInitial());

  final ICheckoutRepository _repository;

  Future<void> createOrder({
    required double latitude,
    required double longitude,
    required String addressNote,
  }) async {
    emit(CreateOrderLoading());

    final result = await _repository.createOrder(
      latitude: latitude,
      longitude: longitude,
      addressNote: addressNote,
    );

    result.fold(
      (failure) => emit(CreateOrderError(failure.message)),
      (order) => emit(CreateOrderSuccess(order)),
    );
  }
}
