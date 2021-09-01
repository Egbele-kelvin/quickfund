import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/dashboardContentGetStarted.dart';

class DashBoardMain extends StatefulWidget {
  @override
  _DashBoardMainState createState() => _DashBoardMainState();
}

class _DashBoardMainState extends State<DashBoardMain> {
  String userName = 'Bose', acctBalance = '239,600' , closedBal = 'XXXXXXX';
  bool _passwordVisible;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

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
                      dashBoardColor: kPrimaryColor,
                      size: size,
                      gestureTap: () {
                        print('add fund');
                        Navigator.pushReplacementNamed(
                            context, AppRouteName.FundAccountUI);
                      },
                      accountNum: '2993204939',
                      acctBalanceI: 'Account Balance',
                      acctBalanceII: _passwordVisible ?'N $acctBalance' : 'XXXXXXXXXX',
                      savingsAcct: 'Savings Account',

                      iconWidget: InkWell(
                          child: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                            size: 15,
                          ),
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          }),
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
                    cardIcon: Icons.swap_horiz_rounded,
                    cardTitle: 'Transfer Via Bank',
                  ),
                  CustomDashBoardCard(
                    size: size,
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(AppRouteName.AirtimeUI);
                    },
                    cardIcon: Icons.phonelink_ring,
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
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(AppRouteName.LoanMainUI);
                    },
                    cardIcon: Icons.account_balance,
                    cardTitle: 'Loan',
                  ),
                  CustomDashBoardCard(
                    size: size,
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(AppRouteName.BillMainUI);
                    },
                    cardIcon: Icons.multiline_chart_outlined,
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
