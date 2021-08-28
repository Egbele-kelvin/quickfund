import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/dashboardContentGetStarted.dart';

class DashBoardMain extends StatefulWidget {
  @override
  _DashBoardMainState createState() => _DashBoardMainState();
}

class _DashBoardMainState extends State<DashBoardMain> {
  String userName = 'Bose', acctBalance = '239,600';

  String tfDate = DateFormat.yMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: kPrimaryColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
            flex: 0,
            child: Container(

              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),

                    DashBoardHeader(
                      userName: userName,
                      imgrUrl: 'assets/f_png/businessman.png',
                      notification: () {},
                      userAcct: () {},
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    CardDetails(
                      dashBoardColor: kDashBoardCardColor,
                      size: size,
                      gestureTap: () {
                        print('add fund');
                      },
                      accountNum: '2993204939',
                      acctBalanceI: 'Account Balance',
                      acctBalanceII: 'N $acctBalance',
                      savingsAcct: 'Savings Account',
                      iconData: Icons.visibility,
                    )
                    //Spacer(flex: 1,),
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 0,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              DashBoardGetStartedComponent(),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDashBoardCard(
                    size: size,
                    onTap: () {},
                    cardIcon: Icons.wb_incandescent,
                    cardTitle: 'Transfer Via Bank',
                  ),
                  CustomDashBoardCard(
                    size: size,
                    onTap: () {},
                    cardIcon: Icons.autorenew_outlined,
                    cardTitle: 'Buy Airtime',
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDashBoardCard(
                    size: size,
                    onTap: () {},
                    cardIcon: Icons.account_balance,
                    cardTitle: 'Loan',
                  ),
                  CustomDashBoardCard(
                    size: size,
                    onTap: () {},
                    cardIcon: Icons.money,
                    cardTitle: 'Bill Payment',
                  ),
                ],
              ),
              // Spacer(
              //   flex: 9,
              // ),
            ]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(children: [
              Expanded(
                flex: 0,
                child: RecentTransactionHead(
                  onTap: () {
                    print('see all');
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: CustomScrollView(slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          TransactionHistorySummary(
                            onTap: () {},
                            size: size,
                            tfDate: tfDate,
                            amount: '+N 20,000',
                            amountColor: Colors.green.withOpacity(0.8),
                            code: 'Received',
                            igUrl: 'assets/f_png/bg-3.png',
                            transferName: 'Received from Oyeyemi Kolapo',
                          ),
                          TransactionHistorySummary(
                            onTap: () {},
                            size: size,
                            tfDate: tfDate,
                            amount: '-N 10,000',
                            amountColor: kTap,
                            code: 'Sent',
                            igUrl: 'assets/f_png/bg_2.png',
                            transferName: 'Transfer to Kelvin Jason',
                          ),
                          TransactionHistorySummary(
                            onTap: () {},
                            size: size,
                            tfDate: tfDate,
                            amount: '+N 20,000',
                            amountColor: Colors.green.withOpacity(0.8),
                            code: 'Received',
                            igUrl: 'assets/f_png/bg-3.png',
                            transferName: 'Received from Oyeyemi Kolapo',
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // Spacer(
                          //   flex: 9,
                          // ),
                        ]),
                      )
                    ]),
                  )),
            ]),
          ),
        ),
      ]),
    );
  }
}
