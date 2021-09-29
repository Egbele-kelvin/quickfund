import 'package:flutter/material.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:share/share.dart';

class SettingsMainUI extends StatefulWidget {
  const SettingsMainUI({Key key}) : super(key: key);

  @override
  _SettingsMainUIState createState() => _SettingsMainUIState();
}

class _SettingsMainUIState extends State<SettingsMainUI> {
  final String _content =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum diam ipsum, lobortis quis ultricies non, lacinia at justo.';

  void _shareContent() {
    Share.share(_content);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            //color: kPrimaryColor,
            child: CustomAppBar(
              onTap: () {
                //onBackPress();
                Navigator.pushReplacementNamed(context, AppRouteName.DASHBOARD);
              },
              pageTitle: 'Settings',
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
                horizontal: getProportionateScreenWidth(20.0),
                vertical: getProportionateScreenHeight(10.0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Expanded(
                    flex: 10,
                    child: CustomScrollView(slivers: [
                      SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: [
                              Visibility(
                                child: Column(
                                  children: [
                                    GetHelp_widget(
                                      size: size,
                                      title: 'Change Pin',
                                      leadingIcon: Icons.lock_open,
                                      onTap: () {
                                        print('');
                                      },
                                    ),
                                    GetHelp_widget(
                                      size: size,
                                      title: 'Change Transaction Pin',
                                      leadingIcon: Icons.lock,
                                      onTap: () {
                                        print('');
                                      },
                                    ),
                                    GetHelp_widget(
                                      size: size,
                                      title: 'Reset Transaction Pin',
                                      leadingIcon: Icons.cached,
                                      onTap: () {
                                        print('');
                                      },
                                    ),
                                    GetHelp_widget(
                                      size: size,
                                      title: 'Reset Question & Answer',
                                      leadingIcon: Icons.cached,
                                      onTap: () {
                                        print('');
                                      },
                                    ),
                                    GetHelp_widget(
                                      size: size,
                                      title: 'Share This APP',
                                      leadingIcon: Icons.share,
                                      onTap: () {
                                        _shareContent();
                                        print('');
                                      },
                                    ),
                                    GetHelp_widget(
                                      size: size,
                                      title: 'Biometric',
                                      leadingIcon: Icons.fingerprint,
                                      onTap: () {
                                        print('');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
