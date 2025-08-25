import 'package:eltagweed_elmoyasar/features/home/presentation/views/matn_elgazarya_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/matn_tofet_elatfal_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/widgets/tablet_home_screen_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_size.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/competition_announcemnt.dart';
import '../widgets/competition_widget.dart';
import '../widgets/home_grid_view.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home_backgroud_image.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(Icons.menu,
                            color: AppColors.secondaryColor),
                      )),
                  verticalSpace(30),
                  Text("التجويد الميسر",
                      style: AppTextStyles.font36Weight700White),
                  verticalSpace(36),
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return const MobileHomeGridView();
                    } else {
                      return const TabletHomeListView();
                    }
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("متن الجزرية",
                                style:
                                    AppTextStyles.font20Weight700White.copyWith(
                                  color: AppColors.secondaryColor,
                                )),
                            verticalSpace(10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MatnElgazaryaScreen()));
                              },
                              child: Container(
                                height: 180.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.secondaryColor,
                                  border: Border.all(
                                      color: AppColors.secondaryColor,
                                      width: 2.w),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/elgzara.jpeg"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(20),
                      Expanded(
                        child: Column(
                          children: [
                            Text("متن التحفة الأطفال",
                                style:
                                    AppTextStyles.font20Weight700White.copyWith(
                                  color: AppColors.secondaryColor,
                                )),
                            verticalSpace(10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MatnTofetElatfalScreen()));
                              },
                              child: Container(
                                height: 180.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.secondaryColor,
                                  border: Border.all(
                                      color: AppColors.secondaryColor,
                                      width: 2.w),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/rawdt_elatfal.jpeg",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
          ))),
    );
  }
}
