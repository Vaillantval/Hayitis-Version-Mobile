// lib/features/checkout/providers/checkout_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutState {
  final int step;
  final String? paymentMethod;
  final Map<String, dynamic>? deliveryAddress;
  final String? deliveryNotes;
  final int? createdOrderId;
  final bool isLoading;
  final String? error;

  const CheckoutState({
    this.step = 0,
    this.paymentMethod,
    this.deliveryAddress,
    this.deliveryNotes,
    this.createdOrderId,
    this.isLoading = false,
    this.error,
  });

  CheckoutState copyWith({
    int? step,
    String? paymentMethod,
    Map<String, dynamic>? deliveryAddress,
    String? deliveryNotes,
    int? createdOrderId,
    bool? isLoading,
    String? error,
  }) => CheckoutState(
    step:            step ?? this.step,
    paymentMethod:   paymentMethod ?? this.paymentMethod,
    deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    deliveryNotes:   deliveryNotes ?? this.deliveryNotes,
    createdOrderId:  createdOrderId ?? this.createdOrderId,
    isLoading:       isLoading ?? this.isLoading,
    error:           error,
  );
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(const CheckoutState());

  void setPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method, step: 1);
  }

  void setDeliveryAddress(Map<String, dynamic> address) {
    state = state.copyWith(deliveryAddress: address, step: 2);
  }

  void setDeliveryNotes(String notes) {
    state = state.copyWith(deliveryNotes: notes, step: 3);
  }

  void setOrderId(int orderId) {
    state = state.copyWith(createdOrderId: orderId);
  }

  void previousStep() {
    if (state.step > 0) state = state.copyWith(step: state.step - 1);
  }

  void setLoading(bool loading) => state = state.copyWith(isLoading: loading);
  void setError(String? error) => state = state.copyWith(error: error);

  void reset() => state = const CheckoutState();
}

final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>(
  (_) => CheckoutNotifier(),
);
