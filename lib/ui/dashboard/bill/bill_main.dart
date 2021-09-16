import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

class BillMainUI extends StatefulWidget {
  @override
  _BillMainUIState createState() => _BillMainUIState();
}

class _BillMainUIState extends State<BillMainUI> {
  TextEditingController transactPin;
  String headerText = 'Pay Bills',
      airtimeType = '', phoneNum='',
  bundle='100MB - N500 - 1 week',
  cableBundle = 'DStv Max - N500 - 1 Month',
      utilityBillType = '',
      utilityImg = '',
      amount, pin,
      userAccountNumber = '1019945039';
  List<String> airtimeProvider = ['Airtel', 'MTN', 'GLO', '9Mobile'];
  List<String> utilityBill = [
    'Eko Prepaid',
    'Eko Postpaid',
    'Ikeja Disco Prepaid',
    'Ibadan Power Disco',
    'Enegu Power Disco'
  ];
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  List<String> cableTv = ['DStv', 'GOtv', 'Startimes'];
  List<String> internetServices = ['Spectranet', 'Smile', 'Swift', 'ipNX'];
  bool isLoading = false;
  int currentView = 1;
  bool isEnabled = false;
  TextEditingController otpCode;
  bool showDataplan = false, showPhoneEdit = false;

  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

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

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 1) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 2) {
          //  isEnabled = true;
          currentView = 1;
          headerText = 'Pay Bills';
        } else if (currentView == 3) {
          isEnabled = false;
          headerText = 'Mobile Data';
          currentView = 2;
        }else if (currentView == 4) {
          isEnabled = false;
          headerText = 'Mobile Data';
          currentView = 3;
        } else if (currentView == 6) {
          isEnabled = false;
          headerText = 'Pay Bills';
          currentView = 5;
        } else if (currentView == 9) {
          isEnabled = false;
          headerText = 'Pay Bills';
          currentView = 1;
        } else if (currentView == 12) {
          isEnabled = false;
          headerText = 'Pay Bills';
          currentView = 1;
        } else if (currentView == 8) {
          isEnabled = false;
          currentView = 7;
        } else if (currentView == 5) {
          isEnabled = false;
         headerText = 'Pay Bills';
          currentView = 1;
        }
      });
      print('printght' + currentView.toString());
    }
  }

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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: kPrimaryColor,
                child: CustomAppBar(
                  onTap: () {
                    onBackPress();
                    // Navigator.pushReplacementNamed(
                    //     context, AppRouteName.DASHBOARD);
                  },
                  pageTitle: headerText,
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
                      Visibility(
                          visible: currentView == 1,
                          child: Column(
                            children: [
                              BillWidget(
                                size: size,
                                title: 'Cable TV',
                                leadingIcon: Icons.wifi,
                                onTap: () {
                                  setState(() {
                                    headerText='Cable Tv';
                                    currentView=5;
                                  });
                                  print('');
                                },
                              ),
                              BillWidget(
                                size: size,
                                title: 'Data',
                                leadingIcon: Icons.track_changes,
                                onTap: () {
                                  setState(() {
                                    currentView = 2;
                                    headerText = 'Mobile Data';
                                  });
                                  print('');
                                },
                              ),
                              BillWidget(
                                size: size,
                                title: 'Electricity',
                                leadingIcon: Icons.flash_on,
                                onTap: () {
                                  print('');
                                },
                              ),
                            ],
                          )),
                      Visibility(
                        visible: currentView == 2,
                        child: Column(
                          children: airtimeProvider
                              .asMap()
                              .entries
                              .map(
                                (e) => CustomAirtimeWidget(
                                  size: size,
                                  title: e.value,
                                  imgURL:
                                      'assets/f_svg/${e.value.toLowerCase()}.svg',
                                  onTap: () {
                                    print(e.value);
                                    setState(() {
                                      currentView = 3;
                                      airtimeType = e.value;
                                    });
                                  },
                                ),
                              )
                              .toList(),



                        ),
                      ),
                      Visibility(
                          visible: currentView == 3,
                          child: Column(
                            children: [
                              BuyingAirtimeCustomPlaceHolder(
                                  size: size, airtimeType: airtimeType),
                              SizedBox(
                                height: size.height * .03,
                              ),
                              RoundedInputField(
                                suffixIcon: InkResponse(onTap: (){
                                  print('select from contact');
                                },
                                child: Icon(Icons.contacts, size: 20,color: kPrimaryColor,),),
                                // onSaved: (newValue) => bvn = newValue,
                                onSaved: (newValue) => phoneNum = newValue,
                                inputType: TextInputType.text,
                                maxLen: 11,
                                labelText: 'Phone Number',
                                customTextHintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w600),
                                hintText: 'Phone Number',
                                autoCorrect: true,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(
                                        error: kPhoneNumberNullError);
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

                              SizedBox(height: size.height *0.03,),
                              RoundedInputField(
                                hasFocus: AlwaysDisabledFocusNode(),
                                suffixIcon: InkResponse(
                                  onTap: (){},
                                  child: Icon(Icons.arrow_drop_down_outlined , color: kPrimaryColor,
                                  size: 18,),
                                ),
                                inputType: TextInputType.text,
                                maxLen: 11,
                                labelText: 'Bundle',
                                customTextHintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w600),
                                hintText: bundle,
                                autoCorrect: true,
                              ),

                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              FormError(errors: errors),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              CustomSignInButton(
                                size: size,
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // if all are valid then go to success screen
                                    KeyboardUtil.hideKeyboard(context);
                                    // Navigator.pushReplacementNamed(
                                    //     context, AppRouteName.DASHBOARD);

                                    setState(() {
                                      currentView = 4;
                                    });
                                  }
                                },
                                btnTitle: 'Continue',
                              ),
                            ],
                          )),

                      Visibility(
                        visible: currentView == 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OTPTransaction(
                            size: size,
                            amount: cableBundle !=null ? 'N $bundle' : cableBundle ,
                            date: tfDate,
                            userAccount: userAccountNumber,
                            receipientNumber: phoneNum,
                            transactPin: transactPin,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Transaction is required";
                              } else if (value.length != 4) {
                                return "Transaction pin is to short";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                pin = value;
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
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                // if all are valid then go to success screen
                                KeyboardUtil.hideKeyboard(context);
                                Navigator.of(context).pushReplacementNamed(AppRouteName.SuccessPage);

                                // setState(() {
                                //   currentView = 2;
                                // });
                              }
                            },
                            cancelOnTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),

                      Visibility(
                          visible: currentView==5,
                          child: Column(
                            children: cableTv
                                .asMap()
                                .entries
                                .map(
                                  (e) => CustomAirtimeWidget(
                                    size: size,
                                    title: e.value,
                                    imgURL:
                                    'assets/f_svg/${e.value.toLowerCase()}.svg',
                                    onTap: () {
                                      print(e.value);
                                      setState(() {
                                       currentView = 6;
                                        airtimeType = e.value;
                                      });
                                    },
                                  ),
                            )
                                .toList(),
                          ),),

                      Visibility(
                          visible: currentView == 6,
                          child: Column(
                            children: [
                              BuyingAirtimeCustomPlaceHolder(
                                  size: size, airtimeType: airtimeType),
                              SizedBox(
                                height: size.height * .03,
                              ),
                              RoundedInputField(
                                onSaved: (newValue) => phoneNum = newValue,
                                inputType: TextInputType.text,
                                maxLen: 11,
                                labelText: 'Decoder Number',
                                customTextHintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w600),
                                hintText: 'Decoder Number',
                                autoCorrect: true,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(
                                        error: kPhoneNumberNullError);
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

                              SizedBox(height: size.height *0.03,),
                              UserProfileWidget(size: size ,
                              detail: 'Eric  Kelivn',),
                              SizedBox(height: size.height *0.09,),
                              RoundedInputField(
                                hasFocus: AlwaysDisabledFocusNode(),
                                suffixIcon: InkResponse(
                                  onTap: (){},
                                  child: Icon(Icons.arrow_drop_down_outlined , color: kPrimaryColor,
                                    size: 18,),
                                ),
                                inputType: TextInputType.text,
                                maxLen: 11,
                                labelText: 'Bundle',
                                customTextHintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.black54.withOpacity(0.3),
                                    fontWeight: FontWeight.w600),
                                hintText: cableBundle,
                                autoCorrect: true,
                              ),

                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              FormError(errors: errors),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              CustomSignInButton(
                                size: size,
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // if all are valid then go to success screen
                                    KeyboardUtil.hideKeyboard(context);
                                    // Navigator.pushReplacementNamed(
                                    //     context, AppRouteName.DASHBOARD);

                                    setState(() {
                                      currentView = 4;
                                    });
                                  }
                                },
                                btnTitle: 'Continue',
                              ),
                            ],
                          )),
                      
                      Visibility(
                          visible: currentView==7,
                          child: Column(children: [
                        
                      ],)),
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
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    Key key,
    @required this.size, this.detail,
  }) : super(key: key);

  final Size size;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: size.height *0.045,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(

          color: Colors.black.withOpacity(0.08),
        )
      ),
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
        Center(
          child: Text(detail, style: GoogleFonts.robotoMono(
            fontWeight: FontWeight.w300,
            fontSize: 10,
            color: Colors.black

          ),),
        ),
        
        Icon(Icons.check_circle_sharp, color: Colors.green,size: 14,)
      ],),
    );
  }
}
