import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' as device;
import 'package:quickfund/route.dart';
import 'package:quickfund/theme.dart';
import 'package:quickfund/util/app/app_route_name.dart';


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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: AppRouteName.app,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}