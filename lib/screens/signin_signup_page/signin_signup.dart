import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';
import 'package:e_revenue_flutter/res/strings.dart';
import 'package:e_revenue_flutter/res/values.dart';
import 'package:e_revenue_flutter/screens/change_pin_page/change_pin_page.dart';
import 'package:e_revenue_flutter/screens/otp/otp_page.dart';
import 'package:e_revenue_flutter/screens/signin_signup_page/widgets.dart';
import 'package:e_revenue_flutter/util/bezierContainer.dart';
import 'package:e_revenue_flutter/util/global_widgets.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class SignupSignInForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks

    final height = MediaQuery.of(context).size.height;

    final colors = useProvider(colorProvider);
    final bloc = useProvider(authenticationProvider).signInSignUpFormBloc;
    final authenticationState = useProvider(authenticationProvider.state);
    final signInSignUpState = useProvider(signInSignUpProvider.state);

    return Scaffold(
      body: Container(
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
                    signInSignUpState.isSignInOrSignup ==
                            IsSigninOrSignup.signin
                        ? SizedBox(height: height * .2)
                        : SizedBox(height: height * .09),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: titleLogo(4.0),
                    ),
                    Column(
                      children: [
                        signInSignUpState.isSignInOrSignup ==
                                IsSigninOrSignup.signin
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 50),
                                  StreamBuilder<String>(
                                      stream: bloc.phoneNumberSuffix,
                                      builder: (context, snapshot) {
                                        return formField(
                                          context,
                                          "Phone Number",
                                          false,
                                          prefix: "+254",
                                          onChanged:
                                              bloc.changePhoneNumberSuffix,
                                          error: snapshot.error,
                                        );
                                      }),
                                  SizedBox(height: 20),
                                  submitButton(context, colors, bloc),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          platformPageRoute(
                                              context: context,
                                              builder: (context) =>
                                                  ChangePinPage()),
                                          (route) => false);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Forgot Pin ?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  divider(),
                                  // _createAccountLabel(context),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        StreamBuilder<Object>(
                                            stream: bloc.firstName,
                                            builder: (context, snapshot) {
                                              return formField(
                                                context,
                                                "First Name",
                                                true,
                                                onChanged: bloc.changeFirstName,
                                                error: snapshot.error,
                                              );
                                            }),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        StreamBuilder<Object>(
                                            stream: bloc.middleName,
                                            builder: (context, snapshot) {
                                              return formField(
                                                context,
                                                "Middle Name",
                                                true,
                                                onChanged:
                                                    bloc.changeMiddleName,
                                                error: snapshot.error,
                                              );
                                            }),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder<Object>(
                                      stream: bloc.surname,
                                      builder: (context, snapshot) {
                                        return formField(
                                          context,
                                          "Surname",
                                          true,
                                          onChanged: bloc.changeSurname,
                                          error: snapshot.error,
                                        );
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.phoneNumberSuffix,
                                      builder: (context, snapshot) {
                                        return formField(
                                          context,
                                          "Phone Number",
                                          false,
                                          prefix: "+254",
                                          onChanged:
                                              bloc.changePhoneNumberSuffix,
                                          error: snapshot.error,
                                        );
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.idType,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return dropdown(idTypes, snapshot.data,
                                            bloc.changeIdType, context);
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.idNumber,
                                      builder: (context, snapshot) {
                                        return formField(
                                          context,
                                          "ID Number",
                                          false,
                                          onChanged: bloc.changeIdNumber,
                                          error: snapshot.error,
                                        );
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.gender,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return dropdown(gender, snapshot.data,
                                            bloc.changeGender, context);
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  StreamBuilder<String>(
                                    stream: bloc.dob,
                                    builder: (context, snapshot) {
                                      return formField(
                                        context,
                                        "DOB",
                                        true,
                                        bloc: bloc,
                                        error: snapshot.error,
                                        currentText: snapshot.data,
                                      );
                                    },
                                  ),
                                ],
                              ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        signInSignUpState.isSignInOrSignup ==
                                IsSigninOrSignup.signin
                            ? Container()
                            : StreamBuilder<bool>(
                                stream: bloc.inputValid,
                                builder: (context, snapshot1) {
                                  return StreamBuilder<bool>(
                                    stream: bloc.inputValid,
                                    builder: (context, snapshot2) {
                                      return getRaisedButton(
                                        colors: colors,
                                        buttonText: "Continue",
                                        buttonColor: colors.mainButtonsColor,
                                        textColor: colors.mainBackgroundColor,
                                        buttonWidget: authenticationState
                                                .isAuthenticating
                                            ? PlatformCircularProgressIndicator(
                                                material: (context, platform) =>
                                                    MaterialProgressIndicatorData(
                                                        backgroundColor: colors
                                                            .mainBackgroundColor),
                                              )
                                            : null,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 100),
                                        onPressed: () async {
                                          var phoneNumber = await bloc
                                              .phoneNumberSuffix.first;

                                          context
                                              .read(authenticationProvider)
                                              .phoneVerify(
                                                  '+254$phoneNumber', context);

                                          Navigator.push(
                                            context,
                                            platformPageRoute(
                                              context: context,
                                              builder: (context) => OtpPage(),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            child: Text(
                              signInSignUpState.isSignInOrSignup ==
                                      IsSigninOrSignup.signup
                                  ? alreadyHaveAnAccount
                                  : dontHaveAnAccount,
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SignupSignInForm(),
                              //   ),
                              // );
                              context.read(signInSignUpProvider).togglePage();

                              // context
                              //     .read(signInSignUpProvider)
                              //     .setPage(IsSigninOrSignup.signin);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
