import 'dart:ui';

import 'package:eltagweed_elmoyasar/core/helpers/app_size.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_text_styles.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/books_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/questions_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/records_screen.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/styles/app_colors.dart';
import '../widgets/bottom_nav_bar_icon.dart';
import '../widgets/custom_drawer.dart';
import 'home_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const QuestionsScreen(),
      const VideosScreen(),
      const BooksScreen(),
      const RecordsScreen(),
      const HomeScreen(),
    ];
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      bottomNavigationBar: IntrinsicHeight(
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              AppTextStyles.font12Weight700White.copyWith(height: 2),
          showUnselectedLabels: false,
          currentIndex: selectedIndex,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          backgroundColor: AppColors.secondaryColor,
          iconSize: 24.w,
          selectedFontSize: 12.sp,
          elevation: 4,
          items: [
            customBottomNavBarIcon(
                icon: 'assets/svg/question.svg', label: "الاسئلة الشائعة"),
            customBottomNavBarIcon(
                icon: 'assets/svg/Video.svg', label: "الفديوهات"),
            customBottomNavBarIcon(icon: 'assets/svg/book.svg', label: "الكتب"),
            customBottomNavBarIcon(
                icon: 'assets/svg/radio.svg', label: " التسجيلات الصوتيه"),
            customBottomNavBarIcon(
                icon: 'assets/svg/Home_icon.svg', label: "الرئيسية"),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
// assets/svg/question.svg
