import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/helpers/app_size.dart';
import '../../../../core/methods/internet_conection.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../widgets/audio_player_widget.dart';

class ElgzaryaAudiosScreen extends StatefulWidget {
  const ElgzaryaAudiosScreen({super.key});

  @override
  State<ElgzaryaAudiosScreen> createState() => _ElgzaryaAudiosScreenState();
}

class _ElgzaryaAudiosScreenState extends State<ElgzaryaAudiosScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, String>> _audios = [];

  @override
  void initState() {
    super.initState();
    _fetchAudios();
  }

  bool isLoading = false;

  Future<void> _fetchAudios() async {
    setState(() {
      isLoading = true;
    });
    var internet = await CommonMethods().checkConnectivity(context);
    if (!internet) {
      isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondaryColor,
          content: Text(
            'لا يوجد اتصال بالانترنت',
            style: AppTextStyles.font16Weight400Red,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    QuerySnapshot snapshot =
        await _firestore.collection('tohfet-elatfal').get();
    List<Map<String, String>> audioList = [];
    for (var doc in snapshot.docs) {
      audioList.add({
        'title': doc['title'],
        'url': doc['url'],
      });
    }
    setState(() {
      _audios = audioList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/records_backgroud_image.png"),
                fit: BoxFit.fill),
          ),
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            // color: Colors.transparent,
            progressIndicator:
                const CircularProgressIndicator(color: Colors.white),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SingleChildScrollView(
                    child: Column(children: [
                  verticalSpace(101),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('صوتيات متن الجزرية',
                          style: AppTextStyles.font32Weight400SecondaryColor),
                    ],
                  ),
                  verticalSpace(16),
                  Column(
                      children: List.generate(_audios.length, (int index) {
                    final audio = _audios[index];
                    return AudioPlayerWidget(
                        path: audio['url']!, title: audio['title']!);
                  }))
                ]))),
          ),
        ),
      ),
    );
  }
}
