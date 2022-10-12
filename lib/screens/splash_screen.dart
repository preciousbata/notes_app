import 'package:flutter/material.dart';

import '../constant.dart';
import '../widgets/custom_button.dart';
import 'sign_in_screen.dart';


class SplashScreen extends StatelessWidget {
  static String routeName = '/splashscreen';
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  int currentIndex = 0;
  List<String> imageList = [
    'assets/images/note1.jpg',
    'assets/images/note2.jpg',
    'assets/images/note3.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                itemCount: imageList.length,
                itemBuilder: (context, index) => SplashContent(
                  image: imageList[index],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            imageList.length, (index) => buildCustomDot(index))
                      ],
                    ),
                    const Spacer(flex: 3,),
                    DefaultButton(text: 'Continue',
                      press: (){
                        Navigator.pushNamed(context, SignIn.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomDot(int index) {
    return AnimatedContainer(
      height: 9,
      width: currentIndex == index ? 28 : 9,
      decoration: BoxDecoration(
        color: currentIndex == index ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: animationDuration,
    );
  }
}


class SplashContent extends StatelessWidget {
  final String image;

  const SplashContent({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        const Text(
          'NOTEZZ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColor),
        ),
        const Spacer(
          flex: 2,
        ),
        Image(
          height: 345,
          width: 465,
          image: AssetImage(image),
        ),
      ],
    );
  }
}
