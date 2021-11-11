import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/billerDataBundle.dart';
import 'package:quickfund/data/model/listOfAirtimeResp.dart';
import 'package:quickfund/data/model/payBillResp.dart';
import 'package:quickfund/data/model/payBillsReq.dart';
import 'package:quickfund/provider/billsProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

class AirtimeUI extends StatefulWidget {
  @override
  _AirtimeUIState createState() => _AirtimeUIState();
}

class _AirtimeUIState extends State<AirtimeUI> {
  int currentView = 0, selectedIndex;
  List<AirtimeData> airtimeData = [];
  List<BillerDataBundleDatum> billerDataBundleDatum = [];
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  BillsProvider _billsProvider;
  TextEditingController _amountController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController transactPin;
  bool showDataplan = false,
      showPhoneEdit = false,
      _btnEnabled = false,
      isLoading = false;
  String billerDataPlanID,
      categoryName,fromName,from,
      billerId,
      billerName,
      bundle,
      bundleName,
      categoryId,
      customerId,
      responseData,
      tfDate = DateFormat.yMMMd().format(DateTime.now());
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String initialAmount,
      phoneNum,
      amount,
      airtimeType,
      pin,
      userAccountNumber = '1019945039';
  String amountHere;

  @override
  void initState() {
    final postMdl = Provider.of<BillsProvider>(context, listen: false);
    postMdl.getAirtime();
    print(tfDate);
    getUserDetails();
    super.initState();
  }

  responseMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      padding: EdgeInsets.symmetric(vertical: 30),
      content: Text(
        message,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
    ));
  }

  parseBillerData(BillsProvider billsProvider) {
    try {
      if (billsProvider.airtimeData != null) {
        airtimeData = billsProvider.airtimeData;
      }
    } catch (e) {
      print('e: $e');
    }
  }

  Future<void> getDataBundlePlanByID(dataBundlePlanID) async {
    try {
      await _billsProvider.getBillerDataByCodeId(dataBundlePlanID);
      final dataBundleByIdResp =
          BillerDataBundle.fromJson(_billsProvider.getDataByCodeId);
      if (_billsProvider.getDataByCodeId != null) {
        print('data45 ${_billsProvider.getDataByCodeId.toString()}');
        if (dataBundleByIdResp.status == true &&
            dataBundleByIdResp.responsecode == 200) {
          setState(() {
            responseData = dataBundleByIdResp.message;
            billerDataBundleDatum = dataBundleByIdResp.data;
            print('categoryById: $billerDataBundleDatum');
            currentView = 1;
          });
        } else {
          responseMessage('$responseData', Colors.red);
        }
      } else {
        responseMessage('$responseData', Colors.red);
      }
    } catch (e) {
      print('Catch this $e');
      responseMessage('$responseData', Colors.red);
    }
    return null;
  }
  getUserDetails() async {
    fromName =
        await _sharedPreferenceQS.getSharedPrefs(String, 'customerName') ?? '';
    print('fromName: $fromName');
    from = await _sharedPreferenceQS.getSharedPrefs(String, 'accountNum') ?? '';
    print('from: $from');
  }
  void payBill(PayBillsReq payBillsReq, BillsProvider billsProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await billsProvider.payBills(payBillsReq);
      if (billsProvider.pay != null) {
        final changePinResp = PayBundleResp.fromJson(billsProvider.pay);
        if (changePinResp.status == true) {
          setState(() {
            isLoading = false;
          });
          responseData = changePinResp.message;
          print('responseMessage : $responseData');
          Navigator.of(context).pushReplacementNamed(AppRouteName.SuccessPage);
        } else {
          setState(() {
            isLoading = false;
          });
          responseData = changePinResp.message;
          print('responseMessage : $responseData');
          responseMessage('$responseData', Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('$responseData', Colors.red);
    }
  }

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 0) {
      // Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRouteName.DASHBOARD);
    } else {
      setState(() {
        if (showDataplan) {
          showDataplan = false;
        } else if (currentView == 1) {
          //  isEnabled = true;
          currentView = 0;
        } else if (currentView == 2) {
          // isEnabled = false;
          currentView = 1;
        }
      });
      print('printght' + currentView.toString());
    }
  }

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Consumer<BillsProvider>(builder: (context, provider, child) {
      _billsProvider = provider;
      parseBillerData(provider);

      return LoadingOverlay(
        isLoading: isLoading,
        child: WillPopScope(
          onWillPop: () {
            return onBackPress();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kPrimaryColor,
            body: Form(
              key: _formKey,
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: kPrimaryColor,
                    child: CustomAppBar(
                      onTap: () {
                        onBackPress();
                      },
                      pageTitle: 'Airtime',
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
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              Visibility(
                                visible: currentView == 0,
                                child: Column(
                                  children: [
                                    airtimeData.isEmpty || airtimeData == null
                                        ? Container()
                                        : Container(
                                            child: Text(
                                              'Select your service provider',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                          ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    airtimeData == null
                                        ? Center(
                                            child: SpinKitFadingCircle(
                                                size: 20,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                }))
                                        : airtimeData.isNotEmpty
                                            ? Column(
                                                children: airtimeData
                                                    .asMap()
                                                    .entries
                                                    .map(
                                                      (e) => CustomAirtimeWidget(
                                                        size: size,
                                                        title: e.value.name,
                                                        imgURL:
                                                            'assets/f_png/avatar.png',
                                                        onTap: () {
                                                          print(e.value);
                                                          setState(() {
                                                            airtimeType =
                                                                e.value.name;

                                                            billerDataPlanID =
                                                                e.value.id;
                                                          });
                                                          getDataBundlePlanByID(
                                                              billerDataPlanID);
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                              )
                                            : NoActivity(
                                                tag:
                                                    'OH No Airtime Plan At the Moment!',
                                              ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: currentView == 1,
                                child: Column(
                                  children: [
                                    BuyingAirtimeCustomPlaceHolder(
                                        size: size, airtimeType: airtimeType),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    RoundedInputField(
                                      controller: phoneNumberController,
                                      // onSaved: (newValue) => bvn = newValue,
                                      onSaved: (newValue) => phoneNum = newValue,
                                      inputType: TextInputType.number,
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
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    RoundedInputField(
                                      controller: _amountController,
                                      inputType: TextInputType.number,
                                      labelText: 'Amount',
                                      hintText: 'Amount',
                                      autoCorrect: true,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          removeError(error: kAmount);
                                        }
                                        return null;
                                      },
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(error: kAmount);
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    SelectAmountWidget(),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        children: billerDataBundleDatum
                                            .asMap()
                                            .entries
                                            .map(
                                              (e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7.0, bottom: 8),
                                                child:e.value.amount==0 ?Container(): GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = e.key;
                                                      billerId = e.value.billerId;
                                                      billerName = e.value.name;
                                                      _amountController.text =
                                                          '${e.value.amount}';
                                                      categoryId =
                                                          e.value.categoryId;
                                                      bundle = e.value.id;
                                                      billerName =
                                                          e.value.billerName;
                                                      bundleName = e.value.name;
                                                      categoryName =
                                                          e.value.categoryName;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: size.width * 0.143,
                                                    height: size.height * 0.04,
                                                    decoration: selectedIndex ==
                                                            e.key
                                                        ? BoxDecoration(
                                                            color: kPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                          )
                                                        : BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8),
                                                            border: Border.all(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        0.2))),
                                                    child: e.value.amount ==0 ?Container(): Center(
                                                      child: Text(
                                                        'NGN ${e.value.amount.toString()}',
                                                        style: GoogleFonts.robotoMono(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color:
                                                                selectedIndex ==
                                                                        e.key
                                                                    ? Colors.white
                                                                    : Colors
                                                                        .black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
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
                                            currentView = 2;
                                          });
                                        }
                                      },
                                      btnTitle: 'Continue',
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: currentView == 2,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: OTPTransaction(
                                    size: size,
                                    amount: 'N ${_amountController.text}',
                                    date: tfDate,
                                    selectedBank: 'QuickMFB',
                                    userAccount: from,
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
                                        // Navigator.of(context)
                                        //     .pushReplacementNamed(
                                        //     AppRouteName.SuccessPage);
                                        var payBillParams = PayBillsReq(
                                            customerId:
                                                phoneNumberController.text,
                                            bundleName: bundleName,
                                            categoryId: categoryId,
                                            categoryName: categoryName,
                                            bundle: bundle,
                                            billerName: billerName,
                                            billerId: billerId,
                                            amount: _amountController.text,
                                            pin: pin);
                                        payBill(payBillParams, provider);

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
                            ],
                          ),
                        ),
                      )),
                )
              ]),
            ),
          ),
        ),
      );
    });
  }
}
