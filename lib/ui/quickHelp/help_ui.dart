import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class HelpUI extends StatefulWidget {
  @override
  _HelpUIState createState() => _HelpUIState();
}

class _HelpUIState extends State<HelpUI> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
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
                  Navigator.of(context).pop();
                },
                pageTitle: 'Get Help',
              ),
            ),
          ),
          Expanded(
            flex: 9,
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
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenHeight(10)),
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(children: [
                            Spacer(
                              flex: 1,
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Information Guide',
                              leadingIcon: Icons.info_outline,
                              onTap: () {
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Forget Password',
                              leadingIcon: Icons.lock,
                              onTap: () {
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'Reset Secret Question & Answer',
                              leadingIcon: Icons.cached,
                              onTap: () {
                                print('');
                              },
                            ),
                            GetHelp_widget(
                              size: size,
                              title: 'FAQ',
                              leadingIcon: Icons.help_outline,
                              onTap: () {
                                print('');
                              },
                            ),GetHelp_widget(
                              size: size,
                              title: 'Contact Info',
                              leadingIcon: Icons.account_circle,
                              onTap: () {
                                print('');
                              },
                            ),GetHelp_widget(
                              size: size,
                              title: 'Send Feedback',
                              leadingIcon: Icons.message,
                              onTap: () {
                                print('');
                              },
                            ),
                            Spacer(
                              flex: 8,
                            )
                          ]),
                        ),
                      ],
                    ),
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
