import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/ui/transfer/transferMain.dart';
import 'package:quickfund/ui/transfer/transferMain.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_expandable.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class TransferMainPage extends StatefulWidget {
  @override
  _TransferMainPageState createState() => _TransferMainPageState();
}

class _TransferMainPageState extends State<TransferMainPage> {
  @override
  void initState() {
    super.initState();
  }

  int currentView = 0, selectedIndex;
  bool showDataplan = false, showPhoneEdit = false, _btnEnabled = false;

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: WillPopScope(
        onWillPop: () {
          return onBackPress();
        },
        child: Column(
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
                  pageTitle: 'Transfer',
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
                      BillWidget(
                        size: size,
                        title: 'Transfer to other banks',
                        leadingIcon: Icons.account_balance,
                        onTap: () {
                          print('');
                        },
                      ),
                      BillWidget(
                        size: size,
                        title: 'Send to save beneficiary',
                        leadingIcon: Icons.account_balance,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRouteName.TransferComponent);
                        },
                      ),
                      BillWidget(
                        size: size,
                        title: 'Send to QuickFundMB',
                        leadingIcon: Icons.account_balance,
                        onTap: () {
                          print('');
                        },
                      ),
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

