import 'dart:async';

import 'package:dummyjson_ecommerce/core/config/utils/constants.dart';
import 'package:dummyjson_ecommerce/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBg,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo),
                  SizedBox(height: 10),
                  Text(
                    AppStrings.welcome,
                    style: GoogleFonts.inter(
                      color: AppColors.nativeWhite,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CircularProgressIndicator(color: AppColors.nativeWhite),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
