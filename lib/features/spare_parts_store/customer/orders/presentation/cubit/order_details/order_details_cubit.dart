import 'package:car_care/features/spare_parts_store/customer/orders/domain/repositories/i_customer_orders_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/orders/presentation/cubit/order_details/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this._repository) : super(OrderDetailsInitial());

  final ICustomerOrdersRepository _repository;

  Future<void> fetchOrderDetails(int orderId) async {
    emit(OrderDetailsLoading());

    final result = await _repository.getOrderDetails(orderId);

    result.fold(
      (failure) => emit(OrderDetailsError(failure.message)),
      (order) => emit(OrderDetailsLoaded(order)),
    );
  }
}
