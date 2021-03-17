import 'package:e_revenue_flutter/providers/otp/resend_counter_timer_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _buttonState = Provider<ButtonState>((ref) {
  return ref.watch(resendCounterTimerProvider.state).buttonState;
});

final buttonProvider = Provider<ButtonState>((ref) {
  return ref.watch(_buttonState);
});
