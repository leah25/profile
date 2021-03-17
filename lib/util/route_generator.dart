import 'dart:io';

import 'package:e_revenue_flutter/res/strings.dart';
import 'package:e_revenue_flutter/screens/welcome/welcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case DASHBOARD_ROUTE:
        return _returnPage(WelcomePage());
      case SIGNIN_SIGNUP_ROUTE:
        return _returnPage(WelcomePage());

      default:
        return _errorRoute();
    }
  }

  static _returnPage(page) {
    if (Platform.isIOS) return CupertinoPageRoute(builder: (_) => page);
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return PlatformScaffold(
          material: (context, platform) => MaterialScaffoldData(
            appBar: AppBar(
              title: Text('Error'),
            ),
          ),
          body: Center(
            child: Text('AN ERROR OCCURRED'),
          ),
        );
      },
    );
  }
}
