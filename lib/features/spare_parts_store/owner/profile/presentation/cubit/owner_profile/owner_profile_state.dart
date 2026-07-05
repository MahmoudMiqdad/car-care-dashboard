// حالات ملف متجر المالك.
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';

abstract class OwnerProfileState {}

class OwnerProfileInitial extends OwnerProfileState {}

class OwnerProfileLoading extends OwnerProfileState {}

class OwnerProfileReady extends OwnerProfileState {
  OwnerProfileReady({
    required this.shop,
    required this.selectedTypeIds,
    required this.selectedBrandIds,
    required this.selectedCategoryIds,
    this.unknownValues = const [],
    this.isSaving = false,
    this.saveError,
    this.justSaved = false,
  });

  final ShopEntity? shop;
  final List<int> selectedTypeIds;
  final List<int> selectedBrandIds;
  final List<int> selectedCategoryIds;
  final List<String> unknownValues;
  final bool isSaving;
  final String? saveError;
  final bool justSaved;

  bool get hasUnknownValues => unknownValues.isNotEmpty;
}

class OwnerProfileError extends OwnerProfileState {
  OwnerProfileError(this.message);

  final String message;
}
