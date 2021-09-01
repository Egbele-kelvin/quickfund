import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/widget/custom_onboarding_btn.dart';

class GetStartedUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //SizeConfig().init(context);
    return  Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/f_png/bg-3.png'), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.height,
                color: Colors.black.withOpacity(0.78),
              ),
              Column(
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 200),
                    padding: EdgeInsets.only(left: 28, right: 36),
                    child: Text(
                      'Flexible and convenient repayment.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 90),
                    padding: EdgeInsets.only(left: 28, right: 36),
                    child: Text(
                      'Paying back loans are now easier than ever, with our flexible payment methods for everyone.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRouteName.getStartedUpdatedUI);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => GetStartedUpdatedUI()));
                      // Navigator.push(context, SlideTopRoute(page: GetStartedUpdatedUI()));
                    },
                    btnColor: kPrimaryColor,
                    btnName: 'Get Started',
                  ),
                  CustomButton(
                    btnColor: Colors.transparent,
                    btnName: 'Login',
                    onTap:() {
                  Navigator.of(context).pushReplacementNamed(AppRouteName.LOG_IN);
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
