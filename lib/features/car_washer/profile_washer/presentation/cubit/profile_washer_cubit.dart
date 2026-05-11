import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/i_profile_washer_repository.dart';
import 'profile_washer_state.dart';

class ProfileWasherCubit extends Cubit<ProfileWasherState> {
  ProfileWasherCubit(this._repo) : super(ProfileWasherInitial());

  final IProfileWasherRepository _repo;

  Future<void> load() async {
    emit(ProfileWasherLoading());

    final res = await _repo.getMyProfile();

    res.fold((f) {
      final msg = f.message.toLowerCase();
      final isNotFound =
          msg.contains('404') ||
          msg.contains('not found') ||
          msg.contains('غير موجود') ||
          msg.contains('لم تقم بإدخال معلومات مغسلتك بعد');

      emit(isNotFound ? ProfileWasherEmpty() : ProfileWasherError(f.message));
    }, (data) => emit(ProfileWasherLoaded(data)));
  }

  Future<void> saveProfile({
    required String shopName,
    required String phone,
    required String city,
    required String address,
    required String description,
    required List<String> services,
    required Map<String, int> servicePrices,
    required Map<String, String> workingHours,
  }) async {
    emit(ProfileWasherSaving());
    emit(ProfileWasherSaving());

    final res = await _repo.addOrUpdateProfile(
      shopName: shopName,
      phone: phone,
      city: city,
      address: address,
      description: description,
      services: services,
      servicePrices: servicePrices,
      workingHours: workingHours,
    );

    res.fold(
      (f) => emit(ProfileWasherError(f.message)),
      (profile) => emit(ProfileWasherLoaded(profile)),
    );
  }

  Future<void> uploadLogo(String filePath) async {
    final res = await _repo.uploadLogo(filePath);

    res.fold((f) => emit(ProfileWasherError(f.message)), (_) => load());
  }

  Future<void> deleteLogo() async {
    final res = await _repo.deleteLogo();

    res.fold((f) => emit(ProfileWasherError(f.message)), (_) => load());
  }
}
