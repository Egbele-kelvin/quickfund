import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/widget/custom_button.dart';
import 'cable_sucess.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/constants.dart';
import 'package:quickfund/util/size_config.dart';
import 'package:quickfund/widget/custom_sign_up_appbar.dart';

class Cable extends StatefulWidget {
  @override
  _CableState createState() => _CableState();
}

class _CableState extends State<Cable> {
  bool isVisible = false;
  bool focus = true;
  double opacityLevel = 0;
  String mainText = 'Choose a Subscription';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
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
                      context, AppRouteName.CableMain);
                },
                pageTitle: 'Cable Subscription',
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
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 30, left: 10,bottom: 15),
                            child: Text(
                              'Decoder Number',
                              style: GoogleFonts.roboto(fontSize: 16),
                            )),
                        Container(
                          height: 60,
                            width: 60,
                            child: Image.network('https://getlogo.net/wp-content/uploads/2021/05/dstv-logo-vector.png'))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextField(
                        maxLength: 13,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Smart Card Number',
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isVisible = true;
                                  });
                                },
                                child: Icon(Icons.search)),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Visibility(
                        visible: isVisible,
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            color: Color(0xf0FF4C4C),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: ListTile(
                            title: Text('Oyewumi Kunle',style: GoogleFonts.roboto(
                                color: Colors.white
                            ),),
                            trailing: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.green,width: 1)
                                ),
                                child: Icon(Icons.check,size: 15,color: Colors.white,)),
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 30, left: 10,bottom: 15),
                        child: Text(
                          'Select Bundle',
                          style: GoogleFonts.roboto(fontSize: 16),
                        )),
                    GestureDetector(
                      onTap: (){
                        print('Modal bottomsheet');
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            builder: (context){
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: ListView.separated(
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        title: Text('DStv Family for N20000'),
                                        onTap: (){
                                          setState(() {
                                            mainText = 'DStv Family for N20000';
                                            Navigator.pop(context);
                                          });
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) => Divider(
                                      height: 1,
                                      color: Colors.orange,
                                    ),
                                    itemCount: 8),
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextField(
                          autofocus: false,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: mainText,

                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CustomButton(
                      btnTitle: 'Pay Now',
                      size: size,
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CableSuccessful()));
                      },
                    )
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














//
// class CableTV extends StatefulWidget {
//   //const CableTV({Key? key}) : super(key: key);
//
//   @override
//   _CableTVState createState() => _CableTVState();
// }
//
// class _CableTVState extends State<CableTV> {
//
//   bool isVisible = false;
//   bool focus = true;
//   double opacityLevel = 0;
//   String mainText = 'Choose a Subscription';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(0xf0FF4C4C),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.deepOrange,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                       padding: EdgeInsets.only(top: 30, left: 10),
//                       child: Icon(
//                         Icons.west,
//                         color: Colors.white,
//                       )),
//                   Padding(
//                     padding: EdgeInsets.only(top: 30, left: 90),
//                     child: Text(
//                       'Cable TV',
//                       style:
//                       GoogleFonts.roboto(color: Colors.white, fontSize: 22),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(top: 30, left: 10,bottom: 15),
//                         child: Text(
//                           'Decoder Number',
//                           style: GoogleFonts.roboto(fontSize: 16),
//                         )),
//                     Container(
//                       margin: EdgeInsets.only(left: 10),
//                       width: MediaQuery.of(context).size.width * 0.95,
//                       child: Theme(
//                         data: ThemeData(
//                           primaryColor: Colors.grey,
//                         ),
//                         child: TextField(
//                           maxLength: 13,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                               hintText: 'Smart Card Number',
//                               suffixIcon: GestureDetector(
//                                   onTap: (){
//                                     setState(() {
//                                       isVisible = true;
//                                     });
//                                   },
//                                   child: Icon(Icons.search)),
//                               border: OutlineInputBorder()),
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                         visible: isVisible,
//                         child: Container(
//                           margin: EdgeInsets.only(left: 10,right: 10),
//                           decoration: BoxDecoration(
//                             color: Color(0xf0FF4C4C),
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           child: ListTile(
//                             title: Text('Oyewumi Kunle',style: GoogleFonts.roboto(
//                                 color: Colors.white
//                             ),),
//                             trailing: Container(
//                                 width: 20,
//                                 height: 20,
//                                 decoration: BoxDecoration(
//
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(color: Colors.green,width: 1)
//                                 ),
//                                 child: Icon(Icons.check,size: 15,color: Colors.white,)),
//                           ),
//                         )
//                     ),
//                     Padding(
//                         padding: EdgeInsets.only(top: 30, left: 10,bottom: 15),
//                         child: Text(
//                           'Select Bundle',
//                           style: GoogleFonts.roboto(fontSize: 16),
//                         )),
//                     GestureDetector(
//                       onTap: (){
//                         print('Modal bottomsheet');
//                         showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20)
//                             ),
//                             builder: (context){
//                               return Container(
//                                 margin: EdgeInsets.only(top: 10),
//                                 height: MediaQuery.of(context).size.height * 0.8,
//                                 child: ListView.separated(
//                                     itemBuilder: (_, index) {
//                                       return ListTile(
//                                         title: Text('DStv Family for N20000'),
//                                         onTap: (){
//                                           setState(() {
//                                             mainText = 'DStv Family for N20000';
//                                             Navigator.pop(context);
//                                           });
//                                         },
//                                       );
//                                     },
//                                     separatorBuilder: (_, __) => Divider(
//                                       height: 1,
//                                       color: Colors.orange,
//                                     ),
//                                     itemCount: 8),
//                               );
//                             });
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(left: 10),
//                         width: MediaQuery.of(context).size.width * 0.95,
//                         child: Theme(
//                           data: ThemeData(
//                             primaryColor: Colors.grey,
//                           ),
//                           child: TextField(
//                             autofocus: false,
//                             enabled: false,
//                             decoration: InputDecoration(
//                               //hintText: 'Choose a Subscription',
//                                 labelText: mainText,
//                                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                                 border: OutlineInputBorder()),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 50,
//                       margin: EdgeInsets.all(15),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>CableSuccessful()));
//                         },
//                         child: Text('Pay Now'),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomListView extends StatefulWidget {
  const CustomListView({
    Key key,
  }) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  String mainText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.separated(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text('DStv Family for N20000'),
              onTap: (){
                setState(() {
                  mainText = 'DStv Family for N20000';
                  Navigator.pop(context);
                });
              },
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: Colors.orange,
          ),
          itemCount: 8),
    );
  }
}
