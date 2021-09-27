import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key key,
    @required this.size,
    this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final Function onTap;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.1,
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.red,
          icon: Icons.delete,
          onTap: onTap,
        ),
      ],
      child: Container(
        height: size.height * 0.12,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 35,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 9),
                        ),
                      ),

                      // Text
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
            )
          ],
        ),
      ),
    );
  }
}
