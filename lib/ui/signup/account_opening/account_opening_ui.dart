import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:toast/toast.dart';

class AccountOpeningUI extends StatefulWidget {
  @override
  _AccountOpeningUIState createState() => _AccountOpeningUIState();
}

class _AccountOpeningUIState extends State<AccountOpeningUI> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity,
    backgroundRadius:20.0 ,
    textColor:Colors.white60);
  }
  String accountNumber , phoneNumber,responseData;
  bool      isLoading = false;
  responseMessage(String message, Color color) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
      ),
      backgroundColor: color,
    ));
  }

  parseAuthData(SetupAccountViaBVNandViaPhone authProvider) {
    try {
      if (authProvider.createAccountUsingBvn != null) {
        final userData = CreateAccountBvnResp.fromJson(authProvider.createAccountUsingBvn);
        accountNumber = userData.data.accountNumber;
        phoneNumber= userData.data.user.phone;
        print(accountNumber);
        print(phoneNumber);
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  void verifyOtp(
      OtpReq otpReq, OtpProvider otpProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await otpProvider.otpVerificationForAll(otpReq);
      if (otpProvider.otpVerificate != null) {
        final otpResp =
        OtpResp.fromJson(otpProvider.otpVerificate);
        if (otpResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          Navigator.pushReplacementNamed(
              context, AppRouteName.ReviewDetails);
        }
        else{
          setState(() {
            isLoading=false;
          });
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('Server Auth Error', Colors.red);
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer2<SetupAccountViaBVNandViaPhone ,OtpProvider>(
  builder: (context, provider, otpProvider , child) {
    parseAuthData(provider);
  return Scaffold(
    key: scaffoldKey,
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
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text: accountNumber));

                        showToast('Account Number copied');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$accountNumber',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.1,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: size.width *0.1,
                          ),
                          Icon(
                            Icons.copy,
                            color: kPrimaryColor,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 7,
                    ),
                    CustomButton(
                      size: size,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRouteName.SecurityQuestionUI);
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
  },
);
  }
}
