
import 'package:car_care/features/shop_management/domain/entities/shop_management_entity.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopListActionLoading extends ShopState {
  final List<ShopEntity> shops;
  final String currentFilter;
  final int actionShopId;
  ShopListActionLoading(this.shops, this.currentFilter, this.actionShopId);
}

class ShopListLoaded extends ShopState {
  final List<ShopEntity> shops;
  final String currentFilter;
  ShopListLoaded(this.shops, this.currentFilter);
}

class ShopDetailsLoaded extends ShopState {
  final ShopEntity shop;
  ShopDetailsLoaded(this.shop);
}

class ShopActionSuccess extends ShopState {
  final ShopEntity shop;
  final String message;
  final List<ShopEntity> shops;
  final String currentFilter;
  ShopActionSuccess(this.shop, this.message, this.shops, this.currentFilter);
}

class ShopError extends ShopState {
  final String message;
  ShopError(this.message);
}