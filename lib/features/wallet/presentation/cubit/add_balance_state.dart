sealed class AddBalanceState {
  const AddBalanceState();
}

class AddBalanceInitial extends AddBalanceState {
  const AddBalanceInitial();
}

class AddBalanceLoading extends AddBalanceState {
  const AddBalanceLoading();
}

class AddBalanceSuccess extends AddBalanceState {
  const AddBalanceSuccess(this.iframeUrl);

  final String iframeUrl;
}

class AddBalanceError extends AddBalanceState {
  const AddBalanceError(this.message);

  final String message;
}
