import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' as device;
import 'package:provider/provider.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/billsProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/provider/securityQuestionProvider.dart';
import 'package:quickfund/provider/settingsProvider.dart';
import 'package:quickfund/provider/transferProvider.dart';
import 'package:quickfund/route.dart' as route;
import 'package:quickfund/theme.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/sharedPreference.dart';

import 'data/model/loginResp.dart';
import 'data/model/refreshTokenResp.dart';

void main() async {
  debugPaintSizeEnabled = false;
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
  final _navigatorKey = GlobalKey<NavigatorState>();
  Timer _timer, sessionTimer;
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 1200), _logOutUser);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    if (sessionTimer != null) {
      sessionTimer.cancel();
    }
    super.dispose();
  }

  void _initializeSessionTimer() {
    if (sessionTimer != null) {
      sessionTimer.cancel();
    }
    int duration = int.parse(LoginResp.fromJson(_authProvider.login)
            .data
            .token
            .expiresIn
            .toString()) ??
        30000;

    sessionTimer = Timer(Duration(seconds: duration), getRefreshToken);
  }

  void getRefreshToken() async {
    try {
      final loginResp = LoginResp.fromJson(_authProvider.login);
      await _authProvider.getRefreshAccess(loginResp.data.token.refreshToken);
      print('loginResp response1 ${loginResp..data.token.refreshToken}');
      if (_authProvider.refreshAccess != null) {
        print('resp ${_authProvider.refreshAccess}');
        final refreshAccess =
            RefreshTokenResp.fromJson(_authProvider.refreshAccess);

        print('refresh response ${_authProvider.refreshAccess}');
        if (refreshAccess.responsecode == 200 && refreshAccess.status == true) {
          print(refreshAccess.data.token);
          _sharedPreferenceQS.setData(
              'String', 'token', refreshAccess.data.token);
        }
      }
    } catch (e) {
      print('e $e');
    }
  }

  void _logOutUser() {
    _timer?.cancel();
    _timer = null;
    _navigatorKey.currentState
        .pushNamedAndRemoveUntil(AppRouteName.LOG_IN, (_) => false);
  }

  void _handleUserInteraction([_]) {
    _initializeTimer();
  }

  processAuthState(AuthProvider authProvider) {
    try {
      if (authProvider.hasSignedIn) {
        _initializeSessionTimer();
      }
    } catch (e) {
      print('e $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => SetupAccountViaBVNandViaPhoneProvider()),
          ChangeNotifierProvider(create: (context) => BillsProvider()),
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
          ChangeNotifierProvider(create: (context) => OtpProvider()),
          ChangeNotifierProvider(
              create: (context) => SecurityQuestionProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => TransferProvider()),
        ],
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          _authProvider = authProvider;
          processAuthState(authProvider);
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _handleUserInteraction,
            onPanDown: _handleUserInteraction,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme(),
              builder: (_, __) {
                return Navigator(
                  key: _navigatorKey,
                  initialRoute: AppRouteName.app,
                  onGenerateRoute: route.onGenerateRoute,
                );
              },
            ),
          );
        }));
  }
}
