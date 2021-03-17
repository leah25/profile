import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/otp/otp_page_state_provider.dart';
import 'package:e_revenue_flutter/providers/otp/resend_button_provider.dart';
import 'package:e_revenue_flutter/providers/otp/resend_counter_timer_state_provider.dart';
import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';
import 'package:e_revenue_flutter/screens/otp/widgets.dart';
import 'package:e_revenue_flutter/screens/pin/enter_pin.dart';
import 'package:e_revenue_flutter/screens/signin_signup_page/signin_signup.dart';
import 'package:e_revenue_flutter/util/global_functions.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _colors = useProvider(colorProvider);
    final _otpState = useProvider(otpProvider.state);
    final bloc = useProvider(authenticationProvider).signInSignUpFormBloc;
    final buttonState = useProvider(buttonProvider);
    final resendTimer = useProvider(resendCounterTimerProvider.state);

    final verfid = useProvider(verificationIdUserProvider).state;

    var margin = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        context
            .read(otpProvider)
            .setOpened(); // On exit, remove error message shown by changing state to opened
        return Future<bool>.value(true);
      },
      child: PlatformScaffold(
        backgroundColor: _colors.mainBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: margin * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/COMPASeRevenue.png',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: margin * 0.02),
                    child: Text(
                      'Verify Phone Number',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: margin * 0.06),
                    child: StreamBuilder<Object>(
                        stream: bloc.phoneNumberSuffix,
                        builder: (context, snapshot) {
                          return Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                      "Please enter the verification code sent to ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "+254${snapshot.data}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        TextSpan(
                                          style: TextStyle(
                                            color: _colors.mainButtonsColor,
                                            fontSize: 15.0,
                                          ),
                                          text: "\b\rChange ?",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignupSignInForm()),
                                                      (Route<dynamic> route) =>
                                                  false);
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: margin * 0.06),
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: OtpPinField(verfid),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: margin * 0.08),
                                  child: Text(
                                    "Message sending might take a few seconds...",
                                  ),
                                ),
                                switchCase2(
                                  _otpState.pageState,
                                  {
                                    OTPPageState.veryfying: Column(children: [
                                      PlatformCircularProgressIndicator(),
                                      Padding(
                                          padding: EdgeInsets.only(top: 15.0)),
                                      Text("Verifying...")
                                    ]),
                                    OTPPageState.errored: Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 30),
                                      child: Column(
                                        children: [
                                          Text(_otpState.errorMessage),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EnterPin()),
                                                          (Route<dynamic> route) =>
                                                      false);
                                                },
                                                child: Text(
                                                  "Skip To Home",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 16,
                                                      color: _colors
                                                          .mainButtonsColor),
                                                ),
                                              ),
                                              getRaisedButton(
                                                  buttonColor:
                                                  _colors.mainButtonsColor,
                                                  buttonText: "Go To Register",
                                                  padding: EdgeInsets.all(10),
                                                  colors: _colors,
                                                  onPressed: () {
                                                    context
                                                        .read(
                                                        signInSignUpProvider)
                                                        .setPage(
                                                        IsSigninOrSignup
                                                            .signup);
                                                    context
                                                        .read(otpProvider)
                                                        .setOpened();
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        platformPageRoute(
                                                            builder: (context) =>
                                                                SignupSignInForm(),
                                                            context: context),
                                                            (Route<dynamic>
                                                        route) =>
                                                        false);
                                                  },
                                                  textColor: _colors
                                                      .secondaryTextColor)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    OTPPageState.opened: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (buttonState ==
                                                ButtonState.finished) {
                                              context
                                                  .read(authenticationProvider)
                                                  .phoneVerify(
                                                  "+254${snapshot.data}",
                                                  context
                                              );
                                              context
                                                  .read(
                                                  resendCounterTimerProvider)
                                                  .start();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Wait for ${resendTimer.timeLeft} seconds to resend");
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: margin * 0.08),
                                            child: Text(
                                              "Resend Code",
                                              style: TextStyle(
                                                decoration:
                                                TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: buttonState !=
                                                    ButtonState.finished
                                                    ? Colors.grey
                                                    : _colors.mainButtonsColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        Text(
                                          buttonState != ButtonState.finished
                                              ? "Resending available in ${resendTimer.timeLeft}"
                                              : "Resending available",
                                        )
                                      ],
                                    ),
                                    OTPPageState.verified: Text("Login"),
                                  },
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}