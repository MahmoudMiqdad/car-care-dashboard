// إدارة قائمة طلبات متجر المالك.
import 'package:car_care/features/spare_parts_store/owner/orders/domain/repositories/i_owner_orders_repository.dart';
import 'package:car_care/features/spare_parts_store/owner/orders/presentation/cubit/owner_orders/owner_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerOrdersCubit extends Cubit<OwnerOrdersState> {
  OwnerOrdersCubit(this._repository) : super(OwnerOrdersInitial());

  final IOwnerOrdersRepository _repository;

  Future<void> fetchOrders() async {
    emit(OwnerOrdersLoading());
    final result = await _repository.getOrders();
    result.fold(
      (failure) => emit(OwnerOrdersError(failure.message)),
      (orders) => orders.isEmpty
          ? emit(OwnerOrdersEmpty())
          : emit(OwnerOrdersLoaded(orders)),
    );
  }
}
