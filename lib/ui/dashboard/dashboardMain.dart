import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/createAccountBvnResp.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/provider/accountSetupProvider.dart';
import 'package:quickfund/provider/authProvider.dart';
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
  String userName = 'Bose',acctN='', acctBalance = '239,600' ,accountNum='2993204939', accountType='Savings Account' , closedBal = 'XXXXXXX';
  bool _passwordVisible;
  List<Account> accountList;
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  @override
  void initState() {
    _passwordVisible = false;
    SchedulerBinding.instance.addPostFrameCallback((_) => getAcct());
    super.initState();
  }
  var selfie, username;
  parseAuthData(AuthProvider setupAccountViaBVNandViaPhoneProvider) {
    try {
      if (setupAccountViaBVNandViaPhoneProvider.login != null) {
        final userData = LoginResp.fromJson(setupAccountViaBVNandViaPhoneProvider.login);
       setState(() {
         selfie = userData.data.user.selfie;
         print('selfie: $selfie');
         username = userData.data.user.firstName;
         print('username: $username');
         accountList = userData.data.accounts;
         print('accountNum: $accountNum');
         username = userData.data.user.firstName;
         print('username: $username');
         selfie = userData.data.user.selfie;
         print('selfie: $selfie');
         username = userData.data.user.firstName;
         print('username: $username');
       });
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  getAcct() async {
    await Future.forEach(accountList, (Account account) async {
      print('Account ${account.accountNumber}');
      print('Account ${account.accountType}');
      acctN = account.accountNumber;
      accountType=account.accountType;

      //acctCode=account.
      print('account number: $acctN');
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer<AuthProvider>(
  builder: (context, provider, child) {
    parseAuthData(provider);
  return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Positioned(
            // draw a red marble
            top: 32,
            right: 21.0,
            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.redAccent),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
                flex: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                  child: Column(
                    children: [
                      DashBoardHeader(
                        userName: username ==null ? '$userName' :'$username',
                        imgrUrl:selfie ==null ?'http://via.placeholder.com/640x360': '$selfie',
                        notification: () {
                          Navigator.pushNamed(
                              context, AppRouteName.NotificationUI);
                        },
                        userAcct: () {
                          Navigator.pushNamed(context, AppRouteName.More);
                        },
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
                        accountNum: acctN==null ? '--------':'$acctN',
                        acctBalanceI: 'Account Balance',
                        acctBalanceII:
                            _passwordVisible ? 'N $acctBalance' : 'XXXXXXXXXX',
                        savingsAcct:accountType ==null ? 'Account Type is not available!' :'$accountType',
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
                )),
            Flexible(
              flex: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  DashBoardGetStartedComponent(),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDashBoardCard(
                        size: size,
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRouteName.TransferComponent);
                        },
                        cardIcon: 'assets/f_svg/iconTransfer.svg',
                        cardTitle: 'Transfer Via Bank',
                      ),
                      CustomDashBoardCard(
                        size: size,
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteName.AirtimeUI);
                        },
                        cardIcon: 'assets/f_svg/phoneLink.svg',
                        cardTitle: 'Buy Airtime',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDashBoardCard(
                        size: size,
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteName.LoanMainUI);
                        },
                        cardIcon: 'assets/f_svg/accountBalance.svg',
                        cardTitle: 'Loan',
                      ),
                      CustomDashBoardCard(
                        size: size,
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteName.BillMainUI);
                        },
                        cardIcon: 'assets/f_svg/billPaymentIcon.svg',
                        cardTitle: 'Bill Payment ',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.001,
                  ),
                ]),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(children: [
                  Expanded(
                    flex: 0,
                    child: RecentTransactionHead(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRouteName.TransactionUI);
                        print('see all');
                      },
                    ),
                  ),
                  Expanded(
                      //  flex: 0,
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
                        ]),
                      )
                    ]),
                  )),
                ]),
              ),
            ),
          ]),
        ],
      ),
    );
  },
);
  }
}
