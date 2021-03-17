import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/providers/services/services_provider.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';

class BussinessWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final colors = useProvider(colorProvider);
    final pageState = useProvider(businessPageProvider).state;

    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: colors.appBarBackgroundColor,
          title: Text("Bussiness"),
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
                  servicesContainer('assets/images/parking.png', "Renew Permit",
                      () {
                    context.read(businessPageProvider).state = 'renew';
                  }, colors),
                  servicesContainer('assets/images/land.png', "Print Permit",
                      () {
                    context.read(businessPageProvider).state = 'Permit';
                  }, colors),
                  receipts(context, colors)
                ],
              ),
            ),
            pageState == 'renew'
                ? Container(
                    child: Text('Renew'),
                  )
                : pageState == 'Permit'
                    ? Container(
                        child: Text('Permit'),
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
