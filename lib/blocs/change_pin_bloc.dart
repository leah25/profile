import 'dart:async';

import 'package:rxdart/rxdart.dart';

class PinBloc {
  //Declare Streams
  final _pin = BehaviorSubject<String>();
  final _obscureText = BehaviorSubject<bool>.seeded(true);

  //Get
  Stream<String> get pin => _pin.stream.transform(validatePIN);
  Stream<bool> get obscureText => _obscureText.stream;

  //Set
  Function(String) get changePin => _pin.sink.add;
  Function(bool) get changeObscureText => _obscureText.sink.add;

  // Validators
  final validatePIN =
      StreamTransformer<String, String>.fromHandlers(handleData: (fName, sink) {
    if (fName.length != 4) {
      sink.addError('Invalid PIN');
    } else {
      sink.add(fName);
    }
  });

  dispose() {
    _pin.close();
    _obscureText.close();
  }
}
