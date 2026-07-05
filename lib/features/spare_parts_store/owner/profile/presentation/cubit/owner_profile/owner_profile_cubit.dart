// إدارة حالات ملف متجر المالك.
import 'package:car_care/features/spare_parts_store/owner/profile/data/static/spare_parts_options.dart';
import 'package:car_care/features/spare_parts_store/owner/profile/domain/repositories/i_owner_profile_repository.dart';
import 'package:car_care/features/spare_parts_store/owner/profile/presentation/cubit/owner_profile/owner_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerProfileCubit extends Cubit<OwnerProfileState> {
  OwnerProfileCubit(this._repository) : super(OwnerProfileInitial());

  final IOwnerProfileRepository _repository;

  Future<void> loadProfile() async {
    emit(OwnerProfileLoading());
    final result = await _repository.getProfile();
    result.fold(
      (failure) {
        final msg = failure.message.toLowerCase();
        final isNotFound =
            msg.contains('404') ||
            msg.contains('not found') ||
            msg.contains('لا يوجد') ||
            msg.contains('غير موجود') ||
            msg.contains('لم');
        emit(
          isNotFound
              ? OwnerProfileReady(
                  shop: null,
                  selectedTypeIds: const [],
                  selectedBrandIds: const [],
                  selectedCategoryIds: const [],
                )
              : OwnerProfileError(failure.message),
        );
      },
      (shop) {
        final typeResult = SparePartsOptions.namesToIdsChecked(
          SparePartsOptions.businessTypes,
          shop.businessTypes,
        );
        final brandResult = SparePartsOptions.namesToIdsChecked(
          SparePartsOptions.carBrands,
          shop.carBrands,
        );
        final categoryResult = SparePartsOptions.namesToIdsChecked(
          SparePartsOptions.partCategories,
          shop.partCategories,
        );
        emit(OwnerProfileReady(
          shop: shop,
          selectedTypeIds: typeResult.ids,
          selectedBrandIds: brandResult.ids,
          selectedCategoryIds: categoryResult.ids,
          unknownValues: [
            ...typeResult.unknown,
            ...brandResult.unknown,
            ...categoryResult.unknown,
          ],
        ));
      },
    );
  }

  Future<void> saveProfile({
    required String name,
    required String phone,
    required String city,
    required List<int> businessTypeIds,
    required List<int> carBrandIds,
    required List<int> partCategoryIds,
  }) async {
    final current = state;
    if (current is! OwnerProfileReady || current.isSaving) return;
    if (current.hasUnknownValues) return;

    emit(OwnerProfileReady(
      shop: current.shop,
      selectedTypeIds: current.selectedTypeIds,
      selectedBrandIds: current.selectedBrandIds,
      selectedCategoryIds: current.selectedCategoryIds,
      isSaving: true,
    ));

    final result = await _repository.saveProfile(
      name: name,
      phone: phone,
      city: city,
      businessTypeIds: businessTypeIds,
      carBrandIds: carBrandIds,
      partCategoryIds: partCategoryIds,
    );

    result.fold(
      (failure) => emit(OwnerProfileReady(
        shop: current.shop,
        selectedTypeIds: current.selectedTypeIds,
        selectedBrandIds: current.selectedBrandIds,
        selectedCategoryIds: current.selectedCategoryIds,
        saveError: failure.message,
      )),
      (updatedShop) => emit(OwnerProfileReady(
        shop: updatedShop,
        selectedTypeIds: SparePartsOptions.namesToIds(
          SparePartsOptions.businessTypes,
          updatedShop.businessTypes,
        ),
        selectedBrandIds: SparePartsOptions.namesToIds(
          SparePartsOptions.carBrands,
          updatedShop.carBrands,
        ),
        selectedCategoryIds: SparePartsOptions.namesToIds(
          SparePartsOptions.partCategories,
          updatedShop.partCategories,
        ),
        justSaved: true,
      )),
    );
  }

  void clearSaveError() {
    final current = state;
    if (current is! OwnerProfileReady) return;
    emit(OwnerProfileReady(
      shop: current.shop,
      selectedTypeIds: current.selectedTypeIds,
      selectedBrandIds: current.selectedBrandIds,
      selectedCategoryIds: current.selectedCategoryIds,
    ));
  }

  void clearJustSaved() {
    final current = state;
    if (current is! OwnerProfileReady) return;
    emit(OwnerProfileReady(
      shop: current.shop,
      selectedTypeIds: current.selectedTypeIds,
      selectedBrandIds: current.selectedBrandIds,
      selectedCategoryIds: current.selectedCategoryIds,
    ));
  }
}
