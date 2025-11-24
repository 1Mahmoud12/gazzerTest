import 'package:gazzer/features/supportScreen/domain/complaint_repo.dart';

sealed class ComplaintStates {}

final class ComplaintInitialState extends ComplaintStates {}

final class ComplaintLoadingState extends ComplaintStates {}

final class ComplaintSuccessState extends ComplaintStates {
  final ComplaintResponse response;

  ComplaintSuccessState(this.response);
}

final class ComplaintErrorState extends ComplaintStates {
  final String error;

  ComplaintErrorState(this.error);
}
