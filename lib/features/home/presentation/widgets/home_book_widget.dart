import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_size.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class HomeBookWidget extends StatelessWidget {
  const HomeBookWidget({
    super.key,
    required this.bookName,
    required this.onTap,
    required this.imagePath,
    this.backgroundColor,
    this.boxFit,
  });
  final String bookName;
  final VoidCallback onTap;
  final String imagePath;
  final Color? backgroundColor;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(bookName,
            style: AppTextStyles.font20Weight700White.copyWith(
              color: AppColors.secondaryColor,
            )),
        verticalSpace(10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor ?? AppColors.secondaryColor,
              border: Border.all(
                  color: backgroundColor ?? AppColors.secondaryColor,
                  width: 2.w),
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ),
                fit: boxFit ?? BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
