import 'package:car_care/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:car_care/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _repo;
  AuthCubit(this._repo) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final logged = await _repo.isLoggedIn();
    if (!logged) {
      emit(AuthUnauthenticated());
      return;
    }
    final cached = await _repo.getCachedAdmin();
    if (cached != null) {
      emit(AuthAuthenticated(cached));
    } else {
      emit(AuthUnauthenticated());
    }
    // بعد ما نعرض الكاش، منجيب البيانات المحدثة من السيرفر
    await getMe();
  }

  Future<void> getMe() async {
    final res = await _repo.getMe();
    res.fold(
      (l) {
        // لو فشل الطلب (مثلاً التوكن منتهي) منسيب اللي كان موجود
        // أو ممكن تعمل emit(AuthError(l.message)) لو بدك
      },
      (r) => emit(AuthAuthenticated(r)),
    );
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final res = await _repo.login(email: email, password: password);
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthAuthenticated(r)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final res = await _repo.logout();
    res.fold(
      (l) => emit(AuthError(l.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}