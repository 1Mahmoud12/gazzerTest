import 'package:gazzer/features/profile/data/models/delete_account_reason_dto.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';

sealed class ProfileStates {}

class ProfileInitial extends ProfileStates {}

abstract class ProfileLoadingStates extends ProfileStates {}

abstract class ProfileErrorStates extends ProfileStates {
  final String message;
  ProfileErrorStates(this.message);
}

/// update profile
class UpdateProfileLoading extends ProfileLoadingStates {}

class UpdateSuccessWithClient extends ProfileStates {
  final String message;
  UpdateSuccessWithClient(this.message);
}

class UpdateSuccessWithSession extends ProfileStates {
  final String sessionId;
  final UpdateProfileReq req;
  UpdateSuccessWithSession(this.sessionId, this.req);
}

class UpdateProfileError extends ProfileErrorStates {
  UpdateProfileError(super.message);
}

class UpdateProfileRateLimitError extends ProfileErrorStates {
  final int remainingSeconds;

  UpdateProfileRateLimitError(super.message, this.remainingSeconds);
}

/// verify otp
class VerifyOTPLoading extends ProfileLoadingStates {}

class VerifyOTPSuccess extends ProfileStates {
  final String message;
  VerifyOTPSuccess(this.message);
}

class VerifyOTPError extends ProfileErrorStates {
  VerifyOTPError(super.message);
}

/// change password
class ChangePasswordLoading extends ProfileLoadingStates {}

class ChangePasswordSuccess extends ProfileStates {
  final String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordError extends ProfileErrorStates {
  ChangePasswordError(super.message);
}

///
///
///
/// delete account
class RequestDeleteAccountLoading extends ProfileLoadingStates {}

class RequestDeleteAccountSuccess extends ProfileStates {
  final String sessionId;
  RequestDeleteAccountSuccess(this.sessionId);
}

class RequestDeleteAccountError extends ProfileErrorStates {
  final int? remainingSeconds;

  RequestDeleteAccountError(super.message, [this.remainingSeconds]);
}

class RequestDeleteAccountRateLimitError extends ProfileErrorStates {
  final int remainingSeconds;

  RequestDeleteAccountRateLimitError(super.message, this.remainingSeconds);
}

/// fetch reasons
class FetchDeleteAccountReasonsLoading extends ProfileLoadingStates {}

class FetchDeleteAccountReasonsSuccess extends ProfileStates {
  final List<DeleteAccountReasonDTO> reasons;
  FetchDeleteAccountReasonsSuccess(this.reasons);
}

class FetchDeleteAccountReasonsError extends ProfileErrorStates {
  FetchDeleteAccountReasonsError(super.message);
}

/// confirm delete
class DeleteAccountLoading extends ProfileLoadingStates {}

class DeleteAccountSuccess extends ProfileStates {
  final String message;
  DeleteAccountSuccess(this.message);
}

class DeleteAccountError extends ProfileErrorStates {
  DeleteAccountError(super.message);
}

/// logout
class LogoutLoading extends ProfileLoadingStates {}

class LogoutSuccess extends ProfileStates {
  final String message;
  LogoutSuccess(this.message);
}

class LogoutError extends ProfileErrorStates {
  LogoutError(super.message);
}
