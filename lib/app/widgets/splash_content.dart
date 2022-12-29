import 'package:flutter/material.dart';
import '../../components/utils.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "My SOUQ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36, context),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265, context),
          width: getProportionateScreenWidth(235, context),
        ),
      ],
    );
  }
}