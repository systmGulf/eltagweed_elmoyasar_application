import 'package:eltagweed_elmoyasar/core/helpers/app_size.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/methods/internet_conection.dart';
import '../../../../core/styles/app_colors.dart';
import '../widgets/single_video_container.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

bool isLoading = false;

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    final videosItems = [
      SingleVideoContainer(
        title: 'شرح مذكرة التجويد الميسر للشيخ / أحمد وجيه',
        subtitle: 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر ',
        onTap: () async {
          isLoading = true;

          setState(() {});
          var internet = await CommonMethods().checkConnectivity(context);
          if (internet) {
            if (await launchUrl(Uri.parse(
                'https://www.youtube.com/playlist?list=PLDO2GIcBczhkNwbNoelYFZodRPC0SbH76'))) {
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
      ),
      SingleVideoContainer(
        title: 'شرح مذكرة التجويد الميسر للشيخ / عيد سيف',
        subtitle: 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر ',
        onTap: () async {
          isLoading = true;

          setState(() {});
          var internet = await CommonMethods().checkConnectivity(context);
          if (internet) {
            if (await launchUrl(Uri.parse(
                'https://www.youtube.com/playlist?list=PLDO2GIcBczhnuhzq8hsd_24Q37YAkywpk'))) {
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
      ),
      SingleVideoContainer(
        title: 'مذكرة التجويد الميسر بصوت | الشيخ / عمر عبد الرحمن',
        subtitle: 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر ',
        onTap: () async {
          isLoading = true;

          setState(() {});
          var internet = await CommonMethods().checkConnectivity(context);
          if (internet) {
            if (await launchUrl(Uri.parse(
                'https://www.youtube.com/playlist?list=PLDO2GIcBczhkB23BRrXMOgpjYTA1pqYFC'))) {
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
      ),
      SingleVideoContainer(
        image: const AssetImage('assets/images/studio_square_thumbnail.jpg'),
        title: 'متن تحفة الأطفال بصوت محمد حمزة البرماوى',
        subtitle: 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر ',
        onTap: () async {
          isLoading = true;

          setState(() {});
          var internet = await CommonMethods().checkConnectivity(context);
          if (internet) {
            if (await launchUrl(Uri.parse(
                'https://www.youtube.com/playlist?list=PLDO2GIcBczhmcAeFibxnyre9yxVW6TOhY'))) {
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
      ),
      SingleVideoContainer(
        image:
            const AssetImage('assets/images/studio_square_thumbnail (1).jpg'),
        title: 'متن الجزرية بصوت محمد حمزة البرماوى',
        subtitle: 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر ',
        onTap: () async {
          isLoading = true;

          setState(() {});
          var internet = await CommonMethods().checkConnectivity(context);
          if (internet) {
            if (await launchUrl(Uri.parse(
                'https://www.youtube.com/playlist?list=PLDO2GIcBczhmfDmIBqgl0s_q6KMgyHV9f'))) {
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
    ];
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "eltagweed_elmoyasar/assets/images/home_backgroud_image.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    verticalSpace(101),
                    Text(
                      'الفيديوهات',
                      style: AppTextStyles.font32Weight400SecondaryColor,
                    ),
                    verticalSpace(26),
                    Expanded(
                      child: ListView.builder(
                          itemCount: videosItems.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: videosItems[index],
                            );
                          }),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
