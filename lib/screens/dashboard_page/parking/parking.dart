import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/services/services_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class ParkingWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colors = useProvider(colorProvider);
    final pageState = useProvider(parkingPageProvider).state;

    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: colors.appBarBackgroundColor,
          title: Text("Parking"),
          centerTitle: true,
        ),
        endDrawer: DrawerPopUpMenu(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  servicesContainer('assets/images/parking.png', "Daily", () {
                    context.read(parkingPageProvider).state = 'daily';
                  }, colors),
                  servicesContainer('assets/images/land.png', "Seasonal", () {
                    context.read(parkingPageProvider).state = 'seasonal';
                  }, colors),
                  servicesContainer('assets/images/food.png', "OffStreet", () {
                    context.read(parkingPageProvider).state = 'offStreet';
                  }, colors),
                  servicesContainer('assets/images/investment.png', "Penalties",
                      () {
                    context.read(parkingPageProvider).state = 'penalties';
                  }, colors),
                  servicesContainer('assets/images/rent.png', "Status", () {
                    context.read(parkingPageProvider).state = 'status';
                  }, colors),
                  receipts(context, colors)
                ],
              ),
            ),
            pageState == 'daily'
                ? Container(
                    child: Text('Daily'),
                  )
                : pageState == 'seasonal'
                    ? Container(
                        child: Text('Seasonal'),
                      )
                    : pageState == 'offStreet'
                        ? Container(
                            child: Text('offStreet'),
                          )
                        : pageState == 'penalties'
                            ? Container(
                                child: Text('Penalties'),
                              )
                            : Container()
          ],
        ),
      ),
    );
  }
}
