import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/size_config.dart';

import 'custom_button.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacementNamed(AppRouteName.DASHBOARD);
    });
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10)),
            child: Column(children: [
              Spacer(
                flex: 2,
              ),
              Lottie.asset(
                  'assets/69013-successful-check.json' ,
                repeat: false,
                reverse: false,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'Transaction Successful',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black
                ),
              ),


              SizedBox(
                height: size.height * 0.2,
              ),
              Spacer(
                flex: 3,
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
