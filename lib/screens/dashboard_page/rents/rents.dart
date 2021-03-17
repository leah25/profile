import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/services/services_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class RentWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colors = useProvider(colorProvider);
    final pageState = useProvider(rentPageProvider).state;

    print('state $pageState');
    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: colors.appBarBackgroundColor,
          title: Text("Rents"),
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
                  servicesContainer('assets/images/land.png', "House Rent", () {
                    context.read(rentPageProvider).state = 'house';
                  }, colors),
                  servicesContainer('assets/images/food.png', "Maket Stall",
                      () {
                    context.read(rentPageProvider).state = 'market';
                  }, colors),
                  receipts(context, colors)
                ],
              ),
            ),
            pageState == 'house'
                ? Container(
                    child: Text('House Rent'),
                  )
                : Container(
                    child: Text('Market Stall'),
                  )
          ],
        ),
      ),
    );
  }
}
