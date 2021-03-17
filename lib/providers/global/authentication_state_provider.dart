//import 'dart:convert';

//import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:e_revenue_flutter/blocs/change_pin_bloc.dart';
import 'package:e_revenue_flutter/blocs/signup_form_bloc.dart';
import 'package:e_revenue_flutter/models/authentication_user_dto.dart';
import 'package:e_revenue_flutter/models/change_pin_response_dto.dart'
    as changePinModel;
import 'package:e_revenue_flutter/models/login_response_dto.dart' as loginModel;
import 'package:e_revenue_flutter/providers/global/shared_prefs_provider.dart';
import 'package:e_revenue_flutter/providers/languages_provider.dart';
import 'package:e_revenue_flutter/providers/otp/otp_page_state_provider.dart';
import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';
import 'package:e_revenue_flutter/repository/authentication_repository.dart';
import 'package:e_revenue_flutter/res/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final firebaseUserProvider = StateProvider<User>((ref) => null);

final verificationIdUserProvider = StateProvider<String>((ref) => null);

final authenticationProvider =
    StateNotifierProvider((ref) => AuthenticationService(ref.read, ref.watch));

class AuthenticationService extends StateNotifier<AuthenticationModel> {
  FirebaseAuth _auth;
  SignInSignUpFormBloc _signInSignUpFormBloc;
  PinBloc _pinBloc;
  AuthenticationRepository _repository;

  SignInSignUpFormBloc get signInSignUpFormBloc => _signInSignUpFormBloc;
  PinBloc get pinBloc => _pinBloc;

  FirebaseAuth get auth => _auth;
  Reader read;
  final watch;

  /// Authentication business logic
  AuthenticationService(this.read, this.watch, [AuthenticationModel state])
      : super(state ??
            AuthenticationModel(ApplicationLoginState.loggedOut,
                isAuthenticating: false, verificationId: "")) {
    initFirebase();
    _signInSignUpFormBloc = SignInSignUpFormBloc();
    _pinBloc = PinBloc();
    _repository = AuthenticationRepository();
  }

  /// Initialize the firebase app
  Future<void> initFirebase() async {
    _auth = FirebaseAuth.instance;
    _auth.userChanges().listen((user) {
      if (user != null) {
        read(firebaseUserProvider).state = user;
        state = AuthenticationModel(ApplicationLoginState.loggedIn,
            isAuthenticating: false, verificationId: state.verificationId);
      } else {
        read(firebaseUserProvider).state = null;
        state = AuthenticationModel(ApplicationLoginState.loggedOut,
            isAuthenticating: false, verificationId: state.verificationId);
      }
    });
  }

