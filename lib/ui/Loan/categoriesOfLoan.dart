import 'package:flutter/material.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_gethelp_item_ui.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class CategoriesOfLoanUI extends StatefulWidget {
  @override
  _CategoriesOfLoanUIState createState() => _CategoriesOfLoanUIState();
}

class _CategoriesOfLoanUIState extends State<CategoriesOfLoanUI> {
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
                pageTitle: 'Loan',
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
                      title: 'Nano Loan',
                      leadingIcon: Icons.account_balance,
                      onTap: () {
                        print('');
                      },
                    ),
                    BillWidget(

                      size: size,
                      title: 'Salary Loan',
                      leadingIcon: Icons.account_balance,
                      onTap: () {
                        print('');
                        Navigator.pushReplacementNamed(context, AppRouteName.LoanPageUI);
                      },
                    ),
                    BillWidget(

                      size: size,
                      title: 'Business Loan',
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
    );
  }
}
