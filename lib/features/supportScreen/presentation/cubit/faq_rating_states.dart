sealed class FaqRatingStates {}

final class FaqRatingInitialState extends FaqRatingStates {}

final class FaqRatingLoadingState extends FaqRatingStates {}

final class FaqRatingSuccessState extends FaqRatingStates {
  final String message;

  FaqRatingSuccessState(this.message);
}

final class FaqRatingErrorState extends FaqRatingStates {
  final String error;

  FaqRatingErrorState(this.error);
}
