import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class TofetElatfalBook extends StatelessWidget {
  const TofetElatfalBook({super.key});

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
        body: SafeArea(
          child: SfPdfViewer.asset(
            'assets/pdf/تحفة الاطفال.pdf',
          ),
        ));

  }
}