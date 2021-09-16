import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_search.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/custom_widgets.dart';

class SaveBeneficiary extends StatefulWidget {
  @override
  _SaveBeneficiaryState createState() => _SaveBeneficiaryState();
}

class _SaveBeneficiaryState extends State<SaveBeneficiary> {
  String userName = 'Bose', acctBalance = '239,600';
  final searchController = TextEditingController();
  String tfDate = DateFormat.yMMMd().format(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                pageTitle: 'Saved Beneficiary',
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
                              BeneficiaryCard(
                                size: size,
                                imgURL: 'assets/f_png/businesswoman.png',
                                accountNum: '08097969699439',
                                accountName: 'Olufunmilayo Emmanuel Tope',
                                bankName: 'Polaris Bank',
                                deleteTap: () {
                                  print('delete is tap');
                                },
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

