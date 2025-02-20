import 'package:flutter/material.dart';
import 'package:flutter_fe/view/welcome_page/intro_page_1.dart';
import 'package:flutter_fe/view/welcome_page/intro_page_2.dart';
import 'package:flutter_fe/view/welcome_page/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePageViewMain extends StatefulWidget {
  const WelcomePageViewMain({super.key});

  @override
  State<WelcomePageViewMain> createState() => _WelcomePageViewMainState();
}

class _WelcomePageViewMainState extends State<WelcomePageViewMain> {
  PageController _controller = new PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text(
                        'skip',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: SwapEffect(
                        activeDotColor: Color(0xFF0272B1),
                        dotColor: Colors.white),
                  ),
                  onLastPage
                      ? GestureDetector(
                          onTap: () {},
                          child: Text(
                            'done',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(
                            'next',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                ],
              ))
        ],
      ),
    );
  }
}
