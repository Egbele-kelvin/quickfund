import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class FundAccountUI extends StatefulWidget {
  @override
  _FundAccountUIState createState() => _FundAccountUIState();
}

class _FundAccountUIState extends State<FundAccountUI> {
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
                pageTitle: 'Fund Your Account',
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
                      onTap: () {},
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
          ),
        ],
      ),
    );
  }
}

class FundAccountWidget extends StatelessWidget {
  const FundAccountWidget({
    Key key,
    @required this.size,
    this.onTap,
    this.title,
    this.subtitle,
    this.iconData,
  }) : super(key: key);

  final Size size;
  final Function onTap;
  final String title, subtitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size.height * 0.095,
          width: double.infinity,
          //padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.withOpacity(0.25),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: kShadowColor,
              radius: 20,
              child: Icon(
                iconData,
                size: 18,
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              title,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  color: Colors.black),
            ),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
