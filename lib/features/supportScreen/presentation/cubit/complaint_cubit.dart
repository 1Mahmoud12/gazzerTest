import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/supportScreen/data/requests/complaint_request.dart';
import 'package:gazzer/features/supportScreen/domain/complaint_repo.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/complaint_states.dart';

class ComplaintCubit extends Cubit<ComplaintStates> {
  final ComplaintRepo _repo;

  ComplaintCubit(this._repo) : super(ComplaintInitialState());

  Future<void> submitComplaint(ComplaintRequest request) async {
    emit(ComplaintLoadingState());
    animationDialogLoading();
    final result = await _repo.submitComplaint(request);
    closeDialog();
    switch (result) {
      case Ok<ComplaintResponse> ok:
        emit(ComplaintSuccessState(ok.value));
        break;
      case Err<ComplaintResponse> err:
        emit(ComplaintErrorState(err.error.message));
        Alerts.showToast(err.error.message);
        break;
    }
  }

  @override
  void emit(ComplaintStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
