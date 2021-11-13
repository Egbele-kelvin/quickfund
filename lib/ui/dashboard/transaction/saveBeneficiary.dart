import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/deleteSaveBeneficiary.dart';
import 'package:quickfund/data/model/saveBeneficiaryResp.dart';
import 'package:quickfund/data/model/transfersResp.dart';
import 'package:quickfund/provider/transferProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/customLoader.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/addQuestions.dart';
import 'package:quickfund/widget/custom_search.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/responseMessage.dart';

class SaveBeneficiary extends StatefulWidget {
  @override
  _SaveBeneficiaryState createState() => _SaveBeneficiaryState();
}

class _SaveBeneficiaryState extends State<SaveBeneficiary> {
  String userName = 'Bose',
      acctBalance = '239,600', responseData, userId;
  final searchController = TextEditingController();
  bool isLoading=false;
  List<SaveBeneficiaryData> saveBeneficiaryData = [];
  TransferProvider _transferProvider;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    final postMdl = Provider.of<TransferProvider>(context, listen: false);
    postMdl.getAllSavedBeneficiary();
    setState(() {
      saveBeneficiaryData = postMdl.saveBeneficiaryData;
    });
    super.initState();
  }

  void showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    String cancelActionText,
    @required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              FlatButton(
                child: Text(cancelActionText),
                textColor: Colors.blue,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            FlatButton(
                child: Text(defaultActionText),
                textColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop(false);

                  var deleteSaveBeneficiary =DeleteSaveBeneficiary(
                    beneficiaryId: userId
                  );
                      deleteBeneficiary(deleteSaveBeneficiary,_transferProvider );

                }),
          ],
        ),
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.red),
            child: Text(defaultActionText),
            onPressed: () {
              Navigator.of(context).pop(false);

              var deleteSaveBeneficiary =DeleteSaveBeneficiary(
                  beneficiaryId: userId
              );
              deleteBeneficiary(deleteSaveBeneficiary,_transferProvider );
            },
          ),
        ],
      ),
    );
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

  void filterSearchResults(String query) {
    final postMdl = Provider.of<TransferProvider>(context, listen: false);
    setState(() {
      if (query.isNotEmpty) {
        saveBeneficiaryData = postMdl.saveBeneficiaryData;
        print('filteredList: ${saveBeneficiaryData.toList()}');
        saveBeneficiaryData =
            postMdl.saveBeneficiaryData
                .where((i) =>
                i.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
      } else {
        saveBeneficiaryData =
            saveBeneficiaryData = postMdl.saveBeneficiaryData;
      }
      print('filter ${saveBeneficiaryData.toString()}');
    });
  }
  void deleteBeneficiary(DeleteSaveBeneficiary deleteSaveBeneficiary,
      TransferProvider transferProvider) async {
    setState(() {
      isLoading = true;
    });
    try {
      await transferProvider.deleteBeneficiary(deleteSaveBeneficiary);
      var changePinResp = TransferResp.fromJson(transferProvider.deleteBeneficiaryData);
      print('loginResp response $changePinResp');
      if (transferProvider.deleteBeneficiaryData != null) {
        if (changePinResp.status == true && changePinResp.responsecode == 200) {
          setState(() {
            isLoading = false;
            responseData = changePinResp.message;
          });
          print('responseMessage : $responseData');
          responseMessage('Success', '${changePinResp.message}', 'assets/lf30_editor_23pqj4lo.json', Colors.green);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          final postMdl = Provider.of<TransferProvider>(context, listen: false);
          postMdl.getAllSavedBeneficiary();
          setState(() {
            saveBeneficiaryData = postMdl.saveBeneficiaryData;
          });
        } else {
          responseMessage('Error', '${changePinResp.message}', 'assets/76705-error-animation.json', Colors.red);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        responseMessage('Error', '${changePinResp.message}', 'assets/76705-error-animation.json', Colors.red);
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    SizeConfig().init(context);
    return Consumer<TransferProvider>(builder: (context, transferProv, child) {
      _transferProvider=transferProv;
      return LoadingOverlay(
        isLoading:isLoading ,
        child: Scaffold(
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
                      Navigator.pop(context);
                    },
                    pageTitle: 'Saved Beneficiary',
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
                      horizontal: getProportionateScreenWidth(10.0),
                      vertical: getProportionateScreenHeight(10.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        saveBeneficiaryData.isEmpty ? Container() : Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SearchBoxWidget(
                              searchController: searchController,
                              onSubmitted: (val) {},
                              onEditingComplete: () {},
                              onChanged: (val) {
                                filterSearchResults(val);
                              },
                              onEditing: (val) {},
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child:saveBeneficiaryData == null
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
                                      : saveBeneficiaryData.isNotEmpty ? Column(
                                      children: saveBeneficiaryData
                                          .asMap()
                                          .entries
                                          .map((e) =>
                                          BeneficiaryCard(
                                            onTap: (){
                                              Navigator.pushNamed(context, AppRouteName.TransferComponent);
                                            },
                                            size: size,
                                            imgURL: 'assets/f_png/businesswoman.png',
                                            accountNum: e.value.accountNumber ?? '----------',
                                            accountName: e.value.name ?? '-----------',
                                            bankName: e.value.bankName ?? '-----------',
                                            deleteTap: () {
                                              setState(() {
                                                userId=e.value.id.toString();
                                              });
                                              showAlertDialog(
                                                  content: 'Are you sure you want to Delete this User?',
                                                  context: context,
                                                  defaultActionText: 'Yes',
                                                  cancelActionText: 'No',
                                                  title: '???');
                                            },
                                          ))
                                          .toList()) : NoActivity(
                                    tag:
                                    'OH No Saved Beneficiary...',
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    });
  }
}
