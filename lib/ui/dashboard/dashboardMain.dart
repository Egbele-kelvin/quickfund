import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/accountBalanceRep.dart';
import 'package:quickfund/data/model/accountDetailsResp.dart';
import 'package:quickfund/data/model/loginResp.dart';
import 'package:quickfund/data/model/transactionHistory.dart';
import 'package:quickfund/provider/authProvider.dart';
import 'package:quickfund/provider/transferProvider.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/dashboardContentGetStarted.dart';

class DashBoardMain extends StatefulWidget {
  @override
  _DashBoardMainState createState() => _DashBoardMainState();
}

class _DashBoardMainState extends State<DashBoardMain> {
  AuthProvider _authProvider;
  String userName = 'Bose',
      userId,
      acctN = '',
      customerName,
      acctBalance = '...',
      accountNum = '2993204939',
      accountType,
      closedBal = 'XXXXXXX';
  bool _passwordVisible=true;
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  List<Account> accountList;
  List<AccountDatum> accountDetails;
  List<AccountBalanceData> accountBal=[];

  String tfDate = DateFormat.yMMMd().format(DateTime.now());

  getAccountDetails() async {
    final postMdl = Provider.of<AuthProvider>(context, listen: false);
    postMdl.getAccount();
    accountDetails = postMdl.accountDetails;
    try {
      await Future.forEach(accountDetails, (AccountDatum account) async {
        print('Account ${account.accountNumber}');
        acctN = account.accountNumber;
        print('acctNum : $acctN');
      });
    } catch (e) {
      print('e: $e');
    }
  }

  List<TransactionHistoryDatum> transactionHistoryData = [];

  Future<void> getAccountBal(String accountNum) async {
    try {
      await _authProvider.getUserBal(accountNum);
      if (_authProvider.userAcctBalResp != null) {
        final acctBalData =
            AccountBalance.fromJson(_authProvider.userAcctBalResp).data;
        print('data45 ${_authProvider.userAcctBalResp}');
        accountBal.add(acctBalData);
      }
    } catch (e) {
      print('e: $e');
    }
    return null;
  }

