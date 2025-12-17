import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:v1/controllers/auth_controller.dart';
import 'package:v1/prefs/theme.dart';
import 'package:v1/widgets/MorphSwitch.dart';
import 'package:v1/widgets/PrimaryButton.dart';
import 'package:v1/widgets/SecondaryButton.dart';
import 'package:v1/widgets/ShadowButton.dart';

class CircleBlurPainter extends CustomPainter {
  final BuildContext context;
  CircleBlurPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final Size mqs = MediaQuery.of(context).size;
    Paint line = new Paint()
      ..color = kPrimaryLight
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = mqs.width * 0.5
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final Random _rand = Random();
  late Alignment _orb1, _orb2, _orb3;
  Alignment _randomCorner(current) {
    final corners = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
    ];
    corners.remove(current);
    return corners[_rand.nextInt(corners.length)];
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _orb1 = _randomCorner(Alignment.topLeft);
      _orb2 = _randomCorner(Alignment.bottomRight);
      _orb3 = _randomCorner(Alignment.center);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer.run(() {
      setState(() {
        _orb1 = _randomCorner(_orb1);
        _orb2 = _randomCorner(_orb2);
        _orb3 = _randomCorner(_orb3);
      });
    });
    Timer.periodic(const Duration(seconds: 5), (t) {
      setState(() {
        _orb1 = _randomCorner(_orb1);
        _orb2 = _randomCorner(_orb2);
        _orb3 = _randomCorner(_orb3);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider.notifier);
    final Size mqs = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Decoration Widgets
          Container(color: kSoftBlack),
          AnimatedAlign(
            alignment: _orb1,
            curve: Curves.linear,
            duration: Duration(milliseconds: 5000),
            child: SizedBox(
              width: mqs.width * 0.5,
              height: mqs.width * 0.5,

              child: CustomPaint(painter: CircleBlurPainter(context)),
            ),
          ),
          AnimatedAlign(
            alignment: _orb2,
            curve: Curves.linear,
            duration: Duration(milliseconds: 6000),
            child: SizedBox(
              width: mqs.width * 0.5,
              height: mqs.width * 0.5,

              child: CustomPaint(painter: CircleBlurPainter(context)),
            ),
          ),
          AnimatedAlign(
            alignment: _orb3,
            curve: Curves.linear,
            duration: Duration(milliseconds: 8000),
            child: SizedBox(
              width: mqs.width * 0.5,
              height: mqs.width * 0.5,

              child: CustomPaint(painter: CircleBlurPainter(context)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: mqs.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                    child: Container(
                      width: mqs.width * 0.9,
                      height: mqs.height * 0.4,
                      decoration: BoxDecoration(
                        color: kSoftBlack.withValues(alpha: 0.4),
                        border: Border.all(color: kCream, width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: kSoftBlack.withValues(alpha: 0.2),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlutterLogo(),
                                Spacer(),
                                ShadowButton(
                                  title: "Sign Up",
                                  onPressed: () {
                                    authController.setAuthMode(AuthMode.SIGNUP);
                                  },
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "Log in",
                              style: TextStyle(
                                color: kCream,
                                fontFamily: kEnglishPrimaryFont,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gap(20),
                            TextField(
                              style: TextStyle(color: kCream),
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: kCream),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kCream,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            Gap(12),
                            TextField(
                              obscureText: true,
                              style: TextStyle(color: kCream),
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  margin: EdgeInsets.only(right: 12),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: kPrimary,
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  width: mqs.width * 0.25,
                                  height: mqs.height * 0.05,
                                  child: PrimaryButton(
                                    title: "Forget",
                                    onPressed: () {},
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: kCream),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kCream,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Remember my data",
                                  style: TextStyle(
                                    color: kCream,
                                    fontFamily: kEnglishPrimaryFont,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                MorphSwitch(
                                  width: 60,
                                  initialValue: false,
                                  onChanged: (val) {},
                                ),
                              ],
                            ),
                            Spacer(),
                            Center(
                              child: ShadowButton(
                                title: "Click here for more info",
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(12),
                  Container(
                    width: mqs.width * 0.9,
                    height: mqs.height * 0.15,
                    decoration: BoxDecoration(
                      color: kSoftBlack,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Login with Social Media",
                            style: TextStyle(
                              color: kCream,
                              fontFamily: kEnglishPrimaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SocialButton(
                                mini: true,
                                buttonColor: kPrimaryLight,
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  FontAwesomeIcons.facebookF,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                label: 'Login With Facebook',
                                onTap: () {
                                  // authController.signInWithFacebook();
                                },
                              ),
                              Gap(8),
                              SocialButton(
                                buttonColor: kPrimaryLight,
                                mini: true,
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                label: 'Login With Google',
                                onTap: () {
                                  // authController.signInWithGoogle();
                                },
                              ),
                              Gap(8),
                              SocialButton(
                                buttonColor: kPrimaryLight,
                                mini: true,
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                label: 'Login With Google',
                                onTap: () {
                                  // authController.signInWithGithub();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
