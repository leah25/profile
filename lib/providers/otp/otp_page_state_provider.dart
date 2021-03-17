import 'package:hooks_riverpod/hooks_riverpod.dart';

final otpProvider =
    StateNotifierProvider.autoDispose<OtpPageBloc>((ref) => OtpPageBloc());

class OtpPageBloc extends StateNotifier<OtpModel> {
  OtpPageBloc([OtpModel state])
      : super(state ?? OtpModel(OTPPageState.opened, ""));

  /// Set the page state to verifying
  setVerifying() {
    state = OtpModel(OTPPageState.veryfying, state.errorMessage);
  }

  /// Set the page state to verified
  setVerified() {
    state = OtpModel(OTPPageState.verified, state.errorMessage);
  }

  /// Set the page state to errored
  setErrored(String message) {
    state = OtpModel(OTPPageState.errored, message);
  }

  /// Set the page state to errored
  setOpened() {
    state = OtpModel(OTPPageState.opened, state.errorMessage);
  }
}

class OtpModel {
  final OTPPageState pageState;
  final String errorMessage;

  OtpModel(this.pageState, this.errorMessage);
}

enum OTPPageState { verified, veryfying, errored, opened }
