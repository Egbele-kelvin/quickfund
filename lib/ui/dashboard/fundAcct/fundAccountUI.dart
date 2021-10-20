import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/customFundWallet.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:toast/toast.dart';

class FundAccountUI extends StatefulWidget {
  @override
  _FundAccountUIState createState() => _FundAccountUIState();
}

class _FundAccountUIState extends State<FundAccountUI> {

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity,
        backgroundRadius:20.0 ,
        textColor:Colors.white60);
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child:   Container(
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
                 Navigator.pushNamed(context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Fund Account',
              ),
            ),
          ),
          Expanded(
            flex: 8,
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
                  Text(
                    AppStrings.QUICKFUNDYOURACCOUNT,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  FundAccountWidget(
                    size: size,
                    onTap: () {},
                    subtitle: 'QuickFundMB',
                    title: 'Bank',
                    iconData: Icons.account_balance,
                  ),
                  FundAccountWidget(
                    size: size,
                    copyIcon:Icons.copy,
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(
                          text: '870690696669'));

                      showToast('Account Number copied');
                    },
                    subtitle: '029199XXXXXX',
                    title: 'Account Number',
                    iconData: Icons.account_balance,
                  ),
                  FundAccountWidget(
                    size: size,
                    onTap: () {},
                    subtitle: 'Bose Oyelolu',
                    title: 'Beneficiaries',
                    iconData: Icons.account_circle,
                  ),
                  Spacer(
                    flex: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

