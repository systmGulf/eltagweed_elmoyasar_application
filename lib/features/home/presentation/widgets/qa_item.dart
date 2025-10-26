import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

/// ====================
/// COLORS & STYLES
/// ====================
const Color primaryColor = Color(0xFF202020);
const Color secondaryColor = Color(0XffE2BE7F);
const List<String> arabicOptionLetters = ['أ', 'ب', 'ج', 'د'];

/// ====================
/// Groups Screen
/// ====================
class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  List<dynamic> allQuestions = [];
  int groupsCount = 0;
  Map<int, bool> completed = {}; // groupIndex -> completed
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  Future<void> _initAll() async {
    await _loadQuestions();
    await _loadCompletion();
    setState(() => loading = false);
  }

  Future<void> _loadQuestions() async {
    final raw = await rootBundle.loadString('assets/tajweed_questions.json');
    final data = json.decode(raw) as List<dynamic>;
    allQuestions = data;
    // groups of 50
    groupsCount = (allQuestions.length / 50).ceil();
  }

  Future<void> _loadCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<int, bool> tmp = {};
    for (int i = 0; i < (allQuestions.length / 50).ceil(); i++) {
      tmp[i] = prefs.getBool('group_completed_$i') ?? false;
    }
    setState(() {
      completed = tmp;
    });
  }

  // called after finishing a group to refresh completion states
  Future<void> _refreshCompletion() async {
    await _loadCompletion();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: secondaryColor)),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: groupsCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final isDone = completed[index] ?? false;
            // build range text
            final start = index * 50 + 1;
            final end = ((index + 1) * 50).clamp(1, allQuestions.length);
            return InkWell(
              onTap: () async {
                // open quiz screen and wait for return to refresh
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TajweedQuizScreen(
                      groupIndex: index,
                      allQuestions: allQuestions,
                    ),
                  ),
                );
                // refresh completion flags when back
                await _refreshCompletion();
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 3))
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('المجموعة ${index + 1}',
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('$start - $end',
                        style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 12),
                    if (isDone)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 6),
                          Text('مكتمل',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    else
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TajweedQuizScreen(
                                groupIndex: index,
                                allQuestions: allQuestions,
                              ),
                            ),
                          );
                          await _refreshCompletion();
                        },
                        child: const Text('ابدأ'),
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ====================
/// Quiz Screen (same UI as requested)
/// ====================
class TajweedQuizScreen extends StatefulWidget {
  final int groupIndex;
  final List<dynamic> allQuestions;

  const TajweedQuizScreen({
    super.key,
    required this.groupIndex,
    required this.allQuestions,
  });

  @override
  State<TajweedQuizScreen> createState() => _TajweedQuizScreenState();
}

