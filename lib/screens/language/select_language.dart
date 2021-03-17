
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/languages_provider.dart';
import 'package:e_revenue_flutter/res/values.dart';
import 'package:e_revenue_flutter/screens/signin_signup_page/signin_signup.dart';
import 'package:e_revenue_flutter/util/bezierContainer.dart';
import 'package:e_revenue_flutter/util/global_widgets.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final languageValue = useProvider(languageStateProvider).state;
    // ignore: unused_local_variable
    String languageList = useProvider(languageStateProvider).state;

    final height = MediaQuery.of(context).size.height;

    final _colors = useProvider(colorProvider);
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
                    SizedBox(height: height * .15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: titleLogo(2.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.12),
                      child: Column(
                        children: [
                          Text('Select Your Language'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8.0),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: PlatformWidget(
                                material: (context, platform) =>
                                    DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text('Select Language '),
                                    value: languageValue,
                                    onChanged: (newValue) {
                                      context
                                          .read(languageStateProvider)
                                          .state = newValue;
                                      languageList = newValue;
                                    },
                                    isExpanded: true,
                                    items:
                                        languages.map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                cupertino: (context, platform) =>
                                    CupertinoButton(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(languageValue),
                                        Icon(CupertinoIcons.chevron_down)
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    await showCupertinoModalPopup(
                                        context: context,
                                        builder: (_) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child: CupertinoPicker(
                                              backgroundColor:
                                                  CupertinoColors.white,
                                              itemExtent: 40,
                                              onSelectedItemChanged:
                                                  (newValue) {
                                                context
                                                    .read(languageStateProvider)
                                                    .state = languages[newValue];
                                                languageList =
                                                    languages[newValue];
                                              },
                                              children: [
                                                for (var va in languages) ...[
                                                  Center(child: Text(va))
                                                ]
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    getRaisedButton(
                      // buttonColor: _colors.mainButtonsColor,
                      buttonColor: Colors.red,
                      // colors: _colors,
                      textColor: _colors.secondaryTextColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      buttonText: "Next",
                      onPressed: () {
                        saveLanguage(languageList);
                        Navigator.push(
                          context,
                          platformPageRoute(
                            context: context,
                            builder: (context) => SignupSignInForm(),
                          ),
                        );
                      },
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

void saveLanguage(String categoryList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('languageSelected', categoryList);

}
