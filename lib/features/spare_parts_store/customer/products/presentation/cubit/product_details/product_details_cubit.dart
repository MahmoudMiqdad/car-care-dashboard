import 'package:car_care/features/spare_parts_store/customer/products/presentation/cubit/product_details/product_details_state.dart';
import 'package:car_care/features/spare_parts_store/customer/products/domain/repositories/i_products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._repository) : super(ProductDetailsInitial());

  final IProductsRepository _repository;

  Future<void> fetchProductDetails(int id) async {
    emit(ProductDetailsLoading());

    final result = await _repository.getProductDetails(id);

    result.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsLoaded(product)),
    );
  }
}
