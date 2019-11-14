import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/screens/nav_screens.dart';
import 'package:electronic_emart_vendor/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        pageView(),
        bottomBar(),
      ],
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TertiaryButton(
              text: 'Skip',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigateScreens()),
                );
              },
            ),
            PrimaryButtonWidget(
              buttonText: 'Next',
              onPressed: () {
                if (currentPage == 0) {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
                if (currentPage == 1) {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
                if (currentPage == 2) {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
                if (currentPage == 3) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (val) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget pageView() {
    return PageView(
      controller: pageController,
      children: <Widget>[
        Image.asset(
          'assets/images/onBoardingScreen01.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Image.asset(
          'assets/images/onBoardingScreen02.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Image.asset(
          'assets/images/onBoardingScreen03.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Image.asset(
          'assets/images/onBoardingScreen04.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        )
      ],
      scrollDirection: Axis.horizontal,
      onPageChanged: (val) {
        setState(() {
          currentPage = val;
        });
      },
    );
  }
}
