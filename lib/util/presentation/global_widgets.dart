import 'package:e_revenue_flutter/blocs/signup_form_bloc.dart';
import 'package:e_revenue_flutter/providers/dashboard/dashboard_tab_provider.dart';
import 'package:e_revenue_flutter/providers/global/authentication_state_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/res/colors.dart';
import 'package:e_revenue_flutter/res/strings.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/dashboard_page.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:e_revenue_flutter/screens/profile/profile_screen.dart';
import 'package:e_revenue_flutter/util/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

/// Get a custom raised button
Widget getRaisedButton(
    {String buttonText,
    dynamic icon,
    Color buttonColor,
    Color textColor,
    dynamic colors,
    Function onPressed,
    EdgeInsetsGeometry padding,

    /// A widget to be displayed instead of the button text. Does not work together with buttonText
    Widget buttonWidget,
    ButtonStyle buttonStyle}) {
  return PlatformWidget(
    material: (context, platform) => ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return buttonColor;
              }),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding))
          .merge(buttonStyle),
      child: buttonWidget == null
          ? icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      buttonText,
                      style: TextStyle(
                          color: textColor != null
                              ? textColor
                              : colors.mainTextColor),
                    ),
                  ],
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                      color:
                          textColor != null ? textColor : colors.mainTextColor),
                )
          : buttonWidget,
    ),
    cupertino: (context, platform) => CupertinoButton(
      color: buttonColor,
      padding: padding,
      child: buttonWidget == null
          ? icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      buttonText,
                      style: TextStyle(
                          color: textColor != null
                              ? textColor
                              : colors.mainTextColor),
                    ),
                  ],
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                      color:
                          textColor != null ? textColor : colors.mainTextColor),
                )
          : buttonWidget,
      onPressed: onPressed,
    ),
  );
}

/// Form field template in the register page
Widget formField(
  BuildContext context,
  String label,
  bool isText, {
  String prefix,
  SignInSignUpFormBloc bloc,
  Function onChanged,
  String error,
  String currentText,
  bool obscureText,
  Widget suffixIcon,
}) {
  return Column(children: [
    Padding(
      padding: EdgeInsets.only(top: 10),
    ),
    PlatformTextField(
      material: (context, platform) => MaterialTextFieldData(
        readOnly: label == "DOB",
        obscureText: obscureText,
        keyboardType: isText ? TextInputType.text : TextInputType.phone,
        onTap: () async {
          if (label == "DOB") {
            final DateTime pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(DateTime.now().year - 18),
              firstDate: DateTime(1950),
              lastDate: DateTime(DateTime.now().year + -17),
            );
            if (pickedDate != null)
              bloc.changeDob(
                DateTimeUtils.getDayMonthYear(pickedDate),
              );
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          border: OutlineInputBorder(),
          labelText: label,
          errorText: error,
          hintText: currentText,
          prefixText: prefix ?? prefix,
          suffixIcon: suffixIcon ?? suffixIcon,
        ),
      ),
    ),
  ]);
}

void showSnackbar({
  /// Snackbar title
  @required message,

  /// Label shown at the end of snackbar
  @required label,

  /// The method that is excecuted when end label is tapped
  @required Function onPressed,

  /// Current page context
  @required BuildContext context,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(minutes: 2),
    action: SnackBarAction(
      label: label,
      onPressed: onPressed,
    ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

class SharedAppBar extends HookWidget implements PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(50);

  final Color backgroundColor;
  final Widget title;
  final List<Widget> actions;
  final Widget bottom;
  final bool centerTitle;

  /// Shared app bar across all scaffolds that require an appBar
  SharedAppBar(
      {this.backgroundColor,
      this.title,
      this.actions,
      this.bottom,
      this.centerTitle});
  @override
  Widget build(BuildContext context) {
    return PlatformAppBar(
      material: (context, platform) => MaterialAppBarData(
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: title,
        bottom: bottom,
        centerTitle: centerTitle,
      ),
    );
  }
}

class DrawerPopUpMenu extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final authenticationState = useProvider(authenticationProvider.state);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65 - 15, //20.0,
      child: Drawer(
        child: Container(
          color: context.read(colorProvider).mainBackgroundColor,
          child: new ListView(
            padding: EdgeInsets.zero,
            children: [
              // ignore: missing_required_param
              // DrawerHeader(
              //   child: Text("COMPAS"),
              //   decoration: BoxDecoration(
              //     color: context.read(colorProvider).appBarBackgroundColor,
              //   ),
              // ),
              DrawerHeader(
                child: Container(),
                decoration: BoxDecoration(
                  color: context.read(colorProvider).appBarBackgroundColor,
                  image: DecorationImage(
                    image: AssetImage("assets/images/COMPASeRevenue.png"),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                  size: 35,
                  color: context.read(colorProvider).appBarBackgroundColor,
                ),
                title: Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();

                  // Navigator.pushReplacement(
                  //   context,
                  //   platformPageRoute(
                  //     builder: (context) => HomePage(),
                  //     context: context,
                  //   ),
                  // );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_outline_outlined,
                  size: 35,
                  color: context.read(colorProvider).appBarBackgroundColor,
                ),
                title: Text("Profile"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    platformPageRoute(
                      builder: (context) => EditProfilePage(),
                      context: context,
                    ),
                  );
                },
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: ListTile(
                  leading: Icon(
                    Icons.sync_alt,
                    size: 35,
                    color: context.read(colorProvider).appBarBackgroundColor,
                  ),
                  title: Text("Log In/ Create Account"),
                  onTap: () {
                    context.read(authenticationProvider).logout(context);

                    Navigator.pushNamed(context, SIGNIN_SIGNUP_ROUTE);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// List tile template for the drawer layout
Widget drawerListTile(
    {BuildContext context,
    String imageUrl,
    String text,
    Function onTap,
    Widget trailing,
    bool isIos,

    /// Whether the button should be enabled or not
    @required bool enableButton,
    double scale}) {
  return ListTile(
    leading: Image.asset(imageUrl, scale: scale),
    title: Text(text,
        style: TextStyle(
            color: enableButton
                ? context.read(colorProvider).mainTextColor
                : Colors.grey)),
    onTap: () {
      if (enableButton) {
        if (!isIos) Navigator.of(context).pop();
        onTap();
      } else {
        // showToastMessage(context, "Log in to unlock this feature");
      }
    },
    trailing: trailing ?? SizedBox.shrink(),
  );
}

/// view receipts

Widget receipts(BuildContext context, GlobalAppColors colors) {
  return servicesContainer('assets/images/food.png', "Receipts", () {
    context.read(bottomNavigationStateProvider).state = 2;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route<dynamic> route) => false);
  }, colors);
}
