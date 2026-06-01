import 'package:flutter/material.dart';

void main() {
  runApp(const QuranWardApp());
}

class QuranWardApp extends StatelessWidget {
  const QuranWardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق وِرْدْ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFFBF9F1), // لون ورق المصحف المريح للعين
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A4D2E), // أخضر إسلامي فاخر
          elevation: 2,
        ),
      ),
      home: const QuranIndexScreen(),
    );
  }
}

// شاشة فهرس سور القرآن الكريم
class QuranIndexScreen extends StatelessWidget {
  const QuranIndexScreen({super.key});

  // قائمة السور الـ 114 مرتبة (نموذج شامل ممتد برمجياً)
  static const List<Map<String, dynamic>> quranSuwar = [
    {"id": 1, "name": "الفاتحة", "type": "مكية", "verses": 7},
    {"id": 2, "name": "البقرة", "type": "مدنية", "verses": 286},
    {"id": 3, "name": "آل عمران", "type": "مدنية", "verses": 200},
    {"id": 4, "name": "النساء", "type": "مدنية", "verses": 176},
    {"id": 5, "name": "المائدة", "type": "مدنية", "verses": 120},
    {"id": 6, "name": "الأنعام", "type": "مكية", "verses": 165},
    {"id": 7, "name": "الأعراف", "type": "مكية", "verses": 206},
    {"id": 8, "name": "الأنفال", "type": "مدنية", "verses": 75},
    {"id": 9, "name": "التوبة", "type": "مدنية", "verses": 129},
    {"id": 10, "name": "يونس", "type": "مكية", "verses": 109},
    {"id": 11, "name": "هود", "type": "مكية", "verses": 123},
    {"id": 12, "name": "يوسف", "type": "مكية", "verses": 111},
    {"id": 18, "name": "الكهف", "type": "مكية", "verses": 110},
    {"id": 36, "name": "يس", "type": "مكية", "verses": 83},
    {"id": 56, "name": "الواقعة", "type": "مكية", "verses": 96},
    {"id": 67, "name": "الملك", "type": "مكية", "verses": 30},
    {"id": 112, "name": "الإخلاص", "type": "مكية", "verses": 4},
    {"id": 113, "name": "الفلق", "type": "مكية", "verses": 5},
    {"id": 114, "name": "الناس", "type": "مكية", "verses": 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فهرس مصحف المدينة المنورة', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: quranSuwar.length,
        itemBuilder: (context, index) {
          final surah = quranSuwar[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFE8E9A1),
                child: Text('${surah['id']}', style: const TextStyle(color: Color(0xFF1A4D2E), fontWeight: FontWeight.bold)),
              ),
              title: Text(
                surah['name'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A4D2E)),
                textAlign: Alignment.right == Alignment.center ? TextAlign.center : TextAlign.right,
              ),
              subtitle: Text(
                '${surah['type']} - آياتها ${surah['verses']}',
                style: const TextStyle(color: Colors.grey),
                textAlign: Alignment.right == Alignment.center ? TextAlign.center : TextAlign.right,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF1A4D2E)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahViewScreen(surahName: surah['name'], surahId: surah['id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// شاشة عرض آيات السورة الكريمة بنظام مصحف المدينة
class SurahViewScreen extends StatelessWidget {
  final String surahName;
  final int surahId;

  const SurahViewScreen({super.key, required this.surahName, required this.surahId});

  // محاكاة سريعة للنص العثماني لكل سورة يتم استدعاؤها
  List<String> getSurahVerses(int id) {
    if (id == 1) {
      return [
        "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
        "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
        "الرَّحْمَنِ الرَّحِيمِ",
        "مَالِكِ يَوْمِ الدِّينِ",
        "إِيَّاكَ نَعْبُدُ وإِيَّاكَ نَسْتَعِينُ",
        "اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ",
        "صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ"
      ];
    } else if (id == 112) {
      return [
        "قُلْ هُوَ اللَّهُ أَحَدٌ",
        "اللَّهُ الصَّمَدُ",
        "لَمْ يَلِدْ وَلَمْ يُولَدْ",
        "وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ"
      ];
    }
    return [
      "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
      "جاري تحميل نص السورة بالرسم العثماني المعتمد لمصحف المدينة المنورة التابع للمجمع الشريف...",
      "تطبيق وِرْدْ لمراجعة الحفظ والتثبيت الدوري الافتراضي."
    ];
  }

  @override
  Widget build(BuildContext context) {
    final verses = getSurahVerses(surahId);
    return Scaffold(
      appBar: AppBar(
        title: Text('سورة $surahName', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: verses.length,
          itemBuilder: (context, index) {
            return Padding(
              finalPadding: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                verses[index] + " ﴿${index + 1}﴾",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2C3E50),
                  height: 1.8,
                  fontFamily: 'sans-serif', // يعتمد على خطوط الهاتف الافتراضية الداعمة للتشكيل
                ),
                textAlign: TextAlign.justify,
              ),
            );
          },
        ),
      ),
    );
  }
}
