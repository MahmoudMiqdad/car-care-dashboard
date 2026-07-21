import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';

abstract class ShopsListState {}

class ShopsListInitial extends ShopsListState {}

class ShopsListLoading extends ShopsListState {}

class ShopsListLoaded extends ShopsListState {
  ShopsListLoaded(this.shops, {required this.cityQuery});

  final List<ShopEntity> shops;
  final String cityQuery;
}

class ShopsListEmpty extends ShopsListState {}

class ShopsListError extends ShopsListState {
  ShopsListError(this.message);

  final String message;
}
