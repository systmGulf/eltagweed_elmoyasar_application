import 'package:eltagweed_elmoyasar/features/home/presentation/views/tofet_elatfal_audios_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/tofet_elatfal_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart' show SfPdfViewer;
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/methods/internet_conection.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/single_video_container.dart';

class MatnTofetElatfalScreen extends StatefulWidget {
  const MatnTofetElatfalScreen({super.key});

  @override
  State<MatnTofetElatfalScreen> createState() => _MatnTofetElatfalScreenState();
}

class _MatnTofetElatfalScreenState extends State<MatnTofetElatfalScreen> {
  bool isLoading = false;
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
            ),
            SingleVideoContainer(
              image: const AssetImage('assets/images/hqdefault.jpg'),
              title: 'شرح متن تحفة الأطفال',
              subtitle: 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر ',
              onTap: () async {
                isLoading = true;

                setState(() {});
                var internet = await CommonMethods().checkConnectivity(context);
                if (internet) {
                  if (await launchUrl(Uri.parse(
                      'https://youtube.com/playlist?list=PLDO2GIcBczhk7T6VH5hTYokGyN0BHVVCC&si=Zqbar3k2ee_3tNim'))) {
                    isLoading = false;
                    setState(() {});
                    throw Exception('Could not launch ');
                  }
                } else {
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.secondaryColor,
                      content: Text(
                        'لا يوجد اتصال بالانترنت',
                        style: AppTextStyles.font16Weight400Red,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
