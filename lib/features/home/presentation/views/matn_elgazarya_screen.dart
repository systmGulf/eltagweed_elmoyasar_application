import 'package:eltagweed_elmoyasar/core/helpers/app_size.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/elgzarya_audios_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/elzarya_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class MatnElgazaryaScreen extends StatelessWidget {
  const MatnElgazaryaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor, // No Color
          title: Text(
            'متن الجزرية',
            style: AppTextStyles.font20Weight700SecondaryColor,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: const SizedBox(),
          actions: const [
            SizedBox(),
          ],
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ElgzaryaAudiosScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColors.secondaryColor, width: 2.w),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        height: 50.h,
                        child: Image.asset('assets/images/Play_audio.png')),
                    const Spacer(),
                    Text(
                      'صوتيات متن الجزرية',
                      style: AppTextStyles.font20Weight700SecondaryColor,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ElzaryaBookScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColors.secondaryColor, width: 2.w),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        height: 50.h,
                        child: Image.asset('assets/images/book.png')),
                    const Spacer(),
                    Text(
                      'كتاب متن الجزرية',
                      style: AppTextStyles.font20Weight700SecondaryColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
  // return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: AppColors.primaryColor, // No Color
  //         title: Text(
  //           'متن الجزرية ',
  //           style: AppTextStyles.font20Weight700SecondaryColor,
  //         ),
  //         centerTitle: true,
  //         elevation: 0.0,
  //         leading: const SizedBox(),
  //         actions: const [
  //           SizedBox(),
  //         ],
  //       ),
  //       body: SafeArea(
  //         child: SfPdfViewer.asset(
  //           'assets/pdf/الجزرية1.pdf',
  //         ),
  //       ));
  // }