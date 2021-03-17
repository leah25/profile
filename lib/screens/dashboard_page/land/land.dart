import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/services/services_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class LandWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colors = useProvider(colorProvider);
    final pageState = useProvider(landPageProvider).state;

    print('state $pageState');
    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: colors.appBarBackgroundColor,
          title: Text("Land Rates"),
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
                  servicesContainer('assets/images/parking.png', "Pay LandRate",
                      () {
                    context.read(landPageProvider).state = 'payland';
                  }, colors),
                  receipts(context, colors)
                ],
              ),
            ),
            Container(
              child: Text('Pay Land Rate'),
            )
          ],
        ),
      ),
    );
  }
}
