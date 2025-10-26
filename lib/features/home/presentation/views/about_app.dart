import 'package:eltagweed_elmoyasar/core/helpers/app_size.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_colors.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/video.mp4')
      ..initialize().then((_) {
        setState(() {}); 
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/about_app_background.png',
                width: 291.w,
                height: 176.h,
              ),
              verticalSpace(28),
              _videoController.value.isInitialized
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      ),
                  )
                  : const CircularProgressIndicator(color: Colors.white), 
              verticalSpace(22),
              Center(
                child: Image.asset(
                  'assets/images/about_banner.png',
                  width: 390.w,
                  height: 553.h,
                ),
              ),
              verticalSpace(22),
              Text(
                'تم تصميم وبرمجة التطبيق بواسطة',
                style: AppTextStyles.font16Weight400White,
              ),
              Text(
                'Legacy Code',
                style: AppTextStyles.font16Weight400White,
              ),
              Image.asset(
                'assets/images/legacy_code_logo.png',
                width: 51.w,
                height: 51.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          setState(() {
            _videoController.value.isPlaying
                ? _videoController.pause()
                : _videoController.play();
          });
        },
        child: Icon(
          _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
           color: AppColors.blackColor,
        ),
      ),
    );
  }
}
