import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/size_config.dart';

import 'custom_button.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10)),
            child: Column(children: [
              Spacer(
                flex: 2,
              ),
              Text(
                'Airtime Purchase',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Thank you for Purchase! The Phone Number 09079797975 has been credited with N 100 airtime.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              SvgPicture.asset(
                'assets/f_svg/check.svg',
                width: size.width * 0.2,
              ),
              SizedBox(
                height: size.height * 0.2,
              ),

              CustomSignInButton(
                size: size,
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(AppRouteName.DASHBOARD);
                },
                btnTitle: 'Done',
              ),
              Spacer(
                flex: 3,
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
