import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

import 'notificationWidget.dart';

class NotificationUI extends StatefulWidget {
  const NotificationUI({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<NotificationUI> {
  @override
  void initState() {
    super.initState();
  }

  List<String> notificationList = [
    'Browse other questions tagged',
    'Pending funds to my bitch',
    'We sail with the real soldiers',
    'Yoo don\'t fucking take the money',
    'jackie my hottie bitch , HAHAHA',
    'You know the drill, don\'t fucking dull',
    'Yoo bitch grab the fucking D*****',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  //color: kPrimaryColor,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: CustomAppBar(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    pageTitle: 'Notification',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: notificationList
                      .asMap()
                      .entries
                      .map((e) => NotificationCard(
                            size: size,
                            title: e.value,
                            subtitle:
                                'Daily inspiration collected from daily ui archive and beyond Hand picked, updating daily.',
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
