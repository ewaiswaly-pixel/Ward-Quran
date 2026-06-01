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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A4D2E),
          primary: const Color(0xFF1A4D2E),
        ),
        scaffoldBackgroundColor: const Color(0xFFFBF9F1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A4D2E),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const MainTabController(),
    );
  }
}

class MainTabController extends StatelessWidget {
  const MainTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: const Material(
            color: Color(0xFF1A4D2E),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Color(0xFFE8E9A1),
              tabs: [
                Tab(icon: Icon(Icons.menu_book, color: Colors.white), text: 'المصحف الشريف'),
                Tab(icon: Icon(Icons.access_time, color: Colors.white), text: 'مواقيت الصلاة'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              QuranIndexScreen(),
              LivePrayerTimesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

// شاشة فهرس سور القرآن الكريم المطور
class QuranIndexScreen extends StatelessWidget {
  const QuranIndexScreen({super.key});

  static const List<Map<String, dynamic>> quranSuwar = [
    {"id": 1, "name": "الفاتحة", "type": "مكية", "verses": 7},
    {"id": 2, "name": "البقرة", "type": "مدنية", "verses": 286},
    {"id": 3, "name": "آل عمران", "type": "مدنية", "verses": 200},
    {"id": 4, "name": "النساء", "type": "مدنية", "verses": 176},
    {"id": 36, "name": "يس", "type": "مكية", "verses": 83},
    {"id": 67, "name": "الملك", "type": "مكية", "verses": 30},
    {"id": 112, "name": "الإخلاص", "type": "مكية", "verses": 4},
    {"id": 113, "name": "الفلق", "type": "مكية", "verses": 5},
    {"id": 114, "name": "الناس", "type": "مكية", "verses": 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مصحف المدينة المنورة', style: TextStyle(fontWeight: FontWeight.bold)),
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
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFE8E9A1),
                child: Text('${surah['id']}', style: const TextStyle(color: Color(0xFF1A4D2E), fontWeight: FontWeight.bold)),
              ),
              title: Text(surah['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A4D2E))),
              subtitle: Text('${surah['type']} - آياتها ${surah['verses']}', style: const TextStyle(color: Colors.grey)),
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

// شاشة عرض آيات السورة الكريمة بنصوص حقيقية كاملة
class SurahViewScreen extends StatelessWidget {
  final String surahName;
  final int surahId;

  const SurahViewScreen({super.key, required this.surahName, required this.surahId});

  List<String> getSurahVerses(int id) {
    switch (id) {
      case 1:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
          "الرَّحْمَنِ الرَّحِيمِ",
          "مَالِكِ يَوْمِ الدِّينِ",
          "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
          "اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ",
          "صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ"
        ];
      case 112:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "قُلْ هُوَ اللَّهُ أَحَدٌ",
          "اللَّهُ الصَّمَدُ",
          "لَمْ يَلِدْ وَلَمْ يُولَدْ",
          "وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ"
        ];
      case 113:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ",
          "مِن شَرِّ مَا خَلَقَ",
          "وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ",
          "وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ",
          "وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ"
        ];
      case 114:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "قُل * أَعُوذُ بِرَبِّ النَّاسِ",
          "مَلِكِ النَّاسِ",
          "إِلَهِ النَّاسِ",
          "مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ",
          "الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ",
          "مِنَ الْجِنَّةِ وَالنَّاسِ"
        ];
      default:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "جاري إضافة النص الكامل والتشكيل لهذه السورة الكريمة في التحديث القادم لـ وِرْدْ..."
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final verses = getSurahVerses(surahId);
    return Scaffold(
      appBar: AppBar(
        title: Text('سورة $surahName', style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 3,
            color: const Color(0xFFFFFDF6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: List.generate(verses.length, (index) {
                    return TextSpan(
                      text: "${verses[index]} ﴿${index + 1}﴾ ",
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                        height: 2.2,
                        fontFamily: 'Roboto', // يمكنك استبداله بخط عثماني لاحقاً
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// شاشة مواقيت الصلاة الثابتة والمحمية
class LivePrayerTimesScreen extends StatelessWidget {
  const LivePrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateString = "${now.day}-${now.month}-${now.year}";

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A4D2E),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Icon(Icons.calendar_month, color: Color(0xFFE8E9A1), size: 30),
                const SizedBox(height: 8),
                const Text(
                  "١٦ ذو الحجة ١٤٤٧ هـ",
                  style: TextStyle(color: Color(0xFFE8E9A1), fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "التاريخ الحالي: $dateString",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const Divider(color: Colors.white24, height: 20),
                const Text(
                  "التوقيت المحلي المعتمد حسب الحساب القياسي لمصر",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
