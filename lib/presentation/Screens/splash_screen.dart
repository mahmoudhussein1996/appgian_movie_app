import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieapp_appgain/utils/colors.dart';

import 'movies_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState()  {

    Timer(Duration(seconds: 3),

        ()=> Navigator.pushNamed(context, MoviesScreen.routeName));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text("AppGain Movies App", style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
        ),),
      ),
    );
  }
}