  @override
  void initState() {
    _passwordVisible = true;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      getAcct();
      getAccountDetails();
      final postMdl = Provider.of<TransferProvider>(context, listen: false);
      postMdl.getAllTransactionHistory();
    });
    super.initState();
  }

  var selfie, username;

  parseTransactionDataCheck(TransferProvider transferProvider){
    try{
      if(transferProvider.transactionHistoryData!=null){
        transactionHistoryData = transferProvider.transactionHistoryData;
      }

    }catch(e){
      print('e: $e');
    }
  }
  parseAuthData(AuthProvider setupAccountViaBVNandViaPhoneProvider) {
    try {
      if (setupAccountViaBVNandViaPhoneProvider.login != null) {
        final userData =
            LoginResp.fromJson(setupAccountViaBVNandViaPhoneProvider.login);
        setState(() {
          selfie = userData.data.user.selfie;
          print('selfie: $selfie');
          username = userData.data.user.firstName;
          print('username: $username');
          accountList = userData.data.accounts;
          print('accountNum: $accountNum');
          userId = userData.data.user.id.toString();
          print('userId: $userId');
        });
      }
    } catch (e) {
      print('Server Auth Error');
    }
  }

  getAcct() async {
    await Future.forEach(accountList, (Account account) async {
      print('Account ${account.accountNumber}');
      await getAccountBal(account.accountNumber.toString());
      print('Account ${account.accountType}');
      acctN = account.accountNumber;
      //acctBalance = account.accountBalance.toString();
      customerName = account.customerName;
      accountType = account.accountType;

      _sharedPreferenceQS.setData(
          'String', 'customerName', account.customerName);
      _sharedPreferenceQS.setData(
          'String', 'accountNum', account.accountNumber);

      //acctCode=account.
      print('account number: $acctN');
      print('account bal: $acctBalance');
      print('account type: $accountType');
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Consumer2<AuthProvider , TransferProvider>(
      builder: (context, provider,transferProvider, child) {
        _authProvider=provider;
        parseAuthData(provider);
        parseTransactionDataCheck(transferProvider);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: kPrimaryColor,
          body: Stack(
            children: [
              Positioned(
                // draw a red marble
                top: 32,
                right: 21.0,
                child: Icon(Icons.brightness_1,
                    size: 8.0, color: Colors.redAccent),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Flexible(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 14),
                      child: Column(
                        children: [
                          DashBoardHeader(
                            userName:
                                username == null ? '$userName' : '$username',
                            imgrUrl: selfie == null
                                ? 'http://via.placeholder.com/640x360'
                                : '$selfie',
                            notification: () {
                              Navigator.pushNamed(
                                  context, AppRouteName.NotificationUI);
                            },
                            userAcct: () {
                              Navigator.pushNamed(context, AppRouteName.More);
                            },
                          ),

                          SizedBox(
                            height: size.height * 0.01,
                          ),

                          CardDetails(
                            dashBoardColor: kPrimaryColor,
                            size: size,
                            gestureTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRouteName.FundAccountUI);
                            },
                            accountNum: acctN == null ? '--------' : '$acctN',
                            acctBalanceI: 'Account Balance',
                            // acctBalanceII: _passwordVisible
                            //     ? '₦ $acctBalance'
                            //     : 'XXXXXXXXXX',
                            acctBalanceII: _passwordVisible
                                ? accountBal == null || accountBal.isEmpty
                                    ? acctBalance
                                    : 'NGN ${accountBal[0].balance ?? acctBalance}'
                                : 'XXXXXXXXXX',
                            // savingsAcct: accountType == null
                            //     ? 'Account Type is not available!'
                            //     : '$accountType',
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
                            color: kPrimaryColor,
                            size: size,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouteName.TransferComponent);
                            },
                            cardIcon: 'assets/f_svg/iconTransfer.svg',
                            cardTitle: 'Transfer\nFunds Via Bank',
                          ),
                          CustomDashBoardCard(
                            color: kPrimaryColor,
                            // imgColor: Color(0xff624cff).withOpacity(0.5) ,
                            // color: Color(0xff624cff).withOpacity(0.03),
                            size: size,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouteName.AirtimeUI);
                            },
                            cardIcon: 'assets/f_svg/phoneLink.svg',
                            cardTitle: 'Buy \nAirtime',
                            // cardTitleColor: Colors.black,
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
                            cardTitleColor: Colors.white,
                            color: kPrimaryColor,
                            size: size,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouteName.LoanMainUI);
                            },
                            cardIcon: 'assets/f_svg/accountBalance.svg',
                            cardTitle: 'Loan \nRequest',
                          ),
                          CustomDashBoardCard(
                            size: size,
                            cardTitleColor: Colors.white,
                            color: kPrimaryColor,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouteName.BillMainUI);
                            },
                            cardIcon: 'assets/f_svg/billPaymentIcon.svg',
                            cardTitle: 'Bill \nPayment ',
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
                        child: transactionHistoryData.isEmpty
                            ? Container()
                            : RecentTransactionHead(
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
                            child: transactionHistoryData == null
                                ? Center(
                                    child: SpinKitFadingCircle(
                                        size: 20,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                          );
                                        }))
                                : transactionHistoryData.isNotEmpty
                                    ? Container(
                                        height: size.height * 0.35,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return TransactionHistorySummary(
                                                isPending:
                                                    transactionHistoryData[
                                                                index]
                                                            .payerAccount ==
                                                       acctN,
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                      context,
                                                      AppRouteName
                                                          .TransactionRef,
                                                      arguments: transactionHistoryData[index]);
                                                },
                                                size: size,
                                                tfDate: transactionHistoryData[
                                                        index]
                                                    .date,
                                                amount:
                                                    'NGN ${transactionHistoryData[index].amount}',
                                                amountColor: kTap,
                                                code:
                                                    '${transactionHistoryData[index].directionText}',
                                                igUrl: 'assets/f_png/bg-3.png',
                                                transferName:
                                                    '${transactionHistoryData[index].desc}',
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => Container(),
                                            itemCount: transactionHistoryData.length),
                                      )
                                    : Center(
                                        child: Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.06,
                                          ),
                                          Icon(
                                            Icons.baby_changing_station,
                                            size: 65,
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Text(
                                            'No Transaction History At The Moment!',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10),
                                          )
                                        ],
                                      )),
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
