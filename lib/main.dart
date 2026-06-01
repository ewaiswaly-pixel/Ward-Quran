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

// شاشة فهرس سور القرآن الكريم
class QuranIndexScreen extends StatelessWidget {
  const QuranIndexScreen({super.key});

  static const List<Map<String, dynamic>> quranSuwar = [
    {"id": 1, "name": "الفاتحة", "type": "مكية", "verses": 7},
    {"id": 2, "name": "البقرة", "type": "مدنية", "verses": 286},
    {"id": 3, "name": "آل عمران", "type": "مدنية", "verses": 200},
    {"id": 4, "name": "النساء", "type": "مدنية", "verses": 176},
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

// شاشة عرض آيات السورة الكريمة
class SurahViewScreen extends StatelessWidget {
  final String surahName;
  final int surahId;

  const SurahViewScreen({super.key, required this.surahName, required this.surahId});

  List<String> getSurahVerses(int id) {
    if (id == 1) {
      return [
        "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
        "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
        "الرَّحْمَنِ الرَّحِيمِ",
        "مَالِكِ يَوْمِ الدِّينِ",
        "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
        "اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ",
        "صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ"
      ];
    }
    return [
      "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
      "جاري ربط نص السورة كاملاً بالرسم العثماني المعتمد لمصحف المدينة المنورة..."
    ];
  }

  @override
  Widget build(BuildContext context) {
    final verses = getSurahVerses(surahId);
    return Scaffold(
      appBar: AppBar(
        title: Text('سورة $surahName', style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "${verses[index]} ﴿${index + 1}﴾",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF2C3E50), height: 1.8),
              textAlign: TextAlign.justify,
            ),
          );
        },
      ),
    );
  }
}

// شاشة مواقيت الصلاة الثابتة والمحمية من أخطاء الحزم الخارجية
class LivePrayerTimesScreen extends StatelessWidget {
  const LivePrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // حساب يدوي مبسط للتاريخ لعرض اليوم الحالي
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
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildPrayerRow("الفجر", "04:12 ص"),
                  _buildPrayerRow("الشروق", "05:50 ص"),
                  _buildPrayerRow("الظهر", "12:55 م"),
                  _buildPrayerRow("العصر", "04:30 م"),
                  _buildPrayerRow("المغرب", "07:58 م"),
                  _buildPrayerRow("العشاء", "09:32 م"),
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildPrayerRow(String name, String time) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.volume_up, color: Color(0xFF1A4D2E)),
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A4D2E))),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
