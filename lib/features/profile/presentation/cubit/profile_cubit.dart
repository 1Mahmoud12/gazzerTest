import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/local_storage/local_storage.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/auth/common/data/client_response.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/profile/data/models/change_password_req.dart';
import 'package:gazzer/features/profile/data/models/delete_account_reason_dto.dart';
import 'package:gazzer/features/profile/data/models/delete_account_req.dart';
import 'package:gazzer/features/profile/data/models/profile_verify_otp_req.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';
import 'package:gazzer/features/profile/domain/profile_repo.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepo _repo;
  ClientEntity? client;

  ProfileCubit(this._repo) : super(ProfileInitial()) {
    client = Session().client?.clone();
  }

  Future<bool> updateProfile(UpdateProfileReq req) async {
    emit(UpdateProfileLoading());
    final res = await _repo.updateClient(req);
    switch (res) {
      case Ok<(ClientResponse?, String?)> ok:
        if (ok.value.$2 != null) {
          emit(UpdateSuccessWithSession(ok.value.$2!, req));
          return true;
        } else {
          client = ok.value.$1?.client.toClientEntity();
          Session().setClient = client;
          emit(
            UpdateSuccessWithClient(
              ok.value.$1?.message ?? L10n.tr().profileUpdatedSuccessfully,
            ),
          );
          return true;
        }
      case Err err:
        // Check if it's an OTP rate limit error
        if (err.error is OtpRateLimitError) {
          final rateLimitError = err.error as OtpRateLimitError;
          final remainingSeconds = rateLimitError.remainingSeconds.ceil();
          emit(
            UpdateProfileRateLimitError(
              rateLimitError.message,
              remainingSeconds,
            ),
          );
          return false;
        } else {
          emit(UpdateProfileError(err.error.message));
          return false;
        }
    }
  }

  Future<void> verifyOtp(ProfileVerifyOtpReq req) async {
    emit(VerifyOTPLoading());
    final res = await _repo.verifyOtp(req);
    switch (res) {
      case Ok<ClientResponse> ok:
        TokenService.setToken(ok.value.accessToken);
        client = ok.value.client.toClientEntity();
        Session().setClient = client;
        emit(
          VerifyOTPSuccess(
            ok.value.message ?? L10n.tr().profileUpdatedSuccessfully,
          ),
        );
        break;
      case Err err:
        emit(VerifyOTPError(err.error.message));
    }
  }

  Future<void> changePassword(ChangePasswordReq req) async {
    emit(ChangePasswordLoading());
    final res = await _repo.changePassword(req);
    switch (res) {
      case Ok<String> ok:
        emit(ChangePasswordSuccess(ok.value));
        break;
      case Err err:
        emit(ChangePasswordError(err.error.message));
    }
  }

  Future<void> requestDeleteAccount() async {
    emit(RequestDeleteAccountLoading());
    final req = await _repo.requestDeleteAccount();
    switch (req) {
      case Ok<String> ok:
        emit(RequestDeleteAccountSuccess(ok.value));
        break;
      case Err err:
        // Check if it's an OTP rate limit error
        if (err.error is OtpRateLimitError) {
          final rateLimitError = err.error as OtpRateLimitError;
          final remainingSeconds = rateLimitError.remainingSeconds.ceil();
          emit(
            RequestDeleteAccountRateLimitError(
              rateLimitError.message,
              remainingSeconds,
            ),
          );
        } else {
          emit(RequestDeleteAccountError(err.error.message));
        }
    }
  }

  Future<void> getDeleteAccountReasons() async {
    emit(FetchDeleteAccountReasonsLoading());
    final req = await _repo.getDeleteAccountReasons();
    switch (req) {
      case Ok<List<DeleteAccountReasonDTO>> ok:
        emit(FetchDeleteAccountReasonsSuccess(ok.value));
        break;
      case Err err:
        emit(FetchDeleteAccountReasonsError(err.error.message));
    }
  }

  Future<void> confirmDeleteAccount(DeleteAccountReq req) async {
    emit(DeleteAccountLoading());
    final res = await _repo.confirmDeleteAccount(req);
    switch (res) {
      case Ok<String> ok:
        Session().setClient = null;
        TokenService.deleteToken();
        emit(DeleteAccountSuccess(ok.value));
        break;
      case Err err:
        emit(DeleteAccountError(err.error.message));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final res = await _repo.logout();
    switch (res) {
      case Ok<String> ok:
        client = null;
        Session().setClient = null;
        TokenService.deleteToken();
        emit(LogoutSuccess(ok.value));
        break;
      case Err err:
        emit(LogoutError(err.error.message));
    }
  }

  @override
  void emit(ProfileStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
