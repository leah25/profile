import 'package:e_revenue_flutter/blocs/signup_form_bloc.dart';
import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';
import 'package:e_revenue_flutter/res/colors.dart';
import 'package:e_revenue_flutter/res/values.dart';
import 'package:e_revenue_flutter/screens/change_pin_page/change_pin_page.dart';
import 'package:e_revenue_flutter/screens/otp/otp_page.dart';
import 'package:e_revenue_flutter/screens/signin_signup_page/signin_signup.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class SignupFormssssss extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _colors = useProvider(colorProvider);
    final bloc = useProvider(authenticationProvider).signInSignUpFormBloc;
    final authenticationStateProvider = useProvider(authenticationProvider);
    final authenticationState = useProvider(authenticationProvider.state);
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Image.asset(
                  'assets/images/processed.jpeg',
                  scale: 8,
                  errorBuilder: (context, error, stackTrace) {
                    print("error is $error, stack is $stackTrace");
                    return Icon(PlatformIcons(context).error);
                  },
                ),
              ],
            ),
            Container(
              child: Row(
                children: [
                  Flexible(
                      child: StreamBuilder<Object>(
                          stream: bloc.firstName,
                          builder: (context, snapshot) {
                            return formField(
                              context,
                              "First Name",
                              true,
                              onChanged: bloc.changeFirstName,
                              error: snapshot.error,
                            );
                          })),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: StreamBuilder<Object>(
                          stream: bloc.middleName,
                          builder: (context, snapshot) {
                            return formField(
                              context,
                              "Middle Name",
                              true,
                              onChanged: bloc.changeMiddleName,
                              error: snapshot.error,
                            );
                          })),
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
            StreamBuilder<String>(
                stream: bloc.phoneNumberSuffix,
                builder: (context, snapshot) {
                  return formField(
                    context,
                    "Phone Number",
                    false,
                    prefix: "+254",
                    onChanged: bloc.changePhoneNumberSuffix,
                    error: snapshot.error,
                  );
                }),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  StreamBuilder<String>(
                      stream: bloc.idType,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return dropdown(
                            idTypes, snapshot.data, bloc.changeIdType, context);
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: StreamBuilder<String>(
                          stream: bloc.idNumber,
                          builder: (context, snapshot) {
                            return formField(
                              context,
                              "ID Number",
                              false,
                              onChanged: bloc.changeIdNumber,
                              error: snapshot.error,
                            );
                          })),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: StreamBuilder<String>(
                  stream: bloc.language,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return dropdown(
                        languages, snapshot.data, bloc.changeLanguage, context);
                  }),
              width: double.infinity,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                StreamBuilder<String>(
                    stream: bloc.gender,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return dropdown(
                          gender, snapshot.data, bloc.changeGender, context);
                    }),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: StreamBuilder<String>(
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
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 50),
        ),
        StreamBuilder<bool>(
            stream: bloc.inputValid,
            builder: (context, snapshot) {
              return getRaisedButton(
                buttonColor: _colors.mainButtonsColor,
                colors: _colors,
                textColor: _colors.secondaryTextColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                buttonText: "GET STARTED",
                buttonWidget: authenticationState.isAuthenticating
                    ? PlatformCircularProgressIndicator()
                    : null,
                onPressed: snapshot.data == true
                    ? () async {
                        var phoneNumber = await bloc.phoneNumberSuffix.first;
                        authenticationStateProvider.phoneVerify(
                          "+254$phoneNumber",context
                          
                        );
                      }
                    : null,
              );
            }),
        Padding(
          padding: EdgeInsets.only(top: 30),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            child: Text("Already have an account?"),
            onTap: () {
              context
                  .read(signInSignUpProvider)
                  .setPage(IsSigninOrSignup.signin);
            },
          ),
        )
      ],
    );
  }
}


Widget dropdown(
    List items, String hint, Function onPressed, BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  return PlatformWidget(
    material: (context, platform) => DropdownButtonHideUnderline(
      child: Container(
        width: width,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        padding: EdgeInsets.only(left: 5),
        child: DropdownButton(
          hint: Text(hint),
          items: items.map<DropdownMenuItem<dynamic>>((value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Container(
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: onPressed,
        ),
      ),
    ),
    cupertino: (context, platform) => CupertinoButton(
      child: Text(
        "Text",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        await showCupertinoModalPopup(
          context: context,
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.2,
              child: CupertinoPicker(
                backgroundColor: CupertinoColors.white,
                onSelectedItemChanged: (int value) {
                  onPressed(items[value]);
                },
                itemExtent: 50,
                children: [
                  for (var number in items) ...[
                    Text(number),
                  ]
                ],
              ),
            );
          },
        );
      },
    ),
  );
}

Widget submitButton(
    BuildContext context, GlobalAppColors colors, SignInSignUpFormBloc bloc) {
  return getRaisedButton(
      buttonColor: colors.mainButtonsColor,
      colors: colors,
      textColor: colors.secondaryTextColor,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      buttonText: "Log In",
      buttonWidget: null,
      onPressed: () async {
        var phoneNumber = await bloc.phoneNumberSuffix.first;

        context
            .read(authenticationProvider)
            .phoneVerify('+254$phoneNumber',context);

        Navigator.push(
          context,
          platformPageRoute(
            context: context,
            builder: (context) => OtpPage(),
          ),
        );
      });
}

Widget createAccountLabel(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupSignInForm()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
