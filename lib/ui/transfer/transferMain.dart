import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/NameEnquiry.dart';
import 'package:quickfund/data/model/listOfBanks.dart';
import 'package:quickfund/data/model/nameEnquiryResp.dart';
import 'package:quickfund/data/model/saveBeneficiaryResp.dart';
import 'package:quickfund/data/model/transferFundsReq.dart';
import 'package:quickfund/data/model/transfersResp.dart';
import 'package:quickfund/provider/transferProvider.dart';
import 'package:quickfund/ui/signup/account_opening/accountOpeningWidget.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_search.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/form_error.dart';
import 'package:quickfund/widget/save_beneficiary_widget.dart';
import 'package:quickfund/widget/transactionPinUI.dart';

class TransferComponent extends StatefulWidget {
  const TransferComponent({Key key}) : super(key: key);

  @override
  _TransferComponentState createState() => _TransferComponentState();
}

class _TransferComponentState extends State<TransferComponent> {
  bool _isExpanded = false;
  TextEditingController accountNameData = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController accountNumData = TextEditingController();
  TextEditingController amountController = TextEditingController();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  TextEditingController transactPin;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  bool showDataplan = false,
      nameEnquiryLoading = false,
      isLoading = false,
      showPhoneEdit = false,
      isSaveToBeneficiary = false,
      isEnabled = true,
      isChecking = false;
  String bankName = 'Select Bank',
      amount,
      accountName,
      accountNum,
      toBvn,
      fromName,
      from,
      bankCode,
      note,
      isSessionId,
      toPhone = ' ',
      toAccountType = '',
      toKyc = ' ',
      userResultData,
      responseData = '';
  String initialAmount, pin;
  int currentView = 0;

  responseMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w400,
          fontSize: 11,
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
    ));
  }

  parseTransactionDataCheck(TransferProvider transferProvider) {
    try {
      if (transferProvider.saveBeneficiaryData != null) {
        saveBeneficiaryData = transferProvider.saveBeneficiaryData;
      }
    } catch (e) {
      print('e: $e');
    }
  }  parseBankCheck(TransferProvider transferProvider) {
    try {
      if (transferProvider.bankData != null) {
        bankData = transferProvider.bankData;
      }
    } catch (e) {
      print('e: $e');
    }
  }

  getUserDetails() async {
    fromName =
        await _sharedPreferenceQS.getSharedPrefs(String, 'customerName') ?? '';
    print('fromName: $fromName');
    from = await _sharedPreferenceQS.getSharedPrefs(String, 'accountNum') ?? '';
    print('from: $from');
  }

  void nameEnquiry(
      NameEnquiry nameEnquiry, TransferProvider transferProvider) async {
    setState(() {
      nameEnquiryLoading = true;
    });
    try {
      await transferProvider.nameEnquiry(nameEnquiry);
      if (transferProvider.enquiry != null) {
        final changePinResp =
            NameEnquiryResp.fromJson(transferProvider.enquiry);
        if (changePinResp.status == true) {
          setState(() {
            nameEnquiryLoading = false;
            isChecking = true;
            isEnabled = false;
          });
          userResultData = changePinResp.data.name;
          isSessionId = changePinResp.data.sessionId;
          toBvn = changePinResp.data.bvn;
          toKyc = changePinResp.data.kyc;

          print('responseMessage : $userResultData');
          fromName = await _sharedPreferenceQS.getSharedPrefs(
                  String, 'customerName') ??
              '';
          print('fromName: $fromName');
          from =
              await _sharedPreferenceQS.getSharedPrefs(String, 'accountNum') ??
                  '';
          print('from: $from');
        }
      } else {
        setState(() {
          nameEnquiryLoading = false;
        });
        print('responseMessage : $userResultData');
        responseMessage('$userResultData', Colors.red);
      }
    } catch (e) {
      setState(() {
        nameEnquiryLoading = false;
      });
      responseMessage('Server Auth Error', Colors.red);
    }
  }

  void filterSearchResults(String query) {
    final postMdl = Provider.of<TransferProvider>(context, listen: false);
    setState(() {
      if (query.isNotEmpty) {
        bankData =
            bankData = postMdl.bankData;
        print('filteredList: ${bankData.toList()}');
        bankData = bankData = postMdl.bankData
            .where((i) => i.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        bankData =
            bankData = postMdl.bankData;
      }
      print('filter ${bankData.toString()}');
    });
  }

  void transferFunds(
      TransferFunds transferFunds, TransferProvider transferProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await transferProvider.transferFunds(transferFunds);
      var changePinResp = TransferResp.fromJson(transferProvider.transfer);
      print('loginResp response $changePinResp');
      if (transferProvider.transfer != null) {
        if (changePinResp.status == true && changePinResp.responsecode == 200) {
          setState(() {
            isLoading = false;
            responseData = changePinResp.message;
          });
          print('responseMessage : $responseData');
          Navigator.of(context).pushReplacementNamed(AppRouteName.SuccessPage);
        } else {
          isLoading = false;
          print('responseData: $responseData');
          responseMessage('${changePinResp.message}', Colors.red);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('responseMessage : ${changePinResp.message}');
        responseMessage('${changePinResp.message}', Colors.red);
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

  Future<dynamic> buildShowModalBottomSheetForUserTitle(
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
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        builder: (context) {
          return Container(
            height: size.height*0.8,
            child: Column(
              children: [
                CustomDetails(
                  heading: 'List of Bank',
                  // onTap: () {
                  //   Navigator.of(context).pop();
                  // },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                bankData == null
                    ? Container(): Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                  child: SearchBoxWidget(
                    onChanged:(val)=>filterSearchResults(val),
                  ),
                ),
                Expanded(
                  child: bankData == null
                      ? Center(
                          child: SpinKitFadingCircle(
                              size: 20,
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                );
                              }))
                      : bankData.isNotEmpty
                          ? ListView(
                              children: bankData
                                  .asMap()
                                  .entries
                                  .map((e) => CustomItemWidget(
                                        onTap: () {
                                          setState(() {
                                            bankName = e.value.name;
                                            bankCode = e.value.code;
                                          });

                                          Navigator.of(context).pop();
                                        },
                                        descriptionItem: e.value.name,
                                      ))
                                  .toList(),
                            )
                          : NoActivity(),
                ),
              ],
            ),
          );
        });
  }

  List<BankData> bankData = [];
  List<SaveBeneficiaryData> saveBeneficiaryData = [];

  @override
  void initState() {
    final postMdl = Provider.of<TransferProvider>(context, listen: false);
    postMdl.getListOfBanks();
    postMdl.getAllSavedBeneficiary();
    getUserDetails();
    amountController = TextEditingController();
    amountController.addListener(() {
      final text = amountController.text.toLowerCase();
      if (text.isNotEmpty) {
        print(text.replaceAll('[,]', ''));
        amountController.value = amountController.value.copyWith(
          text: Money.from(num.parse(text.replaceAll(RegExp(r'[,]'), '')),
                  Currency.create('USD', 0))
              .format('#,###'),
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer<TransferProvider>(builder: (context, transferProv, child) {
      parseTransactionDataCheck(transferProv);
      parseBankCheck(transferProv);
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
                  flex: 2,
                  child: Container(
                    //color: kPrimaryColor,
                    child: CustomAppBar(
                      onTap: () {
                        // Navigator.pop(context);
                        onBackPress();
                        // Navigator.pushReplacementNamed(
                        //     context, AppRouteName.DASHBOARD);
                      },
                      pageTitle: 'Enter Transfer Details',
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
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
                        horizontal: getProportionateScreenWidth(10.0),
                        vertical: getProportionateScreenHeight(10.0),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Visibility(
                              visible: currentView == 0,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: saveBeneficiaryData==null ? Container(): saveBeneficiaryData.isNotEmpty  ? ChooseFromSavedBeneficiary(
                                        size: size,
                                        rowListForBeneficiary:
                                            saveBeneficiaryData
                                                .asMap()
                                                .entries
                                                .map((e) => Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: InkResponse(
                                                        onTap: () {
                                                          setState(() {
                                                            userResultData=e.value.name;
                                                            isSessionId=e.value.sessionId;
                                                            toKyc=e.value.kyc;
                                                            toPhone=e.value.phone;
                                                            toBvn=e.value.bvn;
                                                            bankName = e.value
                                                                .bankName;
                                                            bankCode = e.value
                                                                .bankCode;
                                                            accountNumData
                                                                    .text =
                                                                e.value
                                                                    .accountNumber;
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                                  kPrimaryColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Text(
                                                                '${e.value.firstname.substring(0, 1).toUpperCase()} ' +
                                                                    ' ${e.value.lastname.substring(0, 1).toUpperCase()}',
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.01,
                                                            ),
                                                            Text(
                                                              '${e.value.name} ',
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                                .toList()):Container(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(10.0),
                                      vertical:
                                          getProportionateScreenHeight(
                                              10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Column(children: [
                                          RoundedInputField(
                                            //maxLen: 7,
                                           // controller: amountController,
                                            // onSaved: (newValue) => bvn = newValue,
                                            onSaved: (newValue) =>
                                                amount = newValue,
                                            inputType: TextInputType.number,
                                            labelText: 'Amount',
                                            autoCorrect: true,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                removeError(
                                                    error:
                                                        'Amount is required');
                                              }
                                              return null;
                                            },

                                            validateForm: (value) {
                                              if (value.isEmpty) {
                                                addError(
                                                    error:
                                                        'Amount is required');
                                                return "";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          SelectedCustom(
                                            size: size,
                                            onTap: () {
                                              buildShowModalBottomSheetForUserTitle(
                                                  context, size);
                                            },
                                            title: bankName,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          RoundedInputField(
                                            isEnabled: isEnabled,
                                            controller: accountNumData,
                                            // onSaved: (newValue) => bvn = newValue,
                                            onSaved: (newValue) =>
                                                accountNum = newValue,
                                            inputType: TextInputType.number,
                                            maxLen: 11,
                                            labelText: 'Account Number',
                                            autoCorrect: true,
                                            onChanged: (value) {
                                              setState(() {
                                                accountNum = value;
                                              });
                                              if (value.isNotEmpty &&
                                                  value.length == 10) {
                                                removeError(
                                                    error:
                                                        'Account Number is Required');
                                                setState(() {
                                                  //nameEnquiryLoading = true;
                                                  isChecking = false;
                                                });
                                                var checkAccountParams =
                                                    NameEnquiry(
                                                        accountNumber:
                                                            value,
                                                        bankCode: bankCode);

                                                nameEnquiry(
                                                    checkAccountParams,
                                                    transferProv);
                                              } else if (value.isEmpty ||
                                                  value.length < 11) {
                                                setState(() {
                                                  isChecking = false;
                                                  nameEnquiryLoading =
                                                      false; //
                                                });
                                              }

                                              return '';
                                            },
                                            validateForm: (value) {
                                              if (value.isEmpty) {
                                                addError(
                                                    error:
                                                        'Account Number is Required');
                                                return "";
                                              }
                                              return null;
                                            },
                                          ),
                                          ResultPage(
                                            switchWidget: CustomFlushToggle(
                                              size: size,
                                              status: isSaveToBeneficiary,
                                              onToggle: (val) {
                                                setState(() {
                                                  isSaveToBeneficiary = val;
                                                  print(
                                                      'isSaveToBeneficiary : $isSaveToBeneficiary');
                                                });
                                                //saveBiometricState(val);
                                              },
                                            ),
                                            userResultData: userResultData,
                                            checking: isChecking,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          RoundedInputField(
                                            // onSaved: (newValue) => bvn = newValue,
                                            onSaved: (newValue) =>
                                                note = newValue,
                                            inputType: TextInputType.text,
                                            labelText: 'Note',
                                            autoCorrect: true,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          FormError(errors: errors),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          CustomSignInButton(
                                            size: size,
                                            onTap: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState
                                                    .save();
                                                // if all are valid then go to success screen
                                                KeyboardUtil.hideKeyboard(
                                                    context);
                                                // Navigator.pushReplacementNamed(
                                                //     context, AppRouteName.DASHBOARD);

                                                setState(() {
                                                  currentView = 1;
                                                });
                                              }
                                            },
                                            btnTitle: 'Continue',
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: currentView == 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OTPTransaction(
                                  size: size,
                                  amount: 'N $amount',
                                  date: tfDate,
                                  selectedBank: bankName,
                                  userAccount: 'QuickMFB',
                                  receipientNumber: accountNum,
                                  transactPin: transactPin,
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
                                      var transferFundsParams = TransferFunds(
                                          pin: pin,
                                          amount: amount,
                                          to: accountNum,
                                          toBankCode: bankCode,
                                          toBankName: bankName,
                                          toBvn: toBvn ?? '--------',
                                          from: from ?? '',
                                          fromName: fromName ?? '',
                                          toKyc: toKyc ?? '--------',
                                          toName: userResultData,
                                          narration: note ?? '-------',
                                          saveBeneficiary: isSaveToBeneficiary??false,
                                          sessionId: isSessionId);
                                      transferFunds(
                                          transferFundsParams, transferProv);
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
                            SizedBox(
                              height: size.height * 0.3,
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
