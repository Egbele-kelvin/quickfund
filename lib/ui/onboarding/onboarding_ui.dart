import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/util/app/app_string.dart';
import 'package:quickfund/util/data.dart';
import 'package:quickfund/widget/cumstom_onboarding_slider.dart';

import 'get_started.dart';

class OnBoardingUI extends StatefulWidget {
  @override
  _OnBoardingUIState createState() => _OnBoardingUIState();
}

class _OnBoardingUIState extends State<OnBoardingUI> {
  final PageController _pageController = PageController();
  int page = 0;

  List<SliderModel> slides = List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slides = getSlides();
    _pageController.addListener(() {
      setState(() {
        page = _pageController.page.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //elevation: 0.0,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            itemBuilder: (context, index) {
              return CustomSlider(
                backgroundImage: slides[index].getImage(),
                title: slides[index].getTitle(),
                desc: slides[index].getDesc(),
              );
            },
          ),
          currentIndex != slides.length - 1
              ? Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    // height: Platform.isAndroid? 50 : 50,

                    padding: EdgeInsets.symmetric(horizontal: 10),
                    // color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRouteName.getStarted);
                          },
                          child: Text(AppStrings.appskip,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < slides.length; i++)
                              currentIndex == i
                                  ? pageIndexIndicator(true)
                                  : pageIndexIndicator(false)
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await _pageController
                                .nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInCubic)
                                .then((_) {
                              if (_pageController.page.toInt() == 3) {
                                Navigator.pushReplacementNamed(
                                    context, AppRouteName.getStarted);
                              }
                            });
                            // pageController.animateToPage(slides.length + 1,
                            //     duration: Duration(microseconds: 400),
                            //     curve: Curves.linear);
                          },
                          child: Text(
                            AppStrings.appnext,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : GetStartedUI()
        ],
      ),
    );
  }
}
//
// List<Widget> _onboardpageview() {
//   return <Widget>[
//     OnBoardPageViewUI(
//         vector: AppVectors.onBoardOne,
//         title: AppStrings.onBoardingPageonetitle,
//         title_description: AppStrings.onBoardingPageonesubtitle),
//     OnBoardPageViewUI(
//         vector: AppVectors.onBoardTwo,
//         title: AppStrings.onBoardingPagetwotitle,
//         title_description: AppStrings.onBoardingPagetwosubtitle),
//     OnBoardPageViewUI(
//         vector: AppVectors.onBoardThree,
//         title: AppStrings.onBoardingPagethreetitle,
//         title_description: AppStrings.onBoardingPagethreesubtitle),
//     // OnBoardPageViewUI(
//     //     vector: AppVectors.onBoardFour,
//     //     title: AppStrings.onBoardingPagefourtitle,
//     //     title_description: AppStrings.onBoardingPagefoursubtitle),
//   ];
// }

Widget pageIndexIndicator(bool isCurrentPage) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    height: isCurrentPage ? 10.0 : 6.0,
    width: isCurrentPage ? 10.0 : 6.0,
    decoration: BoxDecoration(
      color: isCurrentPage ? Colors.orange.shade900 : Colors.orange[200],
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
