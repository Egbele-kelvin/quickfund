import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_search.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class TransactionUI extends StatefulWidget {
  @override
  _TransactionUIState createState() => _TransactionUIState();
}

class _TransactionUIState extends State<TransactionUI> {
  String userName = 'Bose', acctBalance = '239,600';
  final searchController = TextEditingController();
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
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
                  //onBackPress();
                  Navigator.pushReplacementNamed(
                      context, AppRouteName.DASHBOARD);
                },
                pageTitle: 'Transaction History',
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
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SearchBoxWidget(
                          searchController: searchController,
                          onSubmitted: (val) {},
                          onEditingComplete: () {},
                          onChanged: (val) {},
                          onEditing: (val) {},
                        ),
                      ),
                    ),


                    ///-----concept to --- work on ------
                    Expanded(
                      flex: 10,
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(children: [

                              SizedBox(
                                height: size.height * 0.02,
                              ),

                              TransactionHistorySummary(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, AppRouteName.TransactionRef);
                                },
                                size: size,
                                tfDate: tfDate,
                                amount: '-N 10,000',
                                amountColor: kTap,
                                code: 'Sent',
                                transferName: 'Transfer to Kelvin Jason',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '+N 20,000',
                                amountColor: Colors.green.withOpacity(0.8),
                                code: 'Received',
                                transferName: 'Received from Oyeyemi Kolapo',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '-N 10,000',
                                amountColor: kTap,
                                code: 'Sent',
                                transferName: 'Transfer to Kelvin Jason',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '+N 20,000',
                                amountColor: Colors.green.withOpacity(0.8),
                                code: 'Received',
                                transferName: 'Received from Oyeyemi Kolapo',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '-N 10,000',
                                amountColor: kTap,
                                code: 'Sent',
                                transferName: 'Transfer to Kelvin Jason',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '+N 20,000',
                                amountColor: Colors.green.withOpacity(0.8),
                                code: 'Received',
                                transferName: 'Received from Oyeyemi Kolapo',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '-N 10,000',
                                amountColor: kTap,
                                code: 'Sent',
                                transferName: 'Transfer to Kelvin Jason',
                              ),
                              TransactionHistorySummary(
                                onTap: () {},
                                size: size,
                                tfDate: tfDate,
                                amount: '+N 20,000',
                                amountColor: Colors.green.withOpacity(0.8),
                                code: 'Received',
                                transferName: 'Received from Oyeyemi Kolapo',
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

