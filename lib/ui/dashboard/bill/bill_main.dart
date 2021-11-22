import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/accountDetailsResp.dart';
import 'package:quickfund/data/model/billerByIdResp.dart';
import 'package:quickfund/data/model/billerDataBundle.dart';
import 'package:quickfund/data/model/listOfCategories.dart';
import 'package:quickfund/data/model/payBillResp.dart';
import 'package:quickfund/data/model/payBillsReq.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/billsProvider.dart';
import 'package:quickfund/ui/signup/account_opening/accountWidget.dart';
import 'package:quickfund/ui/transfer/transferAccountWidget.dart';
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
import 'package:quickfund/widget/responseMessage.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

import 'billWidget.dart';

class BillMainUI extends StatefulWidget {
  @override
  _BillMainUIState createState() => _BillMainUIState();
}

class _BillMainUIState extends State<BillMainUI> {
  List<CategoryData> billerCategory = [];
  List<CategoryByIdData> categoryById = [];
  String fieldName;
  List<BillerDataBundleDatum> billerDataBundleDatum = [];
  BillsProvider _billsProvider;
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  TextEditingController transactPin;
  TextEditingController otpCode;
  TextEditingController selectedAccountController = TextEditingController();
  TextEditingController selectBundleController = TextEditingController();
  TextEditingController invisibleAmount = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String headerText = 'Pay Bills',
      airtimeType = '',
      billerId = '',
      fromName,
      from,
      billerName,
      bundleName,
      categoryId,
      categoryName,
      customerId,
      billerDataPlanID,
      phoneNum = '',
      bundle,
      cableBundle = 'DStv Max - N500 - 1 Month',
      utilityBillType = '',
      utilityImg = '',
      amount,
      pin,
      responseData,
      userAccountNumber = '1019945039';
  List<String> utilityBill = [
    'Eko Prepaid',
    'Eko Postpaid',
    'Ikeja Disco Prepaid',
    'Ibadan Power Disco',
    'Enugu Power Disco'
  ];
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  List<String> cableTv = ['DStv', 'GOtv', 'Startimes'];
  bool isLoading = false;
  int currentView = 1;
  bool isEnabled = false, isAmountZero = false;
  bool showDataplan = false, showPhoneEdit = false;
  List<AccountDatum> accountDetails=[];

  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  getAccountDetails(AuthProvider authProvider) {
    try {
      if (authProvider.accountDetails != null) {
        accountDetails = authProvider.accountDetails;
        print('accountDetails: $accountDetails');
      }
    } catch (e) {
      print('e: $e');
    }
  }

