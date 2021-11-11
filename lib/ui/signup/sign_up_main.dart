import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_selecet_menu.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class GetStartedUpdatedUI extends StatefulWidget {
  @override
  _GetStartedUpdatedUIState createState() => _GetStartedUpdatedUIState();
}

class _GetStartedUpdatedUIState extends State<GetStartedUpdatedUI> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              //color: kPrimaryColor,
              child: Column(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                //  Center(child: SvgPicture.asset('assets/f_svg/quickfund.svg')),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    'Welcome to Quickfund MFB',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Colors.white),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  CustomQuickFundSelectMenu(
                    size: size,
                    onTap: () {
                      print('open account page?');
                      Navigator.pushReplacementNamed(
                          context, AppRouteName.account_main);
                    },
                    title: 'Not a QFMB customer?',
                    subTitle: 'OPEN ACCOUNT',
                  ),
                  CustomQuickFundSelectMenu(
                    size: size,
                    onTap: () {
                      print('new user');
                      Navigator.pushReplacementNamed(
                          context, AppRouteName.RegisterUI);
                    },
                    title: 'New user?',
                    subTitle: 'register',
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  BuildHelp(
                    onTap: (){
                      Navigator.pushReplacementNamed(
                          context, AppRouteName.HelpUI);
                    },
                    helpText:  'NEED HELP ?',
                  ),
                  Spacer(
                    flex: 4,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

