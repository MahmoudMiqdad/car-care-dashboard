import 'dart:async';

import 'package:car_care/features/spare_parts_store/customer/shops/domain/repositories/i_shops_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shops_list/shops_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsListCubit extends Cubit<ShopsListState> {
  ShopsListCubit(this._repository) : super(ShopsListInitial());

  final IShopsRepository _repository;

  Timer? _debounce;
  String _cityQuery = '';

  String get cityQuery => _cityQuery;

  Future<void> fetchShops({String? city}) async {
    final query = (city ?? _cityQuery).trim();
    _cityQuery = query;

    emit(ShopsListLoading());

    final result = await _repository.getShops(
      city: query.isEmpty ? null : query,
    );

    result.fold(
      (failure) => emit(ShopsListError(failure.message)),
      (shops) {
        if (shops.isEmpty) {
          emit(ShopsListEmpty());
        } else {
          emit(ShopsListLoaded(shops, cityQuery: _cityQuery));
        }
      },
    );
  }

  void onCityChanged(String value) {
    _cityQuery = value;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchShops(city: _cityQuery);
    });
  }

  void clearCity() {
    _cityQuery = '';
    fetchShops(city: null);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
