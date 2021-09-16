

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

import 'cable.dart';
import 'cable_sucess.dart';

class CableMain extends StatefulWidget {
  @override
  _CableMainState createState() => _CableMainState();
}

class _CableMainState extends State<CableMain> {
  bool isVisible = false;
  bool focus = true;
  double opacityLevel = 0;
  String mainText = 'Choose a Subscription';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              //color: kPrimaryColor,
              child: CustomAppBar(
                onTap: () {
                  //onBackPress();
                  Navigator.pushReplacementNamed(
                      context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Cable Subscription',
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              //
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          'Choose Your Service Provider',
                          style: GoogleFonts.roboto(fontSize: 12,
                          fontWeight: FontWeight.w400 ,
                          color: Colors.black),
                        )),
                    SizedBox(height: size.height *0.02),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}