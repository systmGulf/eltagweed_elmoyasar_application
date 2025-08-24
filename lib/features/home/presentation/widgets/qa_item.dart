import 'dart:convert';
import 'package:eltagweed_elmoyasar/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/tajweed_questions.json');
    final data = json.decode(response);

    setState(() {
      questions = List<Map<String, dynamic>>.from(data);
    });
  }

  // تحويل الأرقام إلى أرقام عربية
  String convertToArabicNumber(int number) {
    const arabicNumbers = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
    String numStr = number.toString();
    String arabicNum = "";
    for (var ch in numStr.split('')) {
      arabicNum += arabicNumbers[int.parse(ch)];
    }
    return arabicNum;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E1E),
        body: questions.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView.builder(
                itemCount: questions.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final item = questions[index];
                  final arabicIndex = convertToArabicNumber(index + 1);

                  return Card(
                    color: const Color.fromARGB(255, 46, 45, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Text(
                            "$arabicIndex - ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item["question"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            item["answer"] ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
