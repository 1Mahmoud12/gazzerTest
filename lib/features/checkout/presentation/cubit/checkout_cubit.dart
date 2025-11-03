import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/domain/checkout_repo.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_states.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit(this._checkoutRepo) : super(CheckoutInitial()) {
    emit(PaymentMethodLoaded(selectedPaymentMethod: _selectedPaymentMethod, walletBalance: _walletBalance, availablePoints: _availablePoints));
    loadCheckoutData();
  }

  final CheckoutRepo _checkoutRepo;

  // Payment method state
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  double _walletBalance = 0.0;
  int _availablePoints = 0;

  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;
  double get walletBalance => _walletBalance;

  int get availablePoints => _availablePoints;

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

        emit(CheckoutDataLoaded(walletBalance: _walletBalance, availablePoints: _availablePoints, paymentCards: _cards));
        emit(PaymentMethodLoaded(selectedPaymentMethod: _selectedPaymentMethod, walletBalance: _walletBalance, availablePoints: _availablePoints));
      case Err(:final error):
        Alerts.showToast(error.message);
        emit(PaymentMethodLoaded(selectedPaymentMethod: _selectedPaymentMethod, walletBalance: _walletBalance, availablePoints: _availablePoints));
    }
  }

  /// Selects a payment method
  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    emit(PaymentMethodLoaded(selectedPaymentMethod: _selectedPaymentMethod, walletBalance: _walletBalance, availablePoints: _availablePoints));
  }

  /// Places the order
  Future<void> placeOrder() async {}

  /// Loads cards
  void loadCards() {
    emit(CardsLoaded(cards: _cards, isCreating: _isCreatingCard));
  }

  /// Creates a new card (local only for now)
  Future<void> createCard({required String cardNumber, required int expiryMonth, required int expiryYear, required String cardHolderName}) async {
    _isCreatingCard = true;
    emit(CardsLoaded(cards: _cards, isCreating: _isCreatingCard));

    await Future.delayed(const Duration(milliseconds: 500));

    final card = CardEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardNumber: cardNumber.replaceAll(' ', ''),
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cardHolderName: cardHolderName,
    );

    _cards.add(card);
    _isCreatingCard = false;

    emit(CardCreated(card: card));
    await loadCheckoutData();
  }
}
