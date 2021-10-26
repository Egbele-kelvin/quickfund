import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' as device;
import 'package:provider/provider.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/route.dart';
import 'package:quickfund/theme.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/sharedPreference.dart';

import 'data/model/loginResp.dart';

void main() async {
  debugPaintSizeEnabled = false;
  //flutterbinding helps when running an async-await method in main method
  WidgetsFlutterBinding.ensureInitialized();

  await device.SystemChrome.setPreferredOrientations(
      [device.DeviceOrientation.portraitUp]);
  await device.SystemChrome.setEnabledSystemUIOverlays(
      [device.SystemUiOverlay.bottom]);
  await device.SystemChrome.setSystemUIOverlayStyle(
      device.SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  // Timer _timer, sessionTimer;
  // SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  // AuthProvider _authProvider;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initializeTimer();
  // }
  //
  // void _initializeTimer() {
  //   if (_timer != null) {
  //     _timer.cancel();
  //   }
  //   _timer = Timer(const Duration(seconds: 120), _logOutUser);
  // }
  //
  // @override
  // void dispose() {
  //   if (_timer != null) {
  //     _timer.cancel();
  //   }
  //   if (sessionTimer != null) {
  //     sessionTimer.cancel();
  //   }
  //   super.dispose();
  // }
  //
  // void _initializeSessionTimer() {
  //   if (sessionTimer != null) {
  //     sessionTimer.cancel();
  //   }
  //   int duration =int.parse(LoginResp.fromJson(_authProvider.login).data.token.expiresIn.toString()) ?? 600;
  //
  //   //sessionTimer = Timer(Duration(seconds: duration), getRefreshToken);
  // }

  // void getRefreshToken() async{
  //   try {
  //     final loginResp = LoginResp.fromJson(_authProvider.login);
  //     await _authProvider.getRefreshAccess(
  //         loginResp.data.token.refreshToken);
  //     print('loginResp response1 ${ loginResp..data.token.refreshToken}');
  //     if (_authProvider.refreshAccess != null) {
  //       print('resp ${_authProvider.refreshAccess}');
  //       final refreshAccess = RefreshTokenResp.fromJson(
  //           _authProvider.refreshAccess);
  //
  //       print('refresh response ${_authProvider.refreshAccess}');
  //       if (refreshAccess.responseCode == '00') {
  //         _sharedPreferenceQS.setData('String', 'token',
  //             refreshAccess.responseDetail.tokenParameters.accessToken);
  //       }
  //     }
  //   }catch(e){
  //     print('e $e');
  //   }
  // }
  //
  // void _logOutUser() {
  //   _timer?.cancel();
  //   _timer = null;
  //
  //   // Popping all routes and pushing welcome screen
  //   _navigatorKey.currentState
  //       .pushNamedAndRemoveUntil(AppRouteName.LOG_IN, (_) => false);
  //
  //   //  Navigator.popUntil(context, (route) => route.isFirst);
  // }
  //
  // void _handleUserInteraction([_]) {
  //   _initializeTimer();
  // }
  //
  // processAuthState(AuthProvider authProvider){
  //   try{
  //     if(authProvider.hasSignedIn){
  //       _initializeSessionTimer();
  //     }
  //   }catch(e){
  //     print('e $e');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ ChangeNotifierProvider(create: (context) => SetupAccountViaBVNandViaPhoneProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => SecurityQuestionProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: AppRouteName.app,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
      ),
    );
  }
}
