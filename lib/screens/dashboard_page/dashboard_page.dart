import 'package:e_revenue_flutter/providers/dashboard/dashboard_tab_provider.dart';
import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class Dashboard extends HookWidget {
  final _pageOptions = [
    HomeWidget(
      Key("category.key"),
    ),
    AssetsWidget(),
    HistoryWidget(),
    ServicesWidget()
  ];
  @override
  Widget build(BuildContext context) {
    final _colors = useProvider(colorProvider);
    final currentTab = useProvider(bottomNavigationStateProvider).state;
    return PlatformScaffold(
      body: _pageOptions[currentTab],
     
      bottomNavBar: PlatformNavBar(
        backgroundColor: _colors.mainBackgroundColor,
        currentIndex: currentTab,
        itemChanged: (int index) {
          context.read(bottomNavigationStateProvider).state = index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color: _colors.mainIconsColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _colors.mainButtonsColor,
              ),
              // ignore: deprecated_member_use
              title: Text(
                "Home",
                style: TextStyle(
                    color: currentTab == 0
                        ? _colors.mainButtonsColor
                        : Colors.black),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.business,
                color: _colors.mainIconsColor,
              ),
              activeIcon: Icon(
                Icons.business,
                color: _colors.mainButtonsColor,
              ),
              // ignore: deprecated_member_use
              title: Text(
                "Assets",
                style: TextStyle(
                    color: currentTab == 1
                        ? _colors.mainButtonsColor
                        : Colors.black),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.access_time,
                color: _colors.mainIconsColor,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: _colors.mainButtonsColor,
              ),
              // ignore: deprecated_member_use
              title: Text(
                "History",
                style: TextStyle(
                    color: currentTab == 2
                        ? _colors.mainButtonsColor
                        : Colors.black),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: _colors.mainIconsColor,
              ),
              activeIcon: Icon(
                Icons.people,
                color: _colors.mainButtonsColor,
              ),
              // ignore: deprecated_member_use
              title: Text(
                "Services",
                style: TextStyle(
                    color: currentTab == 3
                        ? _colors.mainButtonsColor
                        : Colors.black),
              )),
        ],
      ),
    );
  }
}
