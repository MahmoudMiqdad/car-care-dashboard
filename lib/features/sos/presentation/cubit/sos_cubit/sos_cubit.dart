import 'package:car_care/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sos_state.dart';
class SosCubit extends Cubit<SosState> {
  final ISosRepository _repo;

  SosCubit(this._repo) : super(SosInitial());

  Future<void> createSos(Map<String, dynamic> data) async {
    emit(SosLoading());

    final result = await _repo.createSos(data);

    result.fold(
      (l) => emit(SosError(l.message)),
      (r) => emit(SosCreated(r)),
    );
  }

  Future<void> getAll() async {
    emit(SosLoading());

    final result = await _repo.getAll();

    result.fold(
      (l) => emit(SosError(l.message)),
      (r) => emit(SosListLoaded(r)),
    );
  }
}