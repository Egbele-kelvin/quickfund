import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/constants.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key key,
    @required this.searchController,
    this.onChanged,
    this.onEditing,
    this.onSubmitted,
    this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController searchController;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onEditing;
  final ValueChanged<String> onSubmitted;
  final Function onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: GoogleFonts.roboto(
            fontSize: 13.5,
            color: Colors.black54.withOpacity(0.3),
            fontWeight: FontWeight.w600),
        // prefixIcon: prefixIcon,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade500,
          size: 18,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            searchController.clear();
          },
          child: Icon(
            Icons.cancel_rounded,
            color: Colors.grey.withOpacity(1),
            size: 13,
          ),
        ),

        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        counterText: '',
        focusColor: Colors.grey.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
