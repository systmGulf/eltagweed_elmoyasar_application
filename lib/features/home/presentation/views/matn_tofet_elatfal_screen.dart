import 'package:eltagweed_elmoyasar/features/home/presentation/views/tofet_elatfal_audios_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/tofet_elatfal_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart' show SfPdfViewer;

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class MatnTofetElatfalScreen extends StatelessWidget {
  const MatnTofetElatfalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor, // No Color
          title: Text(
            'متن تحفة الأطفال',
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
                        builder: (context) =>
                            const TofetElatfalAudiosScreen()));
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
                      'صوتيات متن تحفه الأطفال',
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
                        builder: (context) => const TofetElatfalBook()));
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
                      'كتاب  متن تحفه الأطفال',
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
