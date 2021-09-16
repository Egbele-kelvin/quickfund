import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class More extends StatefulWidget {
  const More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
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
      // backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: size.height * 0.6,
              child: Stack(
                children: [
                  Column(
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
                            //onBackPress();
                            Navigator.pushReplacementNamed(
                                context, AppRouteName.DASHBOARD);
                          },
                          pageTitle: 'Profile Settings',
                        ),
                      ),
                      HorizontalLineForAccountSetting(size: size),
                    ],
                  ),
                  AccountSettingProfile(
                    size: size,
                    imgURL: 'assets/f_png/businessman.png',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AccountSettingCardMenu(
                      size: size,
                      onTap: () {
                        print('click');
                        Navigator.popAndPushNamed(
                            context, AppRouteName.SaveBeneficiary);
                      },
                     iconData: Icons.swap_horiz_rounded,
                      lable: 'Beneficiary Management',
                    ),
                    AccountSettingCardMenu(
                      size: size,
                      onTap: () {
                        print('click');
                      },
                     iconData: Icons.account_circle,
                      lable: 'Contact Us',
                    ),
                    // AccountSettingCardMenu(
                    //   size: size,
                    //   onTap: () {
                    //     print('click');
                    //   },
                    //  imgURL: 'assets/f_svg/Icon-awesome-credit-card.svg',
                    //   lable: 'Card Service',
                    // ),
                    AccountSettingCardMenu(
                      size: size,
                      onTap: () {
                        print('click');
                      },
                      iconData: Icons.settings,
                      lable: 'Setting',
                    ),
                    AccountSettingCardMenu(
                      size: size,
                      onTap: () {
                        print('click');
                      },
                     iconData: Icons.rate_review,
                      lable: 'Rate this App',
                    ),
                    AccountSettingCardMenu(
                      size: size,
                      onTap: () {
                        print('click');
                        Navigator.pushReplacementNamed(
                            context, AppRouteName.LOG_IN);
                      },
                     iconData: Icons.power_settings_new,
                      lable: 'Logout',
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
