import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/auth/data/models/auth_model.dart';

class AuthRemoteDataSource {
  final ApiService _api;
  const AuthRemoteDataSource(this._api);

  Future<AuthLoginModel> login({
    required String email,
    required String password,
  }) async {
    final res = await _api.post(
      endPoint: ApiEndpoints.adminLogin,
      data: {'email': email, 'password': password},
    );
    return AuthLoginModel.fromJson(res);
  }

  Future<AdminMeModel> getMe() async {
    final res = await _api.get(endPoint: ApiEndpoints.adminMe);
    return AdminMeModel.fromJson(res);
  }

  Future<void> logout() async {
    await _api.post(endPoint: ApiEndpoints.adminLogout, data: {});
  }
}