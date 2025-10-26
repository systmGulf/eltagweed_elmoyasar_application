import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/qa_item.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.primaryColor, // No Color
        title: Text(
          'الاسئلة في التجويد',
          style: AppTextStyles.font20Weight700SecondaryColor,
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: const SizedBox(),
        actions: const [
          SizedBox(),
        ],
      ),
      body: const TajweedQuizScreen(),
    );
  }
}
