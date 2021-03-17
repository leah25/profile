import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/services/services_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class BillsWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colors = useProvider(colorProvider);
    final pageState = useProvider(billsPageProvider).state;

    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: colors.appBarBackgroundColor,
          title: Text("Bills"),
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
                  servicesContainer('assets/images/parking.png', "Pay Bills",
                      () {
                    context.read(billsPageProvider).state = 'pay';
                  }, colors),
                  servicesContainer('assets/images/land.png', "Receipts", () {
                    context.read(billsPageProvider).state = 'receipt';
                  }, colors),
                ],
              ),
            ),
            pageState == 'pay'
                ? Container(
                    child: Text('Pay Bills '),
                  )
                : Container(
                    child: Text('Receipts'),
                  )
          ],
        ),
      ),
    );
  }
}
