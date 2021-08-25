import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';


class WelcomeQuickFund extends StatefulWidget {
  //static String routeName = "/welcomeQuickFund";

  @override
  _WelcomeQuickFundState createState() => _WelcomeQuickFundState();
}

class _WelcomeQuickFundState extends State<WelcomeQuickFund> {
  Timer _timer;

  void splashTimer(){
    _timer =  Timer(Duration(seconds: 2),  ()=> navigateToNextUI());
  }


  void navigateToNextUI() async {
      Navigator.of(context).pushReplacementNamed(AppRouteName.onboardingmain);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 2),  ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingUI())));
    //  // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body:       SafeArea(
        child: Column(
          children: [

            Spacer(
              flex: 1,
            ),
            Center(child: SvgPicture.asset('assets/f_svg/quickfund.svg')),

            Spacer(
              flex: 1,
            ),

            Text('Welcome to QuickfundFMB', style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
                color: Colors.white
            ),),

            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}