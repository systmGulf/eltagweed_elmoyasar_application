import 'package:eltagweed_elmoyasar/core/styles/app_colors.dart';
import 'package:eltagweed_elmoyasar/features/home/presentation/views/layout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const EltagweedElmoyasar());
  });
}

class EltagweedElmoyasar extends StatelessWidget {
  const EltagweedElmoyasar({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the brightness of the status bar icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(scaffoldBackgroundColor: AppColors.primaryColor),
            title: 'eltagweed_elmoyasar',
            home: const LayoutScreen()),
      ),
    );
  }
}
