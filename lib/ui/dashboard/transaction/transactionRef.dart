import 'package:fdottedline/fdottedline.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/data/model/transactionHistory.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/customReferenceWidget.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class TransactionRef extends StatelessWidget {
  final TransactionHistoryDatum transactionHistoryDatum;

  const TransactionRef({Key key, this.transactionHistoryDatum})
      : super(key: key);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }
  @override
  Widget build(BuildContext context) {
    String tf;
    // = tfDate.toString();
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
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
                  // Navigator.pop(context);
                  //onBackPress();
                  Navigator.pushReplacementNamed(
                      context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Transaction Reference',
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
                    Expanded(
                      flex: 10,
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(children: [
                              Align(
                                child: SvgPicture.asset(
                                  'assets/f_svg/quickfund.svg',
                                  width: size.width * .24,
                                ),
                                alignment: Alignment.topRight,
                              ),
                              SizedBox(
                                height: size.height * .03,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Payer',
                                labelI:
                                    '${transactionHistoryDatum.payerName.toUpperCase()}',
                                labelII:
                                    '${transactionHistoryDatum.payerAccount}',
                                labelIII: 'QuickFundMB',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Receiver',
                                labelI:
                                    '${transactionHistoryDatum.receiverName}',
                                labelII:
                                    '${transactionHistoryDatum.receiverAccount}',
                                labelIII: '${transactionHistoryDatum.bank}',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Transaction',
                                labelI: 'NGN ${transactionHistoryDatum.amount}',
                                labelII: 'Transfer',
                                labelIII:
                                    '${transactionHistoryDatum.date} GMT +1',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Narration',
                                labelI: '',
                                labelII: '${transactionHistoryDatum.narration}',
                                labelIII:
                                    '${transactionHistoryDatum.payerName} ${transactionHistoryDatum.payerAccount}*****',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Reference',
                                labelI: '',
                                labelII: '${transactionHistoryDatum.reference}',
                                labelIII: '',
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                    onTap: () {
                                      share();
                                    },
                                    child: Icon(
                                      Icons.share,
                                      size: 25,
                                    )),
                              )
                            ]),
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
    );
  }
}