class _TajweedQuizScreenState extends State<TajweedQuizScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> _questions = [];
  Map<int, int> _selected =
      {}; // questionIndex -> optionIndex (local index 0..49)
  Set<int> _answered = {};
  int _currentIndex = 0; // 0..(_questions.length-1)
  int _score = 0;
  bool _loading = true;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
    _prepareGroup();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _prepareGroup() {
    // slice group from allQuestions
    final start = widget.groupIndex * 50;
    final end = (start + 50).clamp(0, widget.allQuestions.length);
    _questions = widget.allQuestions.sublist(start, end);
    setState(() {
      _loading = false;
    });
    _animController.forward();
  }

  void _selectOption(int qIndex, int optIndex) {
    if (_answered.contains(qIndex)) return;

    final correctAnswer = _questions[qIndex]['correct_answer'];
    final chosen = _questions[qIndex]['options'][optIndex];

    setState(() {
      _selected[qIndex] = optIndex;
      _answered.add(qIndex);
      if (chosen == correctAnswer) {
        _score += 1;
      }
    });

    final isCorrect = chosen == correctAnswer;
    // SnackBar on the right, Arabic text
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isCorrect ? Colors.green[700] : Colors.red[700],
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            isCorrect ? 'صح جزاك الله خير ❤️' : 'خطأ انظر للإجابة الصحيحة',
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        duration: const Duration(milliseconds: 1000),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _next() {
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
      _animController.forward(from: 0.0);
    } else {
      _onFinish();
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _animController.forward(from: 0.0);
    }
  }

  Future<void> _onFinish() async {
    await _markGroupCompleted();
    _showResultDialog();
  }

  Future<void> _markGroupCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('group_completed_${widget.groupIndex}', true);
  }

  void _showResultDialog() {
    final total = _questions.length;
    final percent = total == 0 ? 0 : (_score / total * 100).round();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2E2E2E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Center(
              child: Text('النتيجة النهائية',
                  style: TextStyle(color: Colors.white))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('أجبت $_score من $total سؤال',
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: percent / 100,
                minHeight: 10,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation<Color>(secondaryColor),
              ),
              const SizedBox(height: 8),
              Text('$percent %',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child:
                  const Text('مراجعة', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
              onPressed: () {
                Navigator.pop(ctx);
                _restart();
              },
              child: const Text('إعادة المحاولة',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _restart() {
    setState(() {
      _selected.clear();
      _answered.clear();
      _score = 0;
      _currentIndex = 0;
    });
    _animController.forward(from: 0.0);
  }

  String _arabicIndex(int n) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    final s = n.toString();
    final sb = StringBuffer();
    for (var ch in s.split('')) sb.write(arabicDigits[int.parse(ch)]);
    return sb.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
          body:
              Center(child: CircularProgressIndicator(color: secondaryColor)));
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: const BackButton(color: Colors.white),
          title: Text(
              'المجموعة ${widget.groupIndex + 1}, السؤال ${_arabicIndex(_currentIndex + 1)}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: (_currentIndex + 1) / _questions.length,
                minHeight: 8,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation<Color>(secondaryColor),
              ),
              const SizedBox(height: 12),
              FadeTransition(
                opacity: _fadeAnim,
                child: Card(
                  color: const Color(0xFF1F1F1F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: secondaryColor,
                              child: Text(_arabicIndex(_currentIndex + 1),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _questions[_currentIndex]['question'] ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ...List.generate(
                            (_questions[_currentIndex]['options'] as List)
                                .length, (optIndex) {
                          final optionText =
                              _questions[_currentIndex]['options'][optIndex];
                          final correct =
                              _questions[_currentIndex]['correct_answer'];
                          final isSelected =
                              _selected[_currentIndex] == optIndex;
                          final hasAnswered = _answered.contains(_currentIndex);

                          Color borderColor = Colors.white24;
                          Color textColor = Colors.white;
                          Color fillColor = Colors.transparent;

                          if (hasAnswered) {
                            if (optionText == correct) {
                              borderColor = Colors.green;
                              textColor = Colors.green;
                              fillColor = Colors.green.withOpacity(0.08);
                            } else if (isSelected && optionText != correct) {
                              borderColor = Colors.red;
                              textColor = Colors.red;
                              fillColor = Colors.red.withOpacity(0.06);
                            } else {
                              borderColor = Colors.white12;
                              textColor = Colors.white70;
                            }
                          }

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: fillColor,
                                side: BorderSide(color: borderColor),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                              onPressed: hasAnswered
                                  ? null
                                  : () {
                                      _selectOption(_currentIndex, optIndex);
                                    },
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: const BoxDecoration(
                                        color: secondaryColor,
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: Text(arabicOptionLetters[optIndex],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: Text(optionText,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: textColor, fontSize: 16))),
                                  if (hasAnswered && optionText == correct)
                                    const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.check_circle,
                                            color: Colors.green)),
                                  if (hasAnswered &&
                                      isSelected &&
                                      optionText != correct)
                                    const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.cancel,
                                            color: Colors.red)),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _prev,
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white70),
                      label: const Text('السابق',
                          style: TextStyle(color: Colors.white70)),
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white12),
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _next,
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      label: Text(
                          _currentIndex == _questions.length - 1
                              ? 'أنهِ الاختبار'
                              : 'التالي',
                          style: const TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _showResultDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('عرض النتيجة الحالية',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجابات: ${_answered.length}/${_questions.length}',
                      style: const TextStyle(color: Colors.white70)),
                  Text('الدرجة: $_score',
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
