import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/otp/otp_page_state_provider.dart';
import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPinField extends HookWidget {
  final String verfid;
  OtpPinField(this.verfid);
  final BoxDecoration pinPutDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
  );

  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var _textController = useTextEditingController();
    var _colors = useProvider(colorProvider);
    var signInSignUpState = useProvider(signInSignUpProvider.state);

    return Material(
      child: PinPut(
        eachFieldWidth: 35.0,
        eachFieldHeight: 35.0,
        fieldsCount: 6,
        mainAxisSize: MainAxisSize.max,
        focusNode: _pinPutFocusNode,
        controller: _textController,
        onSubmit: (pin) async {
          context.read(otpProvider).setVerifying();
          context.read(authenticationProvider).signInWithSmsCodeCredential(
                context,
                _textController.text,
                signInSignUpState.isSignInOrSignup == IsSigninOrSignup.signup,
              );
        },
        withCursor: true,
        submittedFieldDecoration:
            pinPutDecoration.copyWith(color: _colors.mainButtonsColor),
        selectedFieldDecoration:
            pinPutDecoration.copyWith(color: _colors.mainButtonsColor),
        followingFieldDecoration:
            pinPutDecoration.copyWith(color: _colors.mainButtonsColor),
        pinAnimationType: PinAnimationType.scale,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    );
  }
}
