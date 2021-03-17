import 'package:e_revenue_flutter/res/colors.dart';
import 'package:e_revenue_flutter/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget servicesContainer(
    String image, String name, Function onTap, GlobalAppColors colors) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        width: 90.0,
        decoration: BoxDecoration(
          color: lightGrey,
          border: Border.all(
            color: eRevenueDarkRed,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(
                image,
              ),
              size: 30,
              color: colors.mainButtonsColor,
            ),
            Text(
              name,
              style: dashServices,
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildTransactinHistory(
    ) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          // margin: EdgeInsets.only(top: 9, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "walletStatement",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'nunito',
                      ),
                    ),
                    Text(
                      '${"walletStatement"} kshs',
                      style: TextStyle(
                        // color: colors.mainButtonsColor,
                        fontSize: 13,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Text(
              //       DateTimeUtils.getFullDateTime(
              //                               DateTime.parse(walletStatement.timestamp)
              //                                   .toLocal()),
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Divider(thickness: 1),
      ],
    ),
  );
}

