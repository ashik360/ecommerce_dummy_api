import 'package:dummyjson_ecommerce/core/config/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleRowWidget extends StatelessWidget {
  final String titleName;
  final String btnName;
  const TitleRowWidget({
    super.key,
    required this.titleName,
    required this.btnName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: GoogleFonts.inter(
              color: AppColors.nativeBlack,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            btnName,
            style: GoogleFonts.inter(
              color: AppColors.blueBg,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
