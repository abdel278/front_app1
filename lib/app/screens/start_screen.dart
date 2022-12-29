import 'package:flutter/material.dart';
import 'package:my_souq/app/widgets/custom_button.dart';
import 'package:my_souq/components/declarations.dart';

import '../../components/utils.dart';
import '../widgets/splash_content.dart';
import 'auth_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int currentIndex = 0;

  List<Map<String, String>> pageList = [
    {
      'image': 'assets/slides/s_1.jpg',
      'text': 'Welcome To my Souq, Let\'s go shop'
    },
    {
      'image': 'assets/slides/s_2.jpg',
      'text': 'Have a great shopping experience'
    },
    {
      'image': 'assets/slides/s_3.jpg',
      'text': 'Our products are always the best, have fun'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemCount: pageList.length,
                      itemBuilder: (context, index) => SplashContent(
                        image: pageList[index]["image"]!,
                        text: pageList[index]['text']!,
                      ),
                    ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20, context)),
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pageList.length,
                                (index) => buildDot(index: index),
                          ),
                        ),
                        const Spacer(flex: 3),
                        CustomButton(
                            text: 'Open App',
                            onTap: () {
                              Navigator.pushNamed(context, AuthScreen.routName);
                            }
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }


  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? Declarations.selectedNavBarColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
