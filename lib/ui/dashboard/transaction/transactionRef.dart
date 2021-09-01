import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/customReferenceWidget.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class TransactionRef extends StatefulWidget {
  @override
  _TransactionRefState createState() => _TransactionRefState();
}

class _TransactionRefState extends State<TransactionRef> {
  var dateNow = DateTime.now();
  String tfDate = DateFormat.yMMMd().format(DateTime.now());

  var f, now;

  String getUTCDate() {
    try {
      f = DateFormat('d MMM yyyy HH:mm:ss');
      now = DateTime.now().toUtc();
      return f.format(now) + ' GMT';
    } catch (e) {
      print('Error ******' + e.toString());
      throw e;
    }
  }

  @override
  void initState() {
    print(dateNow);
    print(DateFormat('MMM dd,  yyyy').format(dateNow));
    print(getUTCDate());
    // TODO: implement initState
    super.initState();
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
                                labelI: 'abosede Glory clan',
                                labelII: '0800040402',
                                labelIII: 'QuickFundMB',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Receiver',
                                labelI: 'Fatoki iyanu olufunmilayo',
                                labelII: '0800040402',
                                labelIII: 'First Bank',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Transaction',
                                labelI: 'NGN 50,000',
                                labelII: 'Transfer',
                                labelIII: '${f.format(now) + ' GMT +1'}',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Narration',
                                labelI: '',
                                labelII: '0XF10103zqwTPQOEOCGOGOG',
                                labelIII: 'Depositor account X02933*****',
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              RefrenceContent(
                                size: size,
                                tag: 'Reference',
                                labelI: '',
                                labelII: '086959303VCKDKcsoowqZ',
                                labelIII: 'Successful',
                              ),
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
