import 'dart:async';

import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';
import 'package:e_revenue_flutter/res/colors.dart';
import 'package:e_revenue_flutter/util/bezierContainer.dart';
import 'package:e_revenue_flutter/util/global_widgets.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterPin extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    StreamController<ErrorAnimationType> errorController;

    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;

    final _colors = useProvider(colorProvider);
    final bloc = useProvider(authenticationProvider).signInSignUpFormBloc;
    final authenticationState = useProvider(authenticationProvider.state);

    final signInSignUpState = useProvider(signInSignUpProvider.state);
    bool isSignup =
        signInSignUpState.isSignInOrSignup == IsSigninOrSignup.signup;

    print('bools $isSignup');
    String pin;

    storePin(registrationPin) async {
      final pref = await SharedPreferences.getInstance();
      pref.setString('regPin', registrationPin);
      context
          .read(authenticationProvider)
          .handleSuccessfulRegistration(context, isSignup, pin);

      return 'success';
    }

    verifyPin(loginPin) async {
      final pref = await SharedPreferences.getInstance();
      if (!pref.containsKey('regPin')) {
        return 'pin is incorrect';
      } else {
        //loginPin = pref.getString('regPin');

        //navigate to the home Screen
        context
            .read(authenticationProvider)
            .handleSuccessfulRegistration(context, isSignup, pin);
        return "";
      }
    }

    return Scaffold(
        body: Container(
      //signup screen
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainer(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .09),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: titleLogo(2.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            children: [
                              Text("Enter Pin"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: eRevenueRed,
                            ),

                            length: 4,
                            obscureText: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v.length < 4) {
                                return "Input Pin not less than 4 characters";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              borderWidth: 0.0,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(8),
                              fieldHeight: height * 0.08,
                              fieldWidth: width * 0.18,
                              selectedFillColor: Colors.grey,
                              selectedColor: Colors.grey,
                              activeFillColor: eRevenueRed,
                              inactiveFillColor: Colors.grey,
                              inactiveColor: Colors.grey,
                            ),
                            keyboardType: TextInputType.number,

                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            // backgroundColor: background,
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            onCompleted: (registrationPin) {
                              registrationPin = pin;
                              print(registrationPin);
                              isSignup
                                  ? storePin(registrationPin)
                                  : verifyPin(registrationPin);
                            },
                            onChanged: (String value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  StreamBuilder<bool>(
                      stream: bloc.inputValid,
                      builder: (context, snapshot) {
                        return getRaisedButton(
                            // buttonColor: _colors.mainButtonsColor,
                            buttonColor: Colors.red,
                            // colors: _colors,
                            textColor: _colors.secondaryTextColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            buttonText: "GET STARTED",
                            buttonWidget: authenticationState.isAuthenticating
                                ? PlatformCircularProgressIndicator()
                                : null,
                            onPressed: () {
                              context
                                  .read(authenticationProvider)
                                  .handleSuccessfulRegistration(
                                      context, isSignup, pin);

                              print('pinsss $pin');
                            });
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
