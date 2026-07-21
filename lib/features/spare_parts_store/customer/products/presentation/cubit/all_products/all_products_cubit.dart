import 'package:car_care/features/spare_parts_store/customer/products/domain/repositories/i_products_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/products/presentation/cubit/all_products/all_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit(this._repository) : super(AllProductsInitial());

  final IProductsRepository _repository;

  Future<void> fetchAllProducts() async {
    emit(AllProductsLoading());

    final result = await _repository.getAllProducts();

    result.fold(
      (failure) => emit(AllProductsError(failure.message)),
      (products) {
        if (products.isEmpty) {
          emit(AllProductsEmpty());
        } else {
          emit(AllProductsLoaded(products));
        }
      },
    );
  }
}
