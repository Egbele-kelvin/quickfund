import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickfund/util/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextStyle customTextHintStyle;
  final Icon prefixIcon;
  final TextInputType inputType;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onComplete;
  final ValueChanged<String> onEditing;
  final ValueChanged<String> onSubmitted;
  final bool isEnabled;
  final Widget suffixIcon;
  final String labelText;
  final int maxLen;
  final Color textColor, hintColor;
  final bool autoCorrect, passwordvisible;
  final ValueChanged<String> onSaved;
  final Color borderColor;
  final List inputForm;
  final String initialValue;
  final FormFieldValidator<String> validateForm;
  final FocusNode hasFocus;
  final Function onTap;
  final controller;
  final bool readOnly;

  // final ValueChanged<dynamic> contentPadding;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.onChanged,
    this.validateForm,
    this.inputType = TextInputType.text,
    this.isEnabled,
    this.textColor = Colors.black,
    this.borderColor = Colors.grey,
    this.autoCorrect,
    this.onComplete,
    this.onEditing,
    this.prefixIcon,
    this.onSaved,
    this.maxLen,
    this.inputForm,
    Null Function(BuildContext context,
            {int currentLength, bool isFocused, int maxLength})
        buildCounter,
    this.controller,
    this.onSubmitted,
    this.hintColor,
    this.suffixIcon,
    this.passwordvisible = false,
    this.labelText,
    this.hasFocus,
    this.customTextHintStyle, this.initialValue, List<dynamic> inputFormatters, this.onTap, this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly !=null ? readOnly : false,
      onTap: onTap,
      cursorColor: kDashBoardCardColor,
      initialValue: initialValue,
      obscureText: passwordvisible,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      inputFormatters: inputForm,
      onSaved: onSaved,
      maxLength: maxLen,
      autocorrect: autoCorrect,
      focusNode: hasFocus,
      validator: validateForm,
      onChanged: onChanged,
      enabled: isEnabled,
      keyboardType: inputType,
      style: GoogleFonts.roboto(
          fontSize: 12, color: textColor, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: customTextHintStyle,
        prefixIcon: prefixIcon,
        // prefixIcon: Icon(
        //   DashBoard.naira,
        //   color: Colors.black,
        //   size: 20,
        // ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        counterText: '',
        //filled: true,
        //fillColor: Colors.grey.withOpacity(0.25),
        // focusColor: Colors.grey,
        // enabledBorder: OutlineInputBorder(
        //     gapPadding: 10,
        //     borderSide: BorderSide(color: borderColor),
        //     borderRadius: BorderRadius.circular(10)),
        // focusedBorder: OutlineInputBorder(
        //     borderSide:
        //     BorderSide(color: Colors.grey.withOpacity(0.2)),
        //     borderRadius: BorderRadius.circular(10)),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
      ),
      // border: InputBorder.none,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class NotAlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => true;
}


class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value/100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}


