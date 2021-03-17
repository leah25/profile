import 'package:e_revenue_flutter/screens/dashboard_page/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:toast/toast.dart';

class Biometric extends StatefulWidget {
  @override
  _BiometricState createState() => _BiometricState();
}

class _BiometricState extends State<Biometric> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? Toast.show("Biometric is available", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
        : Toast.show("Biometric is unavailable", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    // ? print('Biometric is availabl')
    // : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

  Future<void> _authenticateUser() async {
    try {
      bool isAuthenticated =
          await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to view our services",
        useErrorDialogs: true,
        stickyAuth: true,
      );
      isAuthenticated
          ? Toast.show("User is authenticated!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
          : Toast.show("User is not authenticated.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      if (isAuthenticated == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    // ? print('User is authenticated!')
    // : print('User is not authenticated.');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Icon(Icons.fingerprint, size: 90, color: Colors.white),
              onTap: () async {
                // if (await _isBiometricAvailable()) {
                //   await _getListOfBiometricTypes();
                //   await _authenticateUser();
                // }
                await _authenticateUser();
              },
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                // if (await _isBiometricAvailable()) {
                //   await _getListOfBiometricTypes();
                //   await _authenticateUser();
                // }
                await _authenticateUser();
              },
              child: Text(
                'Touch ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ));
  }
}
