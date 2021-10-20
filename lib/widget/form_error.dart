import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Padding formErrorText({String error}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/Error.svg",
            height: 10,
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Text(error , style:GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w300
          ),),
        ],
      ),
    );
  }
}
