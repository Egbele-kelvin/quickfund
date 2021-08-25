import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/custom_textform_field.dart';
import 'package:quickfund/util/keyboard.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';
import 'package:quickfund/widget/form_error.dart';

class AccountMain extends StatefulWidget {
  const AccountMain({Key key}) : super(key: key);

  @override
  _AccountMainState createState() => _AccountMainState();
}

class _AccountMainState extends State<AccountMain> {
  final _formKey = GlobalKey<FormState>();
  String bvn;

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: kPrimaryColor,
                child: Custom_Sign_up_AppBar(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  imageUrl: 'assets/f_svg/quickfund.svg',
                  pageTitle: 'Account Opening',
                ),
              ),
            ),
            Expanded(
              flex: 5,
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
                      vertical: getProportionateScreenHeight(10)),
                  child: Column(
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        AppStrings.registerWithBvn,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      RoundedInputField(
                        onSaved: (newValue) => bvn = newValue,
                        inputType: TextInputType.number,
                        maxLen: 11,
                        labelText: 'BVN',
                        customTextHintStyle: GoogleFonts.lato(
                            fontSize: 12,
                            color: Colors.black54.withOpacity(0.3),
                            fontWeight: FontWeight.w600),
                        hintText: 'Enter your BVN',
                        autoCorrect: true,
                        onChanged: (value){
                          if (value.isNotEmpty) {
                            removeError(error: kBVNNullError);
                          } else if (value.length >= 11) {
                            removeError(error: kShortBVNError);
                          }
                          return null;
                        },

                        validateForm: (value) {
                          if (value.isEmpty) {
                            addError(error: kBVNNullError);
                            return "";
                          } else if (value.length < 11) {
                            addError(error: kShortBVNError);
                            return "";
                          }
                          return null;
                        },
                      ),

                      FormError(errors: errors),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        AppStrings.HAS_NO_BVN,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(
                        flex: 5,
                      ),
                      CustomButton(size: size ,
                      onTap: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          Navigator.pushNamed(context, AppRouteName.ReviewDetails);
                        }
                      },
                      btnTitle: 'Continue'.toUpperCase(),),
                      Spacer(
                        flex: 7,
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
