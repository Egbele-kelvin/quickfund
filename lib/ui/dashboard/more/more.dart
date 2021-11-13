import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:rating_dialog/rating_dialog.dart';

class More extends StatefulWidget {
  const More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  String selfie;
  @override
  void initState() {
    super.initState();
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rating QuickMFB',
      message: 'Rating this app and tell others what you think.'
          ' Add more description here if you want.',
      image: SvgPicture.asset(
        "assets/f_svg/quickfund.svg",
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => _ratingDialog,
        barrierColor: Colors.black.withOpacity(0.7));
  }

  void showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    String cancelActionText,
    @required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              FlatButton(
                child: Text(cancelActionText),
                textColor: Colors.blue,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            FlatButton(
                child: Text(defaultActionText),
                textColor: Colors.red,
                onPressed: () => Navigator.pushReplacementNamed(
                    context, AppRouteName.LOG_IN)),
          ],
        ),
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.red),
            child: Text(defaultActionText),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRouteName.LOG_IN),
          ),
        ],
      ),
    );
  }


  parseAuthData(AuthProvider setupAccountViaBVNandViaPhoneProvider) {
    try {
      if (setupAccountViaBVNandViaPhoneProvider.login != null) {
        final userData = LoginResp.fromJson(setupAccountViaBVNandViaPhoneProvider.login);
        setState(() {
          selfie = userData.data.user.selfie;
          print('selfie: $selfie');
        });
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
        builder: (context, provider, child)
    {
      parseAuthData(provider);
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
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  overflow: Overflow.visible,
                  clipBehavior: Clip.hardEdge,
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
                      imgURL: selfie == null
                          ? 'http://via.placeholder.com/640x360'
                          : '$selfie',
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
                          Navigator.pushNamed(
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
                      AccountSettingCardMenu(
                        size: size,
                        onTap: () {
                          print('click');
                        },
                        iconData: Icons.credit_card_sharp,
                        lable: 'Card Service',
                      ),
                      AccountSettingCardMenu(
                        size: size,
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRouteName.SettingsMainUI);
                          print('click');
                        },
                        iconData: Icons.settings,
                        lable: 'Setting',
                      ),
                      AccountSettingCardMenu(
                        size: size,
                        onTap: () {
                          print('click rate my App');
                          _showRatingAppDialog();
                        },
                        iconData: Icons.rate_review,
                        lable: 'Rate this App',
                      ),
                      AccountSettingCardMenu(
                        size: size,
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRouteName.BankStatement);
                          print('Bank Statement');
                          // _showRatingAppDialog();
                        },
                        iconData: Icons.description,
                        lable: 'Bank Statement',
                      ),
                      AccountSettingCardMenu(
                        size: size,
                        onTap: () =>
                            showAlertDialog(
                                content: 'Are you sure you want to log out?',
                                context: context,
                                defaultActionText: 'Yes',
                                cancelActionText: 'No',
                                title: '???'),
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
    });
  }
}
