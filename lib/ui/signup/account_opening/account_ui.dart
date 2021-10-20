import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/initiateBvnReq.dart';
import 'package:quickfund/data/model/initiateBvnResp.dart';
import 'package:quickfund/data/model/verifyBvnReq.dart';
import 'package:quickfund/data/model/verifyBvnResp.dart';
import 'package:quickfund/data/network-service/networkServices.dart';
import 'package:quickfund/data/repository/repository.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AccountMain extends StatefulWidget {
  const AccountMain({Key key}) : super(key: key);

  @override
  _AccountMainState createState() => _AccountMainState();
}

class _AccountMainState extends State<AccountMain> {
  final _formKey = GlobalKey<FormState>();
  Repository repository = Repository(networkService: NetworkService());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController transactPin;
  String _pin, answerToSecurityQuestion , userPhoneNUmber='' ;
  String bvn = '', phoneNumber;
  int currentView = 0;
  bool checkUI, isLoading = false;
  bool showDataplan = false, showPhoneEdit = false;

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 2) {
          currentView = 1;
        }
      });
      print('printght' + currentView.toString());
    }
  }

  var initialIndex;
  String responseData = '';
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

  void initiateBvnReq(
      InitiateBvn initiateBvn, SetupAccountViaBVNandViaPhone authProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await authProvider.initiateBvn(initiateBvn);
      if (authProvider.initiateBvnR != null) {
        final initiateBvnResp =
            InitiateBvnResp.fromJson(authProvider.initiateBvnR);
        if (initiateBvnResp.status == true) {
          setState(() {
            userPhoneNUmber= initiateBvnResp.data.phone;
            isLoading = false;
          });
          responseData = initiateBvnResp.message;

          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          setState(() {
            currentView = 2;
          });
        }
        else{
          setState(() {
            isLoading=false;
          });
          responseData = initiateBvnResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('LoadingData: $isLoading');
        print('dataResp: ${authProvider.initiateBvnR.toString()}');

        responseMessage('$responseData', Colors.red);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('Server Auth Error', Colors.red);
    }
  }

  void verifyBvnOtp(
      VerifyBvn verifyBvn, SetupAccountViaBVNandViaPhone authProvider) async {
    setState(() {
      print('printing Loader');
      isLoading = true;
    });
    try {
      await authProvider.verifyBVNOtp(verifyBvn);
      if (authProvider.verifyBvnOtp != null) {
        final initiateBvnResp =
        VerifyBvnResp.fromJson(authProvider.verifyBvnOtp);
        if (initiateBvnResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = initiateBvnResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.green);
          Navigator.pushReplacementNamed(
              context, AppRouteName.ReviewDetails);
        }
        else{
          setState(() {
            isLoading=false;
          });
          responseData = initiateBvnResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('LoadingData: $isLoading');
        print('dataResp: ${authProvider.initiateBvnR.toString()}');

        responseMessage('$responseData', Colors.red);
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
    SizeConfig().init(context);
    return Consumer<SetupAccountViaBVNandViaPhone>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () {
            return onBackPress();
          },
          child: LoadingOverlay(
            isLoading: isLoading,
            child: Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: kPrimaryColor,
              body: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomAppBar(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        pageTitle: 'Account Opening',
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
                        //
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenHeight(10)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              currentView == 2
                                  ? Container()
                                  : Column(
                                      children: [
                                        Text(
                                          AppStrings.registerWithBvn,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11.5,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.05,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ToggleSwitch(
                                            minWidth: size.width * 0.43,
                                            minHeight: size.height * 0.08,
                                            cornerRadius: 30.0,
                                            fontSize: 12,
                                            inactiveFgColor: kPrimaryColor,
                                            activeBgColor: [
                                              kPrimaryColor,
                                            ],
                                            inactiveBgColor:
                                                Colors.grey.withOpacity(0.2),
                                            totalSwitches: 2,
                                            initialLabelIndex: currentView,
                                            changeOnTap: false,
                                            labels: [
                                              'Sign up with BVN',
                                              'with Phone Number'
                                            ],
                                            onToggle: (index) {
                                              setState(() {
                                                print('switch $index');
                                                currentView = index;
                                              });

                                              print('switched to: $index');
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.05,
                                        ),
                                      ],
                                    ),
                              Visibility(
                                visible: currentView == 0,
                                child: Column(
                                  children: [
                                    RoundedInputField(
                                      onSaved: (newValue) => bvn = newValue,
                                      inputType: TextInputType.number,
                                      maxLen: 11,
                                      labelText: 'BVN',
                                      customTextHintStyle: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color:
                                              Colors.black54.withOpacity(0.3),
                                          fontWeight: FontWeight.w600),
                                      hintText: 'Enter your BVN',
                                      autoCorrect: true,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          removeError(error: kBVNNullError);
                                        } else if (value.length >= 11) {
                                          removeError(error: kShortBVNError);
                                        }
                                        return null;
                                      },
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(error: kBVNNullError);
                                          return "";
                                        } else if (value.length < 11) {
                                          addError(error: kShortBVNError);
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                    Text(
                                      AppStrings.HAS_NO_BVN,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10.5,
                                        color: Colors.black,
                                      ),
                                    ),

                                    /// FormError(errors: errors),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: currentView == 1,
                                child: RoundedInputField(
                                  onSaved: (newValue) => phoneNumber = newValue,
                                  inputType: TextInputType.number,
                                  maxLen: 11,
                                  labelText: 'Phone Number',
                                  customTextHintStyle: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.3),
                                      fontWeight: FontWeight.w600),
                                  hintText: 'Enter your phone number',
                                  autoCorrect: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: kPhoneNumberNullError);
                                    } else if (value.length >= 11) {
                                      removeError(
                                          error: kShortPhoneNumberError);
                                    }
                                    return null;
                                  },
                                  validateForm: (value) {
                                    if (value.isEmpty) {
                                      addError(error: kPhoneNumberNullError);
                                      return "";
                                    } else if (value.length < 11) {
                                      addError(error: kShortPhoneNumberError);
                                      return "";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Visibility(
                                visible: currentView == 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0, vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Kindly enter the OTP sent to $userPhoneNUmber',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05),
                                      PinCodeTextField(
                                        controller: transactPin,
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.normal),
                                        obscureText: true,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        enableActiveFill: true,
                                        pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            fieldHeight: 45,
                                            selectedFillColor:
                                                Colors.grey.withOpacity(0.1),
                                            disabledColor: Colors.white,
                                            selectedColor: Colors.white,
                                            fieldWidth: 45,
                                            activeColor: kPrimaryColor,
                                            inactiveColor:
                                                Colors.grey.withOpacity(0.15),
                                            inactiveFillColor: Colors.white,
                                            activeFillColor: colorPrimaryWhite),
                                        length: 4,
                                        appContext: context,
                                        onChanged: (value) {
                                          setState(() {
                                            _pin = value;
                                          });
                                        },
                                        onCompleted: (value) async {
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FormError(errors: errors),
                              Spacer(
                                flex: 1,
                              ),
                              Spacer(
                                flex: 5,
                              ),
                              CustomButton(
                                size: size,
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // if all are valid then go to success screen
                                    KeyboardUtil.hideKeyboard(context);

                                    if (currentView == 1) {
                                    } else if (currentView == 2) {
                                      print('phoneNumber: $userPhoneNUmber');
                                      var verifyBVN= VerifyBvn(
                                        bvn: bvn,
                                        otp: _pin,
                                        phone: userPhoneNUmber
                                      );

                                      verifyBvnOtp(verifyBVN, provider);

                                    } else if (currentView == 0) {
                                      print('bvn : $bvn');
                                      var initiateBvnParams =InitiateBvn(bvn: bvn);

                                      initiateBvnReq(
                                          initiateBvnParams, provider);
                                      // Navigator.pushNamed(
                                      //     context, AppRouteName.ReviewDetails);
                                    }
                                  }
                                },
                                btnTitle: 'Continue'.toUpperCase(),
                              ),
                              Spacer(
                                flex: 7,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
