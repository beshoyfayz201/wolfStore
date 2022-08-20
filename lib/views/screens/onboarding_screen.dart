import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/models/boarding_model.dart';
import 'package:shoptemp/size_config.dart';
import 'package:shoptemp/views/screens/login_screen.dart';
import 'package:shoptemp/views/screens/signup_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  List<BoradingModel> onboradings = [
    BoradingModel(
        img: "assets/images/onb11.png",
        tit: "welcome to Wolf store",
        sub: "make it easy and get everything you need from home"),
    BoradingModel(
      img: "assets/images/onb22.png",
      tit: "hot offers",
      sub: "we have daily weekly and monthly offers just catch-up with us",
    ),
    BoradingModel(
        img: "assets/images/noitems.png",
        tit: "what are you waiting for",
        sub: "Navigate now"),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    PageController pageController = PageController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  CashHelper.setData("onBoarding", true);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipPath(
              clipper: SinCosineWaveClipper(
                  horizontalPosition: HorizontalPosition.right,
                  verticalPosition: VerticalPosition.top),
              child: Container(
                height: SizeConfig.screenHeight * 0.4,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade200, Colors.green])),
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) =>
                          buildOnBoardingItem(context, index),
                    ),
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(
                          effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white70,
                              dotColor: Colors.grey.shade300),
                          controller: pageController,
                          count: 3),
                      Spacer(),
                      FloatingActionButton(
                        backgroundColor: Colors.blue.shade200,
                        onPressed: () {
                          if (pageController.page == 2) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                            CashHelper.setData("onBoarding", true);
                          }
                          pageController.nextPage(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.decelerate);
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  buildOnBoardingItem(BuildContext context, int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            onboradings[index].img,
            fit: BoxFit.fill,
          ),
          Spacer(),
          Text(
            onboradings[index].tit,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            onboradings[index].sub,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.black87),
          ),
        ],
      );
}
