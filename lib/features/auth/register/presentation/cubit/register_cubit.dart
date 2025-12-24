import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterRepo _repo;
  RegisterCubit(this._repo) : super(RegisterInitial());

  Future<void> register(RegisterRequest req) async {
    emit(RegisterLoading());
    final resp = await _repo.register(req);
    switch (resp) {
      case final Ok<AuthResponse> res:
        emit(RegisterSuccess(res.value));
        break;
      case final Err err:
        emit(RegisterError(err.error));
        break;
    }
  }

  @override
  void emit(RegisterStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
