import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/otpReq.dart';
import 'package:quickfund/data/model/otpResp.dart';
import 'package:quickfund/provider/otpProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class ActivateDevice extends StatefulWidget {
  final phoneNumber;
  final passWord;
  const ActivateDevice({Key key, this.phoneNumber, this.passWord}) : super(key: key);

  @override
  _ActivateDeviceState createState() => _ActivateDeviceState();
}

class _ActivateDeviceState extends State<ActivateDevice> {
  TextEditingController transactPin=TextEditingController();
  String _pin,responseData;
  bool isLoading=false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  void responseMessage(BuildContext context, String message , Color color) {
    Flushbar(
      margin: EdgeInsets.symmetric(vertical: 20),
      backgroundColor: color,
      message: message,
      leftBarIndicatorColor: Colors.grey,
      duration: Duration(seconds: 3),
    )..show(context);
  }
  OtpProvider otpProvider;
  @override
  void initState() {
    print('phoneNumber: ${widget.phoneNumber}');
    print('passWord: ${widget.passWord}');
    // TODO: implement initState
    super.initState();
  }
  void verifyOtp(
      OtpReq otpReq, otpProvider ) async {
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
          responseMessage(context ,'$responseData', Colors.green);
          Navigator.pushReplacementNamed(
              context, AppRouteName.SecurityQuestionUI);
        } else{
          setState(() {
            isLoading=false;
          });
          responseData = otpResp.message;
          print('responseMessage : $responseData');
          responseMessage(context ,'$responseData', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage(context ,'Server Auth Error', Colors.red);
    }
  }


  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    var verifyParams = OtpReq(phone: widget.phoneNumber);
    return Consumer<OtpProvider>(
        builder: (context, otp , child) {
          otpProvider=otp;
          //verifyOtp(verifyParams, otpProvider);
      //parseAuthData(otpProvider);
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 20 ),
      height: size.height*0.8,
      child: Column(
        children: [
          CustomDetails(
            heading: 'Activate Profile',
          ),
          SizedBox(
            height: size.height * 0.01,
          ),

          Column(
            children: [
              Text(
                'Enter OTP',
                style: GoogleFonts.roboto(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15),
                  child: OTPClassWidget(
                    transactPin: transactPin,
                    onChanged: (value) {
                      setState(() {
                        _pin = value;
                      });
                    },
                    onComplete: (value) async {
                      setState(() {
                        if (value.isEmpty) {
                          addError(error: kPinNullError);
                          return "";
                        } else if (value.length < 4) {
                          addError(error: kShortPinError);
                          return "";
                        }
                        return null;
                      });
                    },
                  )
              ),
            ],
          ),
        ],
      ),
    );
  });
  }
}
