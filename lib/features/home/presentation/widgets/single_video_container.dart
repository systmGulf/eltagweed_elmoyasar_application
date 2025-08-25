import 'package:eltagweed_elmoyasar/core/styles/app_colors.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleVideoContainer extends StatelessWidget {
  const SingleVideoContainer({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.image,
  });
  final String title, subtitle;
  final void Function()? onTap;
  final ImageProvider<Object>? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
          width: 390.w,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: 12.w, top: 5.h, bottom: 5.h, left: 12.w),
                    width: 130.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: image ??
                            const AssetImage(
                                'assets/images/youtube_image.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.03.h,
                    left: 0.w,
                    right: 0.w,
                    child: Image.asset(
                      'assets/images/red_recctangle.png',
                      width: 44.w,
                      height: 44.h,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 12.w, top: 5.h, bottom: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: Text(
                        // 'شرح مذكرة التجويد الميسر للشيخ / عيد سيف',
                        title,
                        style: AppTextStyles.font19Weight400Primary,
                        maxLines: 3,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: Text(
                        // 'Mohammed Hamza | التَجـويِد الـمُـيـسَّـر',
                        subtitle,
                        style: AppTextStyles.font15Weight400Grey,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
