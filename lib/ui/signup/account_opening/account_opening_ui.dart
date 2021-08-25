import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class AccountOpeningUI extends StatefulWidget {
  @override
  _AccountOpeningUIState createState() => _AccountOpeningUIState();
}

class _AccountOpeningUIState extends State<AccountOpeningUI> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  //onBackPress();
                  Navigator.of(context).pop();
                },
                pageTitle: 'Account Opening',
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
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Column(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                     AppStrings.QUICKFUND_ACCOUNT_NUMBER_HEADER,
                      style: GoogleFonts.roboto(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '0142323939',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Icon(
                          Icons.copy,
                          color: kPrimaryColor,
                          size: 14,
                        )
                      ],
                    ),
                    Spacer(
                      flex: 7,
                    ),
                    CustomButton(
                      size: size,
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteName.SecurityQuestionUI);
                      },
                      btnTitle: 'Almost done',
                    ),

                    Spacer(flex: 6,),
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