  Future<String> openContactBook() async {
    Contact contact = await ContactPicker().selectContact();
    try {
      if (contact != null) {
        var phoneNumber = contact.phoneNumber.number
            .toString()
            .replaceAll(new RegExp(r"\s+"), "");
        return phoneNumber;
      } else {
        return '';
      }
    } catch (e) {
      return e.toString();
    }
    return "";
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

  Future<dynamic> buildShowModalBottomSheetForUserTitle(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        builder: (context) {
          // final postMdl = Provider.of<BankProvider>(context);
          return WillPopScope(
            onWillPop: () async {
              // listener dismiss
              return true;
            },
            child: CustomBottomSheetMenuItem(
              customWidget: Column(
                children: [
                  CustomDetails(
                    heading: 'List of Bundle',
                    // onTap: () {
                    //   Navigator.of(context).pop();
                    // },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                      child: ListView(
                    children: billerDataBundleDatum
                        .asMap()
                        .entries
                        .map((e) => CustomDataWidget(
                              title: e.value.name,
                              amountLabel: e.value.amount == 0
                                  ? ''
                                  : '₦ ${e.value.amount.toString()}',
                              onTap: () {
                                Navigator.of(context).pop();
                                if (e.value.amount == 0) {
                                  setState(() {
                                    categoryId = e.value.categoryId;
                                    bundle = e.value.id;
                                    billerName = e.value.billerName;
                                    bundleName = e.value.name;
                                    categoryName = e.value.categoryName;
                                    isAmountZero = true;
                                    selectBundleController.text =
                                    '${e.value.name}';
                                  });
                                }else{
                                  selectBundleController.text =
                                  '${e.value.name}         ₦${e.value.amount.toString()}';
                                  categoryId = e.value.categoryId;
                                  amount = e.value.amount.toString();
                                  bundle = e.value.id;
                                  billerName = e.value.billerName;
                                  bundleName = e.value.name;
                                  categoryName = e.value.categoryName;
                                }
                              },
                            ))
                        .toList(),
                  )),
                ],
              ),
            ),
          );
        });
  }

  onBackPress() {
    print("pret" + currentView.toString());
    if (currentView == 1) {
      isAmountZero=false;
      invisibleAmount.clear();
      phoneNumberController.clear();
      selectBundleController.clear();
      Navigator.of(context).pop();
    } else {
      setState(() {
        if (showDataplan) {
          isAmountZero=false;
          showDataplan = false;
        } else if (currentView == 2) {
          isAmountZero=false;
          phoneNumberController.clear();
          invisibleAmount.clear();
          selectBundleController.clear();
          currentView = 1;
          headerText = 'Pay Bills';
        } else if (currentView == 3) {
          isEnabled = false;
          isAmountZero=false;
          currentView = 2;
          phoneNumberController.clear();
          invisibleAmount.clear();
          selectBundleController.clear();
        } else if (currentView == 4) {
          isEnabled = false;
          currentView = 3;
        }
      });
      print('printght' + currentView.toString());
    }
  }

  Future<dynamic> buildShowModalBottomSheetForUserAccountSelect(
      BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: true,
        useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return AccountWidget(
            widgetIcon: Expanded(
              flex: 0,
              child:  Column(
                  children: accountDetails.asMap().entries.map((e) =>  AccountContainerwIDGET(
                    onTap:(){

                      selectedAccountController.text='${e.value.customerName.toUpperCase() } \nNGN ${e.value.accountBalance}';
                      setState(() {
                        from=e.value.accountNumber;
                        fromName=e.value.customerName;
                      });
                      Navigator.pop(context);
                    },
                    accountName: e.value.accountNumber.toUpperCase(),
                    accountNum: 'NGN ${e.value.accountBalance}',
                  )).toList()


              ),
            ),
          );
        });
  }


  void responseMessage(String message ,subtitle,lottleError , Color textColor ) {
    var size = MediaQuery
        .of(context)
        .size;
    showDialog(context: context,
        builder: (_) {
          return ResponseMessage(size: size,
            subtitle: subtitle,
            lotteError: lottleError,
            textColor: textColor,
            msgTitle: message.toUpperCase(),
          );
        }
    );
  }

  @override
  void initState() {
    final postMdl = Provider.of<BillsProvider>(context, listen: false);
    postMdl.getAllBillers();
    getUserDetails();
    super.initState();
  }
  @override
  void dispose() {
    selectBundleController.clear();
    phoneNumberController.clear();
    invisibleAmount.clear();
    super.dispose();
  }
  getUserDetails() async {
    fromName =
        await _sharedPreferenceQS.getSharedPrefs(String, 'customerName') ?? '';
    print('fromName: $fromName');
    from = await _sharedPreferenceQS.getSharedPrefs(String, 'accountNum') ?? '';
    print('from: $from');
  }

  Future<void> getDataByID(dataID) async {
    try {
      await _billsProvider.userBillsResult(dataID);
      final dataBundleByIdResp =
          CategoriesOfBillsById.fromJson(_billsProvider.billsPaysCodeResp);
      if (_billsProvider.billsPaysCodeResp != null) {
        print('data45 ${_billsProvider.billsPaysCodeResp.toString()}');
        if (dataBundleByIdResp.status == true &&
            dataBundleByIdResp.responsecode == 200) {
          setState(() {
            isLoading = false;
            responseData = dataBundleByIdResp.message;
            categoryById = dataBundleByIdResp.data;
            print('categoryById: $categoryById');
            currentView = 2;
          });
        } else {
          responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
      } else {
        responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print('Catch this $e');
      responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
    return null;
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
            isLoading = false;
            responseData = dataBundleByIdResp.message;
            billerDataBundleDatum = dataBundleByIdResp.data;
            print('categoryById: $billerDataBundleDatum');
            currentView = 3;
          });
        } else {
          responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
      } else {
        responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
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
          responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      responseMessage('Error', '$responseData', 'assets/76705-error-animation.json', Colors.red);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
  }

  parseBillerData(BillsProvider billsProvider) {
    try {
      if (billsProvider.billerCategory != null) {
        billerCategory = billsProvider.billerCategory;
      }
    } catch (e) {
      print('e: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Consumer2<BillsProvider, AuthProvider>(builder: (context, provider,authProvider, child) {
      _billsProvider = provider;
      parseBillerData(provider);
      getAccountDetails(authProvider);

      return LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kPrimaryColor,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
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
                        vertical: getProportionateScreenHeight(10),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Visibility(
                                visible: currentView == 1,
                                child: billerCategory == null ||
                                        billerCategory.isEmpty
                                    ? Center(
                                        child: SpinKitFadingCircle(
                                            size: 20,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                ),
                                              );
                                            }))
                                    : Column(
                                        children: billerCategory
                                            .asMap()
                                            .entries
                                            .map(
                                              (e) => BillWidget(
                                                size: size,
                                                title: e.value.name,
                                                leadingIcon: Icons.wifi,
                                                onTap: () {
                                                  setState(() {
                                                    billerId = e.value.id;
                                                    getDataByID(billerId);
                                                    headerText = e.value.name;
                                                  });
                                                  print('');
                                                },
                                              ),
                                            )
                                            .toList())),
                            Visibility(
                              visible: currentView == 2,
                              child: Column(
                                children: [
                                  Container(
                                    child:  categoryById.isEmpty || categoryById==null ? Container():Text(
                                      'Select your service provider',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  categoryById.isEmpty || categoryById==null ? NoActivity(
                                    tag:
                                    'OH No service provider At The Moment!',
                                  ): Column(
                                    children: categoryById
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => CustomAirtimeWidget(
                                            size: size,
                                            title: e.value.name,
                                            // imgURL:
                                            //     'assets/f_svg/${e.value.name.toLowerCase().trim()}.svg',
                                            imgURL: 'assets/f_png/avatar.png',
                                            onTap: () {
                                              print(e.value);
                                              setState(() {
                                                billerDataPlanID = e.value.id;
                                                fieldName=e.value.customerField1;
                                                getDataBundlePlanByID(
                                                    billerDataPlanID);
                                                // currentView = 3;
                                                //   airtimeType = e.value;
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
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
                                      readOnly: true,
                                      suffixIcon: Icon(Icons.keyboard_arrow_down, color: kPrimaryColor,),
                                      onTap: ()=>buildShowModalBottomSheetForUserAccountSelect(context, size),
                                      controller: selectedAccountController,
                                      inputType: TextInputType.number,
                                      labelText: 'User Account',
                                      autoCorrect: true,
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(
                                              error:
                                              'User Account is required');
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    RoundedInputField(
                                      controller: phoneNumberController,
                                      inputType: TextInputType.number,
                                      maxLen: 11,
                                      labelText: fieldName,
                                      autoCorrect: true,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          removeError(
                                              error: kSubscriberNullError);
                                        } else if (value.length >= 11) {
                                          removeError(error: kSubScriber);
                                        }
                                        return null;
                                      },
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(error: kSubScriber);
                                          return "";
                                        } else if (value.length < 11) {
                                          addError(error: kSubscriberNullError);
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    RoundedInputField(
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color: kPrimaryColor,
                                      ),
                                      controller: selectBundleController,
                                      onTap: () {
                                        buildShowModalBottomSheetForUserTitle(
                                            context, size);
                                      },
                                      readOnly: true,
                                      inputType: TextInputType.text,
                                      labelText: 'Select Subscription Bundle',
                                      autoCorrect: true,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          removeError(
                                              error: kPhoneNumberNullError);
                                        }
                                        return null;
                                      },
                                      validateForm: (value) {
                                        if (value.isEmpty) {
                                          addError(
                                              error: kPhoneNumberNullError);
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    Visibility(
                                      visible: isAmountZero,
                                      child: InvisibleAmount(
                                        invisibleAmount: invisibleAmount,

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
                                          KeyboardUtil.hideKeyboard(context);
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
                                  selectedBank: 'QuickFund MFB',
                                  size: size,
                                  amount:  'NGN ${invisibleAmount.text.isEmpty ? amount :invisibleAmount.text}',
                                  date: tfDate,
                                  userAccount: from,
                                  receipientNumber: phoneNumberController.text,
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
                                      KeyboardUtil.hideKeyboard(context);
                                      var payBillParams = PayBillsReq(
                                          accountName: fromName,
                                          accountNumber: from,
                                          customerId:
                                              phoneNumberController.text,
                                          bundleName: bundleName,
                                          categoryId: categoryId,
                                          categoryName: categoryName,
                                          bundle: bundle,
                                          billerName: billerName,
                                          billerId: billerId,
                                          amount: invisibleAmount.text.isEmpty ? amount :invisibleAmount.text,
                                          pin: pin);
                                      payBill(payBillParams, provider);
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

