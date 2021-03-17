import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/global/shared_prefs_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/dashboard_page.dart';
import 'package:e_revenue_flutter/screens/pin/enter_pin.dart';
import 'package:e_revenue_flutter/screens/welcome/welcomePage.dart';
import 'package:e_revenue_flutter/util/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      child: Root(prefs),
    ),
  );
}

class Root extends HookWidget {
  final prefs;

  Root(this.prefs);

  @override
  Widget build(BuildContext context) {
    bool pin = prefs.getBool("login");
    final _colors = useProvider(colorProvider);
    useProvider(sharedPrefsProvider);

    final authenticationState = useProvider(authenticationProvider.state);
    // bool pin = true;

    return PlatformProvider(
      builder: (context) => PlatformApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          material: (_, __) {
            return MaterialAppData(
              theme: _colors.appThemeAndroid,
              themeMode: ThemeMode.light,
            );
          },
          cupertino: (_, __) => CupertinoAppData(
                theme: _colors.appThemeIos,
              ),
          onGenerateRoute: RouteGenerator.generateRoute,
          // home: authenticationState.loginState ==
          //             ApplicationLoginState.loggedIn &&
          //         pin == true
          //     ? Dashboard()
          //     : WelcomePage(),
          home:Dashboard(),
          routes: <String, WidgetBuilder>{
            '/pin': (BuildContext context) => EnterPin(),
            '/home': (BuildContext context) => Dashboard(),
            '/welcome': (BuildContext context) => WelcomePage(),
          }),
    );
  }
}
