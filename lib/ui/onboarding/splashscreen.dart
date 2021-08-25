import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  bool hasCompleteSplash = false;

  void splashTimer(){
   _timer =  Timer(Duration(seconds: 2),  ()=> hasRunApp());
  }


  void hasRunApp() async {
    final sharedPref = await SharedPreferences.getInstance();
    final hasRun = sharedPref.getBool(AppStrings.HAS_RUN) ?? false;
    if(hasRun) {
      hasLoggedIn();
      }else {
      sharedPref.setBool(AppStrings.HAS_RUN, true);
      Navigator.of(context).pushReplacementNamed(AppRouteName.welcome);
    }
  }

  void hasLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final hasLoggedIn = sharedPref.getBool(AppStrings.HAS_LOGGED_IN) ?? false;
    if(hasLoggedIn) {
      //TODO: perform log process here
      Navigator.of(context).pushNamed(AppRouteName.LOG_IN);
      //Navigator.of(context).pushNamed(AppRouteName.getStartedUpdatedUI);
    //  Navigator.of(context).pushNamed(AppRouteName.DASHBOARD);
    }else {

      sharedPref.setBool(AppStrings.HAS_LOGGED_IN, true);
      Navigator.of(context).pushNamed(AppRouteName.LOG_IN);
    }
  }


  performLoginProcess() async{
    final sharedPref = await SharedPreferences.getInstance();
    final email = sharedPref.getString(AppStrings.EMAIL) ?? '';
    final password = sharedPref.getString(AppStrings.PASSWORD) ?? '';
    final username = sharedPref.getString(AppStrings.USERNAME) ?? '';
    //Todo: call to sign in, once its successful you navigate user to dashboard else navigate to log in


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
    return Scaffold(
     body: Center(
       child: SpinKitThreeBounce(
         size: 100,
         itemBuilder: (BuildContext context, int index) {
           return DecoratedBox(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30),
               color: kPrimaryColor,
             ),
           );
         },
       ),
     ),
    );
  }
}


