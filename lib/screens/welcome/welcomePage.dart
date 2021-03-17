import 'package:e_revenue_flutter/providers/signin_signup/signin_signup_state_provider.dart';
import 'package:e_revenue_flutter/screens/language/select_language.dart';
import 'package:e_revenue_flutter/screens/pin/enter_pin.dart';
import 'package:e_revenue_flutter/screens/signin_signup_page/signin_signup.dart';
import 'package:e_revenue_flutter/util/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';


import 'biometric_authentication.dart';

class WelcomePage extends HookWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read(signInSignUpProvider).setPage(IsSigninOrSignup.signin);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupSignInForm(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget _signUpButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read(signInSignUpProvider).setPage(IsSigninOrSignup.signup);
        Navigator.push(
          context,
          platformPageRoute(
              context: context, builder: (context) => SelectLanguage()
              // SignupForm(),
              ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  // Widget _label(BuildContext context) {
  //   return Container(
  //       margin: EdgeInsets.only(top: 40, bottom: 20),
  //       child: Column(
  //         children: <Widget>[
  //           Text(
  //             'Quick login with Touch ID',
  //             style: TextStyle(color: Colors.white, fontSize: 17),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           GestureDetector(
  //              child: Icon(Icons.fingerprint, size: 90, color: Colors.white),
  //             onTap: () async {
  //               final isAuthenticated = await LocalAuthApi.authenticate();
  //
  //               if (isAuthenticated) {
  //                 Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(builder: (context) => EnterPin()),
  //                 );
  //               }
  //             },
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           GestureDetector(
  //             onTap: () async {
  //               final isAvailable = await LocalAuthApi.hasBiometrics();
  //               final biometrics = await LocalAuthApi.getBiometrics();
  //
  //               final hasFingerprint =
  //                   biometrics.contains(BiometricType.fingerprint);
  //
  //               showDialog(
  //                 context: context,
  //                 builder: (context) => AlertDialog(
  //                   title: Text('Availability'),
  //                   content: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       buildText('Biometrics', isAvailable),
  //                       buildText('Fingerprint', hasFingerprint),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //             child: Text(
  //               'Touch ID',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 15,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleLogo(4.0),
              SizedBox(
                height: 80,
              ),
              _submitButton(context),
              SizedBox(
                height: 20,
              ),
              _signUpButton(context),
              SizedBox(
                height: 20,
              ),
              Biometric()
            ],
          ),
        ),
      ),
    );
  }
}
