import 'package:eltagweed_elmoyasar/core/methods/audio_player_service.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_colors.dart';
import 'package:eltagweed_elmoyasar/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'play_pause_button.dart';

class AudioPlayerView extends StatefulWidget {
  final String path, title;
  const AudioPlayerView({
    super.key,
    required this.path,
    required this.title,
  });

  @override
  State<AudioPlayerView> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  final audioPlayerController = AudioPlayerController();
  late final Future loadAudio;
  double? sliderTempValue;

  bool isRepeating = false;
  int repeatCount = 0;
  int maxRepeats = 3;

  @override
  void initState() {
    super.initState();
    loadAudio = audioPlayerController.loadAudio(widget.path);

    audioPlayerController.onComplete = () async {
      if (isRepeating) {
        if (repeatCount < maxRepeats - 1) {
          repeatCount++;
          audioPlayerController.seek(0);
          audioPlayerController.play();
          setState(() {});
        } else {
          setState(() {
            isRepeating = false;
            repeatCount = 0;
          });
          audioPlayerController.pause();
          audioPlayerController.seek(0);
        }
      }
    };
  }

  @override
  void dispose() {
    audioPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAudio,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: AppColors.secondaryColor,
              strokeWidth: 3,
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('خطأ في تشغيل التسجيل تحقق من اتصالك بالانترنت'),
          );
        }

        final audioDuration = audioPlayerController.durationInMill.toDouble();

        return StreamBuilder(
          stream: audioPlayerController.progressStream,
          builder: (context, snapshot) {
            double progress = (snapshot.data ?? 0).toDouble();

            return Column(
              children: [
                SizedBox(height: 12.h),
                Text(
                  widget.title,
                  style: AppTextStyles.font16Weight400Red
                      .copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(height: 10),
                Slider(
                  value: sliderTempValue ?? progress.clamp(0, audioDuration),
                  min: 0,
                  max: audioDuration,
                  onChanged: (value) {
                    setState(() {
                      sliderTempValue = value;
                    });
                  },
                  onChangeStart: (_) => audioPlayerController.pause(),
                  onChangeEnd: (value) {
                    audioPlayerController.seek(value.toInt());
                    sliderTempValue = null;
                    audioPlayerController.play();
                  },
                  activeColor: AppColors.primaryColor,
                ),
                Row(
                  children: [
                    PopupMenuButton<double>(
                      onSelected: (value) async {
                        await audioPlayerController.setSpeed(value);
                      },
                      itemBuilder: (context) => [
                        _buildPopupMenuItem(1.0, '1x'),
                        const PopupMenuDivider(height: 1),
                        _buildPopupMenuItem(1.25, '1.25x'),
                        const PopupMenuDivider(height: 1),
                        _buildPopupMenuItem(1.5, '1.5x'),
                        const PopupMenuDivider(height: 1),
                        _buildPopupMenuItem(1.75, '1.75x'),
                        const PopupMenuDivider(height: 1),
                        _buildPopupMenuItem(2.0, '2x'),
                      ],
                      color: AppColors.primaryColor,
                      offset: const Offset(-10, 40),
                      child: Text(
                        'Speed',
                        style: AppTextStyles.font16Weight400White
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatToDateTime(progress.toInt()),
                      style: AppTextStyles.font16Weight400White
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // الأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.replay,
                        color:
                            isRepeating ? AppColors.primaryColor : Colors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        if (isRepeating) {
                          // لو مفعل التكرار، نوقفه
                          setState(() {
                            isRepeating = false;
                            repeatCount = 0;
                          });
                        } else {
                          // المستخدم يختار عدد مرات التكرار
                          int? selected = await showDialog<int>(
                            context: context,
                            builder: (context) {
                              int temp = maxRepeats;
                              return AlertDialog(
                                backgroundColor: AppColors.secondaryColor,
                                title: const Text(
                                  'عدد مرات التكرار',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: StatefulBuilder(
                                  builder: (context, setInnerState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Slider(
                                          value: temp.toDouble(),
                                          min: 1,
                                          max: 10,
                                          divisions: 9,
                                          label: temp.toString(),
                                          activeColor: AppColors.primaryColor,
                                          inactiveColor: Colors.grey,
                                          onChanged: (val) {
                                            setInnerState(() {
                                              temp = val.toInt();
                                            });
                                          },
                                        ),
                                        Text(
                                          '$temp مرات',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, null),
                                    child: const Text('إلغاء',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, temp),
                                    child: const Text('تأكيد',
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              );
                            },
                          );

                          if (selected != null) {
                            setState(() {
                              maxRepeats = selected;
                              repeatCount = 0;
                              isRepeating = true;
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    StreamBuilder(
                      stream: audioPlayerController.playStatusStream,
                      builder: (context, snapshot) {
                        final bool isPlaying = snapshot.data ?? false;
                        return PlayPauseButton(
                          isPlaying: isPlaying,
                          onTap: () {
                            if (isPlaying) {
                              audioPlayerController.pause();
                            } else {
                              audioPlayerController.play();
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),

                // نص العداد
                if (isRepeating)
                  Text(
                    'تكرار ${repeatCount + 1} من $maxRepeats',
                    style: AppTextStyles.font16Weight400White.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

String _formatToDateTime(int durationInMill) {
  final int minutes = durationInMill ~/ Duration.millisecondsPerMinute;
  final int seconds = (durationInMill % Duration.millisecondsPerMinute) ~/
      Duration.millisecondsPerSecond;

  return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
}

PopupMenuItem<double> _buildPopupMenuItem(double value, String text) {
  return PopupMenuItem<double>(
    value: value,
    child: Text(
      text,
      style: AppTextStyles.font15Weight700Primary.copyWith(color: Colors.white),
    ),
  );
}
