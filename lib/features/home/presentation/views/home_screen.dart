import 'package:eltagweed_elmoyasar/features/home/presentation/views/matn_elgazarya_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/matn_tofet_elatfal_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/questions_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/widgets/tablet_home_screen_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_size.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/competition_announcemnt.dart';
import '../widgets/competition_widget.dart';
import '../widgets/home_book_widget.dart';
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionsScreen()));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        HomeBookWidget(
                            bookName: 'بنك اسئله في التجويد',
                            onTap: () {},
                            boxFit: BoxFit.fill,
                            backgroundColor: AppColors.thirdColor,
                            imagePath:
                                "assets/images/8665c9b242c23e4c41be1268d8cf565a.jpg"),
                        Positioned(
                          top: 20.h,
                          right: 20.w,
                          child: Image.asset(
                            "assets/images/welcome 1.png",
                            width: 200.w,
                            height: 200.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(16),
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
                        child: HomeBookWidget(
                          bookName: "متن الجزرية",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MatnElgazaryaScreen()));
                          },
                          imagePath: "assets/images/elgzara.jpeg",
                        ),
                      ),
                      horizontalSpace(20),
                      Expanded(
                          child: HomeBookWidget(
                        bookName: "متن تحفة الأطفال",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MatnTofetElatfalScreen()));
                        },
                        imagePath: "assets/images/rawdt_elatfal.jpeg",
                      )),
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
