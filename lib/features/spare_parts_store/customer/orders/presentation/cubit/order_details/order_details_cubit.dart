import 'package:car_care/features/spare_parts_store/customer/orders/domain/repositories/i_customer_orders_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/orders/presentation/cubit/order_details/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this._repository) : super(OrderDetailsInitial());

  final ICustomerOrdersRepository _repository;
  int? _currentOrderId;

  Future<void> fetchOrderDetails(int orderId) async {
    _currentOrderId = orderId;
    emit(OrderDetailsLoading());

    final result = await _repository.getOrderDetails(orderId);

    result.fold(
      (failure) => emit(OrderDetailsError(failure.message)),
      (order) => emit(OrderDetailsLoaded(order)),
    );
  }

  Future<void> cancelOrder(int orderId, String reason) async {
    final current = state;
    if (current is! OrderDetailsLoaded) return;

    emit(OrderDetailsLoaded(current.order, isCancelling: true));

    final result = await _repository.cancelOrder(orderId, reason);

    result.fold(
      (failure) => emit(
        OrderDetailsLoaded(current.order, cancelError: failure.message),
      ),
      (_) {
        if (_currentOrderId != null) fetchOrderDetails(_currentOrderId!);
      },
    );
  }

  void clearCancelError() {
    final current = state;
    if (current is OrderDetailsLoaded && current.cancelError != null) {
      emit(OrderDetailsLoaded(current.order));
    }
  }
}
