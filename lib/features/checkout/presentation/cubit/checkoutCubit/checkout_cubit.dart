import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/pkgs/paymob/paymob_view.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_params.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_response_dto.dart';
import 'package:gazzer/features/checkout/domain/checkout_repo.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
import 'package:go_router/go_router.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit(
    this._checkoutRepo,
  ) : super(CheckoutInitial()) {
    emit(
      PaymentMethodLoaded(
        selectedPaymentMethod: _selectedPaymentMethod,
        walletBalance: _walletBalance,
        availablePoints: _availablePoints,
      ),
    );
    loadCheckoutData();
  }

  static CheckoutCubit of(BuildContext context) => BlocProvider.of<CheckoutCubit>(context);
  final CheckoutRepo _checkoutRepo;

  // Payment method state
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  double _walletBalance = 0.0;
  int _availablePoints = 0;
  String? _voucherCode;
  PaymentMethod? _remainingPaymentMethod; // used when wallet isn't enough
  String? _walletPhoneNumber; // mobile wallet msisdn
  String? _walletProviderName; // vodafone_cash | etisalat_cash | orange_cash

  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;
  double get walletBalance => _walletBalance;
  int get availablePoints => _availablePoints;

  String? get voucherCode => _voucherCode;
  String? timeSlots;

  PaymentMethod? get remainingPaymentMethod => _remainingPaymentMethod;

  String? get walletPhoneNumber => _walletPhoneNumber;

  String? get walletProviderName => _walletProviderName;

  void setTimeSlots(String? value) {
    timeSlots = value;
    emit(CardChange(timestamp: DateTime.now().microsecondsSinceEpoch));
  }

  // Card management
  final List<CardEntity> _cards = [];
  bool _isCreatingCard = false;

  List<CardEntity> get cards => _cards;
  bool get isCreatingCard => _isCreatingCard;

  @override
  void emit(CheckoutStates state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> convertPoints(int points) async {
    final res = await _checkoutRepo.convertPoints(points);
    switch (res) {
      case Ok<String>(:final value):
        Alerts.showToast(value, error: false);
        await loadCheckoutData();
      case Err(:final error):
        Alerts.showToast(error.message);
    }
  }

  /// Loads checkout data (wallet, loyalty points, payment cards)
  Future<void> loadCheckoutData() async {
    emit(CheckoutDataLoading());

    final result = await _checkoutRepo.getCheckoutData();

    switch (result) {
      case Ok<CheckoutDataDTO>(:final value):
        _walletBalance = value.wallet.balance;
        _availablePoints = value.loyaltyPoints.availablePoints;
        _cards.clear();
        _cards.addAll(value.paymentCards.map((card) => card.toEntity()));

        emit(
          CheckoutDataLoaded(
            walletBalance: _walletBalance,
            availablePoints: _availablePoints,
            paymentCards: _cards,
          ),
        );
        emit(
          PaymentMethodLoaded(
            selectedPaymentMethod: _selectedPaymentMethod,
            walletBalance: _walletBalance,
            availablePoints: _availablePoints,
          ),
        );
      case Err(:final error):
        Alerts.showToast(error.message);
        emit(
          PaymentMethodLoaded(
            selectedPaymentMethod: _selectedPaymentMethod,
            walletBalance: _walletBalance,
            availablePoints: _availablePoints,
          ),
        );
    }
  }

  /// Selects a payment method
  void selectPaymentMethod(
    PaymentMethod method, {
    bool removeRemainingMethod = true,
  }) {
    _selectedPaymentMethod = method;
    if (removeRemainingMethod) {
      _remainingPaymentMethod = null;

      _walletProviderName = '';
      _walletPhoneNumber = '';
    }
    emit(CardChange(timestamp: DateTime.now().microsecondsSinceEpoch));
    emit(
      PaymentMethodLoaded(
        selectedPaymentMethod: _selectedPaymentMethod,
        walletBalance: _walletBalance,
        availablePoints: _availablePoints,
      ),
    );
  }

  void applyVoucher(String? code) {
    _voucherCode = (code == null || code.trim().isEmpty) ? null : code.trim();
    emit(CardChange(timestamp: DateTime.now().microsecondsSinceEpoch));
  }

  /// Set remaining payment method (selected from bottom sheet: credit card or wallet)
  void setRemainingPaymentMethod(PaymentMethod? method) {
    _remainingPaymentMethod = method;
    emit(CardChange(timestamp: DateTime.now().microsecondsSinceEpoch));
  }

  /// Set the selected mobile wallet provider and phone
  void setWalletInfo({
    required String providerName,
    required String phoneNumber,
  }) {
    _walletProviderName = providerName;
    _walletPhoneNumber = phoneNumber;
    emit(CardChange(timestamp: DateTime.now().microsecondsSinceEpoch));
    emit(
      PaymentMethodLoaded(
        selectedPaymentMethod: _selectedPaymentMethod,
        walletBalance: _walletBalance,
        availablePoints: _availablePoints,
      ),
    );
  }

  /// If wallet is selected but balance < total, emit state to prompt user
  void checkWalletAndPromptIfInsufficient({required double orderTotal}) {
    final isWalletSelected = _selectedPaymentMethod == PaymentMethod.gazzerWallet;
    if (isWalletSelected && _walletBalance < orderTotal) {
      final shortfall = (orderTotal - _walletBalance).clamp(0, double.infinity);
      emit(InsufficientWalletBalance(shortfall: shortfall.toDouble()));
    }
  }

  /// Places the order
  /// If wallet is selected and a secondaryMethod is provided, both will be sent
  /// Maximum 2 payment methods can be sent
  Future<void> placeOrder(
    BuildContext context, {
    double? orderTotal,
    String? notes,
  }) async {
    final methods = <String>[];
    String? getWalletProviderName() {
      return _walletProviderName; // Already set via setWalletInfo()
    }

    String? mapMethodToBackend(PaymentMethod m) {
      switch (m) {
        case PaymentMethod.cashOnDelivery:
          return 'cash_on_delivery';
        case PaymentMethod.creditDebitCard:
          return 'pay_by_card';
        case PaymentMethod.wallet:
          final providerName = getWalletProviderName();
          if (providerName != null && providerName.isNotEmpty) {
            return providerName; // Returns vodafone_cash, etisalat_cash, or orange_cash
          }
          return null; // Don't send if no provider selected
        case PaymentMethod.gazzerWallet:
          return 'pay_by_gazzer_wallet';
      }
    }

    // Add primary payment method
    final primaryMethod = mapMethodToBackend(_selectedPaymentMethod);
    if (primaryMethod != null) {
      methods.add(primaryMethod);
    }

    // Add secondary payment method if needed (max 2 methods total)
    if (methods.length < 2) {
      final effectiveSecondary = _remainingPaymentMethod;
      if (effectiveSecondary != null) {
        final secondaryMethodValue = mapMethodToBackend(effectiveSecondary);
        if (secondaryMethodValue != null && methods.length < 2) {
          methods.add(secondaryMethodValue);
        }
      }
    }

    final params = CheckoutParams(
      paymentMethod: methods,
      voucher: _voucherCode,
      timeSlot: timeSlots,
      phoneNumber: _walletPhoneNumber,
      notes: notes,
    );

    // logger.d(params.toJson());
    animationDialogLoading(context);
    final res = await _checkoutRepo.submitCheckout(params: params);
    closeDialog(context);
    switch (res) {
      case Ok<CheckoutResponseDTO>(:final value):
        // If iframe URL is provided, navigate to payment screen

        if (value.iframeUrl != null && value.iframeUrl!.isNotEmpty) {
          if (context.mounted) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(paymentUrl: value.iframeUrl!),
              ),
            );
            if (result == 'success') {
              // if (context.mounted) {
              Alerts.showToast(
                L10n.tr().payment_completed_successfully,
                error: false,
              );
              // TODO: Navigate to success screen or handle success
              context.read<CartCubit>().loadCart();

              context.go('/orders');
            } else if (result == 'failed') {
              if (context.mounted) {
                Alerts.showToast(
                  L10n.tr().payment_failed,
                );
              }
            }
          }
        } else {
          // Payment method doesn't require iframe (e.g., cash on delivery)
          if (context.mounted) {
            Alerts.showToast(L10n.tr().order_placed_successfully, error: false);
            // TODO: Navigate to success screen
            context.read<CartCubit>().loadCart();
            context.go('/orders');
          }
        }
      case Err(:final error):
        if (context.mounted) {
          Alerts.showToast(error.message);
        }
    }
  }

  /// Loads cards
  void loadCards() {
    emit(CardsLoaded(cards: _cards, isCreating: _isCreatingCard));
  }

  /// Creates a new card via API
  // Future<void> createCard({
  //   required String cardNumber,
  //   required int expiryMonth,
  //   required int expiryYear,
  //   required String cardHolderName,
  // }) async {
  //   _isCreatingCard = true;
  //   emit(CardsLoaded(cards: _cards, isCreating: _isCreatingCard));
  //
  //   final result = await _checkoutRepo.addCard(
  //     cardNumber: cardNumber,
  //     cardholderName: cardHolderName,
  //     expiryMonth: expiryMonth.toString().padLeft(2, '0'),
  //     expiryYear: expiryYear.toString(),
  //     isDefault: true,
  //   );
  //
  //   switch (result) {
  //     case Ok<String>(:final value):
  //       Alerts.showToast(value, error: false);
  //       _isCreatingCard = false;
  //       emit(
  //         CardCreated(
  //           card: CardEntity(
  //             id: DateTime.now().millisecondsSinceEpoch.toString(),
  //             cardNumber: cardNumber.replaceAll(' ', ''),
  //             expiryMonth: expiryMonth,
  //             expiryYear: expiryYear,
  //             cardHolderName: cardHolderName,
  //           ),
  //         ),
  //       );
  //       await loadCheckoutData();
  //     case Err(:final error):
  //       _isCreatingCard = false;
  //       Alerts.showToast(error.message);
  //       emit(CardError(message: error.message));
  //   }
  // }

  CardEntity? _selectedCard;

  CardEntity? get selectedCard => _selectedCard;

  void selectCard(CardEntity card) {
    _selectedCard = card;
    emit(CardChange(timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  double totalOrder = 0;

  void addFinalTotal(double value) {
    totalOrder = value;
    emit(CardChange(timestamp: DateTime.now().millisecondsSinceEpoch));
  }
}
