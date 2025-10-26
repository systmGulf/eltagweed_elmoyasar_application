import 'package:just_audio/just_audio.dart';

class AudioPlayerController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  LockCachingAudioSource? _audioSource;

  /// يتم استدعاؤه عند اكتمال تشغيل المقطع الصوتي
  Function()? onComplete;

  /// بث التقدم في التشغيل
  Stream<int> get progressStream => _audioPlayer.positionStream.map((progress) {
        return progress.inMilliseconds;
      });

  /// سرعة التشغيل
  Future<void> setSpeed(double speed) async {
    if (speed <= 0.0) {
      throw ArgumentError.value(speed, 'speed', 'Must be greater than 0.0.');
    }
    await _audioPlayer.setSpeed(speed);
  }

  /// المدة الكاملة للمقطع الصوتي
  int get durationInMill => _audioPlayer.duration?.inMilliseconds ?? 0;

  /// بث حالة التشغيل (تشغيل / إيقاف)
  Stream<bool> get playStatusStream => _audioPlayer.playingStream;

  /// تحميل الصوت وتشغيله
  Future<void> loadAudio(String url) async {
    if (url.isEmpty) {
      throw ArgumentError.value(url, 'url', 'Must not be empty.');
    }
    _audioSource = LockCachingAudioSource(Uri.parse(url));
    await _audioPlayer.setAudioSource(_audioSource!);
    await _audioPlayer.load();

    // الاستماع لانتهاء الصوت
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (onComplete != null) {
          onComplete!();
        }
      }
    });

    _audioPlayer.play();
  }

  /// مسح الكاش الخاص بالصوت
  Future<void> clearCache() async {
    await _audioSource?.clearCache();
  }

  /// تشغيل الصوت
  void play() {
    _audioPlayer.play();
  }

  /// إعادة التشغيل من البداية
  void replay() {
    _audioPlayer.seek(Duration.zero);
    _audioPlayer.play();
  }

  /// إيقاف مؤقت
  void pause() {
    _audioPlayer.pause();
  }

  /// إيقاف نهائي
  void stop() {
    _audioPlayer.stop();
  }

  /// الانتقال إلى وقت معين
  void seek(int durationInMill) {
    _audioPlayer.seek(Duration(milliseconds: durationInMill));
  }

  /// التخلص من الموارد
  void dispose() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
  }
}
