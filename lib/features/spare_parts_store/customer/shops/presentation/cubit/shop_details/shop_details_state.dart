import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';

abstract class ShopDetailsState {}

class ShopDetailsInitial extends ShopDetailsState {}

class ShopDetailsLoading extends ShopDetailsState {}

class ShopDetailsLoaded extends ShopDetailsState {
  ShopDetailsLoaded(this.shop);

  final ShopEntity shop;
}

class ShopDetailsError extends ShopDetailsState {
  ShopDetailsError(this.message);

  final String message;
}
