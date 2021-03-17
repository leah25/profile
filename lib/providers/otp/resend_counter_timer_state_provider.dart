import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final resendCounterTimerProvider = StateNotifierProvider<ResendTimerNotifier>(
  (ref) => ResendTimerNotifier(),
);

class ResendTimerNotifier extends StateNotifier<ResendTimerModel> {
  ResendTimerNotifier() : super(_initialState) {
    start();
  }

  static const int _initialDuration = 35;
  static final _initialState = ResendTimerModel(
    _durationString(_initialDuration),
    ButtonState.initial,
  );

  final TickerResend _ticker = TickerResend();
  StreamSubscription<int> _tickerSubscription;

  static String _durationString(int duration) {
    final minutes = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void start() {
    state = ResendTimerModel(state.timeLeft, ButtonState.started);
    _startTimer();
  }

  void _startTimer() {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: _initialDuration).listen((duration) {
      state = ResendTimerModel(_durationString(duration), ButtonState.started);
    });

    _tickerSubscription.onDone(() {
      state = ResendTimerModel(state.timeLeft, ButtonState.finished);
    });
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = _initialState;
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class TickerResend {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

class ResendTimerModel {
  const ResendTimerModel(this.timeLeft, this.buttonState);
  final String timeLeft;
  final ButtonState buttonState;
}

enum ButtonState {
  initial,
  started,
  finished,
}
