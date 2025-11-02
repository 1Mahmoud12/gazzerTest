import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkout_states.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit() : super(CheckoutInitial()) {
    // Initialize with default payment method
    emit(
      PaymentMethodLoaded(
        selectedPaymentMethod: _selectedPaymentMethod,
        walletBalance: _walletBalance,
      ),
    );
  }

  // Fake vouchers data
  final List<String> _fakeVouchers = ['ASD123', 'ASD333', 'ASD231'];

  // Map of voucher codes to discount amounts (in percentage)
  final Map<String, double> _voucherDiscounts = {
    'ASD123': 10.0,
    'ASD333': 20.0,
    'ASD231': 15.0,
  };

  List<String> get vouchers => _fakeVouchers;

  // Payment method state
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  double _walletBalance = 500.0;

  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;

  double get walletBalance => _walletBalance;

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

  /// Toggles text field enabled/disabled state
  bool isTextFieldEnabled = false;

  void toggleTextField() {
    isTextFieldEnabled = !isTextFieldEnabled;
    emit(VoucherChange(timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  /// Applies a voucher code
  Future<void> applyVoucher(String code) async {
    // Validate code is not empty
    if (code.trim().isEmpty) {
      emit(
        const VoucherError(
          message: 'Please enter a voucher code',
        ),
      );
      return;
    }

    emit(VoucherLoading());

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if voucher exists in fake data
    final normalizedCode = code.trim().toUpperCase();
    if (_voucherDiscounts.containsKey(normalizedCode)) {
      final discount = _voucherDiscounts[normalizedCode]!;
      emit(
        VoucherApplied(
          voucherCode: normalizedCode,
          discountAmount: discount,
        ),
      );
    } else {
      emit(
        const VoucherError(
          message: 'Invalid voucher code',
        ),
      );
    }
  }

  /// Selects a payment method
  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    emit(
      PaymentMethodLoaded(
        selectedPaymentMethod: _selectedPaymentMethod,
        walletBalance: _walletBalance,
      ),
    );
  }

  /// Places the order
  Future<void> placeOrder() async {
    // TODO: Implement place order logic
    // This will call the API to place the order with the selected payment method
  }

  /// Loads cards
  void loadCards() {
    emit(
      CardsLoaded(
        cards: _cards,
        isCreating: _isCreatingCard,
      ),
    );
  }

  /// Creates a new card
  Future<void> createCard({
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required String cardHolderName,
  }) async {
    _isCreatingCard = true;
    emit(
      CardsLoaded(
        cards: _cards,
        isCreating: _isCreatingCard,
      ),
    );

    // Simulate API delay
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

    emit(
      CardCreated(
        card: card,
      ),
    );
  }
}
