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
                  // const CompetitionAnnouncement(),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                ],
              ),
            ),
          ))),
    );
  }
}
