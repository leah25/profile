import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SignInSignUpFormBloc {
  //Declare Streams
  final _firstName = BehaviorSubject<String>();
  final _middleName = BehaviorSubject<String>();
  final _surname = BehaviorSubject<String>();
  final _phoneNumberSuffix = BehaviorSubject<String>();
  final _idType = BehaviorSubject<String>.seeded("ID Type");
  final _idNumber = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _language = BehaviorSubject<String>.seeded("Language/ Chagua Lugha");
  final _gender = BehaviorSubject<String>.seeded("GENDER");

  //Get
  Stream<String> get firstName => _firstName.stream.transform(validateNames);
  Stream<String> get middleName => _middleName.stream.transform(validateNames);
  Stream<String> get surname => _surname.stream.transform(validateNames);
  Stream<String> get idType => _idType.stream;
  Stream<String> get idNumber => _idNumber.stream;
  Stream<String> get dob => _dob.stream;
  Stream<String> get language => _language.stream;
  Stream<String> get gender => _gender.stream;
  Stream<String> get phoneNumberSuffix =>
      _phoneNumberSuffix.stream.transform(validatePhoneNumberSuffix);
  Stream<bool> get inputValid => Rx.combineLatest9(
      firstName,
      middleName,
      surname,
      phoneNumberSuffix,
      idType,
      idNumber,
      dob,
      gender,
      language,
      (a, b, c, d, e, f, g, h, i) => true);

  //Set
  Function(String) get changeFirstName => _firstName.sink.add;
  Function(String) get changeMiddleName => _middleName.sink.add;
  Function(String) get changeSurname => _surname.sink.add;
  Function(String) get changeIdType => _idType.sink.add;
  Function(String) get changeIdNumber => _idNumber.sink.add;
  Function(String) get changeDob => _dob.sink.add;
  Function(String) get changeLanguage => _language.sink.add;
  Function(String) get changeGender => _gender.sink.add;
  Function(String) get changePhoneNumberSuffix => _phoneNumberSuffix.sink.add;

  // Validators
  final validateNames =
      StreamTransformer<String, String>.fromHandlers(handleData: (fName, sink) {
    if (fName.length < 3) {
      sink.addError('Minimum 3 characters');
    } else {
      sink.add(fName);
    }
  });

  final validatePhoneNumberSuffix =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.length != 9) {
      sink.addError('Invalid phone number');
    } else {
      sink.add(phone);
    }
  });

  dispose() {
    _firstName.close();
    _middleName.close();
    _surname.close();
    _idType.close();
    _idNumber.close();
    _dob.close();
    _gender.close();
    _phoneNumberSuffix.close();
    _language.close();
  }
}
