import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickfund/data/model/transactionHistory.dart';
import 'package:quickfund/provider/transferProvider.dart';
import 'package:quickfund/ui/quickHelp/ui_design/contact_info.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/sharedPreference.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';
import 'package:quickfund/widget/searchHistory.dart';

class TransactionUI extends StatefulWidget {
  @override
  _TransactionUIState createState() => _TransactionUIState();
}

class _TransactionUIState extends State<TransactionUI> {
  TransferProvider _provider;

  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();

  List<TransactionHistoryDatum> transactionHistoryData = [];
  String userName = 'Bose',
      acctBalance = '239,600',
      toDate = '',
      from,
      fromDate = '';
  DateTime selectedDate,
      fromDateCal,
      toDateCal = DateTime.now();
  var date;
  final searchController = TextEditingController();
  String tfDate = DateFormat.yMMMd().format(DateTime.now());

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height / 2.7,
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      // if(selectedDate!=date){
                      //   fromDate=date.toString();
                      //   Navigator.pop(context);
                      // }
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Done',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.04,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .copyWith()
                      .size
                      .height / 3.2,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (picked) {
                      if (picked != null && picked != selectedDate)
                        setState(() {
                          selectedDate = picked;

                          fromDate =
                          "${selectedDate
                              .toLocal()
                              .year}-${selectedDate
                              .toLocal()
                              .month}-${selectedDate
                              .toLocal()
                              .day}";
                          print('issuedDate: $fromDate');

                          toDate =
                          "${selectedDate
                              .toLocal()
                              .year}-${selectedDate
                              .toLocal()
                              .month}-${selectedDate
                              .toLocal()
                              .day}";
                          print('issuedDate: $fromDate');

                          // date =
                          // "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
                        });
                    },
                    initialDateTime: selectedDate,
                    minimumYear: 1970,
                    maximumYear: 2025,
                  ),
                ),
              ],
            ),
          );
        });
  }

  parseTransactionDataCheck(TransferProvider transferProvider) {
    try {
      if (transferProvider.transactionHistoryData != null) {
        transactionHistoryData = transferProvider.transactionHistoryData;
      }
    } catch (e) {
      print('e: $e');
    }
  }

  getUserDetails() async {
    from = await _sharedPreferenceQS.getSharedPrefs(String, 'accountNum') ?? '';
    print('from: $from');
  }

  void showMessage(String message) {
    var size = MediaQuery
        .of(context)
        .size;
    showDialog<void>(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          content: Container(
            height: size.height * 0.16,
            width: double.infinity,
            child: SelectDateRange(
              size: size,
              fromDate: fromDate == null ? '10-05-2020' : '$fromDate',
              toDate: toDate == null ? '10-05-2021' : '$toDate',
              fromDateSelect: () {
                _selectDate(context);
              },
              toDateSelect: () {},
              proceedOnTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }


  void filterSearchResults(String query) {
    final postMdl = Provider.of<TransferProvider>(context, listen: false);
    setState(() {
      if (query.isNotEmpty) {
            transactionHistoryData = postMdl.transactionHistoryData;
        print('filteredList: ${transactionHistoryData.toList()}');
      transactionHistoryData =
            postMdl.transactionHistoryData
                .where((i) =>
                i.desc.toLowerCase().contains(query.toLowerCase()))
                .toList();
      } else {
        transactionHistoryData =
            transactionHistoryData = postMdl.transactionHistoryData;
      }
      print('filter ${transactionHistoryData.toString()}');
    });
  }

  @override
  void initState() {
    final postMdl = Provider.of<TransferProvider>(context, listen: false);
    postMdl.getAllTransactionHistory();
   setState(() {
     transactionHistoryData = postMdl.transactionHistoryData;
   });
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    SizeConfig().init(context);
    return Consumer<TransferProvider>(
        builder: (context, transferProvider, child) {
          _provider = transferProvider;
         // parseTransactionDataCheck(transferProvider);

          return
            Scaffold(
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
                    flex: 9,
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
                              child: TransactionHistoryDateCalender(
                                onChange: (val) => filterSearchResults(val),
                                size: size,
                                searchController: searchController,
                                onTap: () {
                                  searchController.clear();
                                  showMessage('');
                                },
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: CustomScrollView(
                                slivers: [
                                  SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: transactionHistoryData == null
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
                                          : transactionHistoryData.isNotEmpty
                                          ? Column(
                                          children: transactionHistoryData
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) =>
                                                TransactionHistorySummary(
                                                  isPending: e.value
                                                      .payerAccount ==
                                                     from,
                                                  onTap: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                        context,
                                                        AppRouteName
                                                            .TransactionRef,
                                                        arguments: e.value);
                                                  },
                                                  size: size,
                                                  tfDate: e.value.date,
                                                  amount: 'NGN ${e.value
                                                      .amount}',
                                                  amountColor: kTap,
                                                  code: e.value.directionText,
                                                  transferName:
                                                  '${e.value.desc}',
                                                ),
                                          )
                                              .toList()) : Center(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.06,),
                                              Icon(
                                                Icons.baby_changing_station,
                                                size: 65,
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,),
                                              Text(
                                                'No Transaction History At The Moment!',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10
                                                ),
                                              )
                                            ],
                                          )),
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
            );
        });
  }
}