  /// On native platforms, the user's phone number must be first verified and then the user can either sign-in
  /// or link their account with a PhoneAuthCredential
  Future<void> phoneVerify(String phone, BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              /// navigate
              Navigator.of(context).pushNamed('/pin');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print('error ${e.message}');

          Fluttertoast.showToast(
              msg: 'Authentication failed. Please try again');

          if (e.message == "A network error") {
            Fluttertoast.showToast(
                msg: 'A network error ocurred. Please check your connection.');
          }
        },
        codeSent: (String verificationID, int resendToken) {
          print('verification 2 $verificationID');
          read(verificationIdUserProvider).state = verificationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          read(verificationIdUserProvider).state = verificationID;
        },
        timeout: Duration(seconds: 120));
  }

  /// Sign in with sms code
  signInWithSmsCodeCredential(
    BuildContext context,
    String smsCode,
    bool isSignup,
  ) async {
    final verid = read(verificationIdUserProvider).state;

    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verid, smsCode: smsCode))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushNamedAndRemoveUntil(context, '/pin', (route) => false);
          // Navigator.of(context).pushNamed('/pin');
        }
      });
    } catch (error) {
      print(error.message);
      String message;
      switch (error.message) {
        case "The verification ID used to create the phone auth credential is invalid.":
          message = "Could not authenticate you due to invalid credentials";
          break;
        case "The sms code has expired. Please re-send the verification code to try again.":
          message =
              "The sms code has expired. Please re-submit your number to try again.";
          break;
        default:
          message = "Could not authenticate you due to invalid credentials";
      }
      setAuthErrored(message);
      // }      Fluttertoast.showToast(msg: '$message,Please try again');
    }
  }

  /// Send the current user's device token
  Future sendUserDeviceToken() async {
    // final token = await read(apiTokenProvider.future);
    final firebaseToken = await FirebaseMessaging.instance.getToken();

    return firebaseToken;
  }

  /// this is where the sign in will take place
  Future<loginModel.LoginResponseDTO> signIn(BuildContext context,
      {String pin}) async {
    state = AuthenticationModel(state.loginState,
        isAuthenticating: true, verificationId: state.verificationId);
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final now = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Bloc data
    final phoneNumber =
        "254" + await _signInSignUpFormBloc.phoneNumberSuffix.first;

    var body = AuthenticationUserDTO(
      txntimestamp: now.toString(),
      xref: "602228979268",
      data: Data(
        channelDetails: ChannelDetails(
          channel: "USSD",
          channelKey: "123456",
          clientId: "eRevenue",
          geolocation: androidInfo.version.codename,
          host: "127.0.0.1",
          userAgent: "android",
          userAgentVersion: androidInfo.version.codename,
        ),
        transactionDetails: TransactionDetails(
          amount: 0,
          currency: "KES",
          debitAccount: phoneNumber,
          pin: pin,
          direction: "0100",
          hostCode: "MM",
          phoneNumber: phoneNumber,
          transactionCode: "LOGINMM",
          transactionType: "LOGIN",
        ),
      ),
    );

    var result = await _repository.signIn(body);
    state = AuthenticationModel(state.loginState,
        isAuthenticating: false, verificationId: state.verificationId);
    if (result == null) return null;
    var response = loginModel.LoginResponseDTO.fromJson(result);
    state = AuthenticationModel(state.loginState,
        isAuthenticating: false, verificationId: state.verificationId);
    if (response.data.response.response == "success") {
      // some changes are being done,, when done please check here to see what will happen

      prefs.setBool('login', true);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

      return loginModel.LoginResponseDTO.fromJson(result);
    }
    return null;
  }

  Future changePin(Function showSnackbar) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // ignore: unused_local_variable
    final now = DateTime.now();

    // Bloc data
    final phoneNumber =
        "254" + await _signInSignUpFormBloc.phoneNumberSuffix.first;
    final pin = await _pinBloc.pin.first;

    var body = changePinModel.ChangePinDTO(
      data: changePinModel.Data(
        channelDetails: changePinModel.ChannelDetails(
          channel: "USSD",
          channelKey: "123456",
          clientId: "eRevenue",
          geolocation: androidInfo.version.codename,
          host: "127.0.0.1",
          userAgent: "android",
          userAgentVersion: androidInfo.version.codename,
        ),
        transactionDetails: changePinModel.TransactionDetails(
          currency: "KES",
          debitAccount: phoneNumber,
          direction: "0100",
          hostCode: "MM",
          phoneNumber: phoneNumber,
          pin: pin,
          transactionCode: "PINCHANGEMM",
          transactionType: "PINCHANGE",
        ),
      ),
    );

    var response = await _repository.changePIN(body);
    showSnackbar();
    return response;
  }

  /// Logout the current user
  Future logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('login');
    await _auth.signOut();
  }

  /// Handle state changes if authentication fails
  setAuthErrored(String message) {
    try {
      _auth.signOut();
    } catch (e) {}
    read(otpProvider).setErrored(message);
  }

  /// Performs actions that are meant to happen on successful authentication of the user.
  /// 1. Sends the user information to the m-gari backend
  /// 2. Sets the user as no longer a first time user
  /// 3. Navigates the user the home page
  // ignore: unused_element
  void handleSuccessfulRegistration(
    BuildContext context,
    bool isSignup,
    String pin,
  ) async {
    var deviceId = await sendUserDeviceToken();

    print('device Id  token $deviceId');
    print('bool 22 $isSignup');

    print("Os isSignup is lo $isSignup");

    if (isSignup) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final now = DateTime.now();

      final language = watch(languageStateProvider).state;

      //Bloc data
      final phoneNumber =
          "254" + await _signInSignUpFormBloc.phoneNumberSuffix.first;
      final dob = await _signInSignUpFormBloc.dob.first;
      final firstName = await _signInSignUpFormBloc.firstName.first;
      final middleName = await _signInSignUpFormBloc.middleName.first;
      final surname = await _signInSignUpFormBloc.surname.first;
      final gender = await _signInSignUpFormBloc.gender.first;
      final idNumber = await _signInSignUpFormBloc.idNumber.first;
      final idType = await _signInSignUpFormBloc.idType.first;

      print("Os version is ${androidInfo.version.release}");
      print("Os version is ${androidInfo.version.baseOS}");
      print("Os version is ${androidInfo.version.incremental}");
      print("Os version is ${androidInfo.version.previewSdkInt}");
      print("Os version is ${androidInfo.version.release}");
      print("Os version is ${androidInfo.version.securityPatch}");

      print("Os isSignup is re $isSignup");

      var response = await _repository.register(
        AuthenticationUserDTO(
          txntimestamp: now.toString(),
          xref: "602228979268",
          data: Data(
            channelDetails: ChannelDetails(
              channel: "USSD",
              channelKey: "123456",
              clientId: "eRevenue",
              geolocation: androidInfo.version.codename,
              host: "105.163.188.204",
              userAgent: "android",
              userAgentVersion: androidInfo.version.codename,
              deviceId: deviceId,
            ),
            transactionDetails: TransactionDetails(
              currency: "KES",
              debitAccount: phoneNumber,
              direction: "0100",
              dob: dob,
              pin: pin,
              firstName: firstName,
              gender: gender,
              hostCode: "MM",
              idNumber: idNumber,
              idType: idType,
              imsi: "12344",
              lang: language,
              lastName: surname,
              phoneNumber: phoneNumber,
              secondName: middleName,
              transactionCode: "SELFREGMM",
              transactionType: "SELFREG",
            ),
          ),
        ),
      );

      AuthenticationUserDTO register = AuthenticationUserDTO.fromJson(response);

      read(signInSignUpProvider).setPage(IsSigninOrSignup.signin);
      if (register.data.response.response == 'Duplicate Record') {
        Fluttertoast.showToast(
          msg: "Account Exits. Please LogIn",
        );
        context.read(authenticationProvider).logout(context);

        Navigator.pushNamedAndRemoveUntil(
            context, '/welcome', (route) => false);
      } else {
        state = AuthenticationModel(ApplicationLoginState.loggedIn,
            isAuthenticating: false, verificationId: state.verificationId);

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else {
      signIn(context, pin: pin);
    }

    read(otpProvider).setOpened();
  }

  /// Change a user's firt time user status
  setFirstTimeUser() async {
    var prefs = await watch(sharedPrefsProvider.future);
    prefs.setBool(RETURN_USER, true);
  }

  @override
  void dispose() {
    _signInSignUpFormBloc.dispose();
    _pinBloc.dispose();
    super.dispose();
  }
}

/// State model
class AuthenticationModel {
  final bool isAuthenticating;
  final String verificationId;
  final ApplicationLoginState _loginState;

  ApplicationLoginState get loginState => _loginState;

  AuthenticationModel(
    this._loginState, {
    @required this.isAuthenticating,
    @required this.verificationId,
  });
}

enum ApplicationLoginState { loggedIn, loggedOut }
