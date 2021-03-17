import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/res/colors.dart';
import 'package:e_revenue_flutter/res/text_styles.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/bills/bills.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/bussiness/bussiness.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/food/food.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/land/land.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/parking/parking.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/rents/rents.dart';
import 'package:e_revenue_flutter/screens/dashboard_page/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:e_revenue_flutter/util/presentation/global_widgets.dart';

class HomeWidget extends HookWidget {
  final refreshKey;

  HomeWidget(
    this.refreshKey,
  );

  @override
  Widget build(BuildContext context) {
    final colors = useProvider(colorProvider);

    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: colors.appBarBackgroundColor,
        ),
        drawer: DrawerPopUpMenu(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // context.read(reloadHomeChangeProvider).state =
          //     !context.read(reloadHomeChangeProvider).state;
        },
        key: refreshKey,
        child: CustomScrollView(
          key: Key("customScrollView"),
          slivers: [
            PlatformWidget(
              cupertino: (context, platform) => CupertinoSliverNavigationBar(
                key: Key("cupertinoNavBar"),
                largeTitle: Text("M-gari"),
                transitionBetweenRoutes: false,
                backgroundColor: colors.mainButtonsColor,
                border: null,
                trailing: CupertinoButton(
                  child: Icon(
                    CupertinoIcons.bars,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   platformPageRoute(
                    //       builder: (context) => DrawerPageIos("Home"),
                    //       context: context),
                    // );
                  },
                ),
              ),
              material: (context, platform) => SliverToBoxAdapter(
                child: SizedBox.shrink(),
              ),
            ),
            SliverAppBar(
              key: Key("sliverAppBar2"),
              floating: true,
              expandedHeight: 230,
              elevation: 0,
              automaticallyImplyLeading: false,
              textTheme: colors.textTheme,
              excludeHeaderSemantics: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(-20),
                  bottomRight: Radius.circular(-20),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: EdgeInsets.only(
                    top: 38.0, left: 10, right: 10, bottom: 8.0),
                background: Container(
                  color: eRevenueRed,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hello, User",
                                  style: TextStyle(
                                      color: colors.secondaryTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: [
                              Text(
                                "Services",
                                style: serviceshead,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Container(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              servicesContainer(
                                  'assets/images/bill.png', "Bills", () {
                                Navigator.push(
                                  context,
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) => BillsWidget(),
                                  ),
                                );
                              }, colors),
                              servicesContainer(
                                  'assets/images/parking.png', "Parking", () {
                                Navigator.push(
                                  context,
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) => ParkingWidget(),
                                  ),
                                );
                              }, colors),
                              servicesContainer(
                                  'assets/images/land.png', "Land Rates", () {
                                Navigator.push(
                                  context,
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) => LandWidget(),
                                  ),
                                );
                              }, colors),
                              servicesContainer(
                                  'assets/images/food.png', "Food Handlers",
                                  () {
                                Navigator.push(
                                  context,
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) => FoodWidget(),
                                  ),
                                );
                              }, colors),
                              servicesContainer(
                                  'assets/images/investment.png', "Business",
                                  () {
                                Navigator.push(
                                  context,
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) => BussinessWidget(),
                                  ),
                                );
                              }, colors),
                              servicesContainer(
                                  'assets/images/rent.png', "Rents", () {
                                Navigator.push(
                                  context,
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) => RentWidget(),
                                  ),
                                );
                              }, colors),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 20, left: 10),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History",
                        style: transactionhead.copyWith(
                          color: colors.mainTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text("See All"),
                          Icon(Icons.arrow_forward),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        // ignore: todo
                        // TODO add the transactions here
                        Center(
                          child: Text('No Transactions Available'),
                        )

                        // ListView.builder(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: 20,
                        //     itemBuilder: (context, index) {
                        //       return Center(
                        //         child: Text('No Transactions Available'),
                        //       );
                        //       // buildTransactinHistory();
                        //     })
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServicesWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final authenticationState = useProvider(authenticationProvider.state);
    final _colors = useProvider(colorProvider);

    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(
        backgroundColor: _colors.mainBackgroundColor,
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          middle: Text("Hub"),
        ),
      ),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: _colors.appBarBackgroundColor,
          title: Text("Services"),
        ),
        drawer: DrawerPopUpMenu(),
      ),
      body: SafeArea(
        child: SizedBox(
          child: Container(
            color: context.read(colorProvider).mainBackgroundColor,
            child: Material(
              child: Column(
                children: [
                  // ignore: missing_required_param
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 4, top: 30, bottom: 30),
                      width: MediaQuery.of(context).size.width,
                      child: Text("Select your preferred service"),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.local_parking_outlined,
                      size: 35,
                      color: context.read(colorProvider).appBarBackgroundColor,
                    ),
                    title: Text("Parking"),
                    onTap: () {
                      // Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   platformPageRoute(
                      //     builder: (context) => HomePage(),
                      //     context: context,
                      //   ),
                      // );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.business_center_sharp,
                      size: 35,
                      color: context.read(colorProvider).appBarBackgroundColor,
                    ),
                    title: Text("Business"),
                    onTap: () {
                      // Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   platformPageRoute(
                      //     builder: (context) => HomePage(),
                      //     context: context,
                      //   ),
                      // );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.vpn_key_sharp,
                      size: 35,
                      color: context.read(colorProvider).appBarBackgroundColor,
                    ),
                    title: Text("Rents"),
                    onTap: () {
                      // Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   platformPageRoute(
                      //     builder: (context) => HomePage(),
                      //     context: context,
                      //   ),
                      // );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      size: 35,
                      color: context.read(colorProvider).appBarBackgroundColor,
                    ),
                    title: Text("Land Rates"),
                    onTap: () {
                      // Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   platformPageRoute(
                      //     builder: (context) => HomePage(),
                      //     context: context,
                      //   ),
                      // );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.receipt,
                      size: 35,
                      color: context.read(colorProvider).appBarBackgroundColor,
                    ),
                    title: Text("Bills"),
                    onTap: () {
                      // Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   platformPageRoute(
                      //     builder: (context) => HomePage(),
                      //     context: context,
                      //   ),
                      // );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.nature_people,
                      size: 35,
                      color: context.read(colorProvider).appBarBackgroundColor,
                    ),
                    title: Text("Food Handlers"),
                    onTap: () {
                      // Navigator.of(context).pop();

                      // Navigator.pushReplacement(
                      //   context,
                      //   platformPageRoute(
                      //     builder: (context) => HomePage(),
                      //     context: context,
                      //   ),
                      // );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AssetsWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _colors = useProvider(colorProvider);
    final tabController = useTabController(initialLength: 5);
    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: _colors.appBarBackgroundColor,
          title: Text("My Assets"),
        ),
        drawer: DrawerPopUpMenu(),
      ),
      body: Column(
        children: [
          PlatformTextField(
            material: (context, platform) => MaterialTextFieldData(
              decoration: InputDecoration(
                hintText: "Search by Number Plate, Business ID, etc",
                prefixIcon: Icon(Icons.search_outlined),
              ),
            ),
          ),
          TabBar(
              labelColor: _colors.mainTextColor,
              controller: tabController,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Cars"),
                Tab(text: "Business"),
                Tab(text: "Houses"),
                Tab(text: "Stalls"),
              ]),
          Expanded(
              child: TabBarView(controller: tabController, children: [
            Center(child: Text("No assets found")),
            Center(child: Text("No assets found")),
            Center(child: Text("No assets found")),
            Center(child: Text("No assets found")),
            Center(child: Text("No assets found")),
          ]))
        ],
      ),
    );
  }
}

class HistoryWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _colors = useProvider(colorProvider);
    return PlatformScaffold(
      cupertino: (context, platform) => CupertinoPageScaffoldData(),
      material: (context, platform) => MaterialScaffoldData(
        appBar: SharedAppBar(
          backgroundColor: _colors.appBarBackgroundColor,
          title: Text("Transaction History"),
        ),
        drawer: DrawerPopUpMenu(),
      ),
      body: Center(child: Text("No transaction history")),
    );
  }
}
