import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_resend_otp.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class LoanMainUI extends StatefulWidget {
  @override
  _LoanMainUIState createState() => _LoanMainUIState();
}

class _LoanMainUIState extends State<LoanMainUI> {
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
                  Navigator.pushReplacementNamed(
                      context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Loan',
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
                      flex: 1,
                    ),
                    Column(
                      children: [
                        Text(
                          'No Active Loan',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                        ),

                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Icon(
                          Icons.trending_down_rounded,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        ResendOTP(
                          textI: "Need Money ? ",
                          textII: 'Get a Loan up to N1m and repay in 3 - 6 months.',
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRouteName.CategoriesOfLoanUI);
                          },
                        ),
                      ],
                    ),

                    Spacer(
                      flex: 6,
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
