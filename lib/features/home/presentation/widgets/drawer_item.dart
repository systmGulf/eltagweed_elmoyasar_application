import 'package:eltagweed_elmoyasar/core/styles/app_text_styles.dart';
import 'package:eltagweed_elmoyasar/core/widgets/drawer_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    this.imageWidth = 24,
    this.imageColor = Colors.white,
    this.isCustomImage = false,
  });
  final String image, title;
  final VoidCallback onTap;
  final double imageWidth;
  final Color imageColor;
  final bool isCustomImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              image,
              height: 30.h,
              width: isCustomImage ? imageWidth : null,
              color: isCustomImage ? imageColor : null,
              theme: const SvgTheme(currentColor: Colors.red),
            ),
            TextButton(
              onPressed: onTap,
              child: Text(
                title,
                style: AppTextStyles.font15Weight400Grey
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        const DrawerDivider(),
      ],
    );
  }
}
