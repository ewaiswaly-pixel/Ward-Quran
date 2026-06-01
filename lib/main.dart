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
        // ألوان مستوحاة من المصحف الشريف (الأخضر الذهبي والبيج الملكي)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C3A),
          primary: const Color(0xFF0F4C3A),
          secondary: const Color(0xFF8C7040),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF0F4C3A),
          foregroundColor: const Color(0xFFE5D5B6),
          elevation: 3,
          shadowColor: Colors.black26,
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
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: const Material(
              color: Color(0xFF0F4C3A),
              child: TabBar(
                labelColor: Color(0xFFE5D5B6),
                unselectedLabelColor: Colors.white60,
                indicatorColor: Color(0xFF8C7040),
                indicatorWeight: 3,
                tabs: [
                  Tab(icon: Icon(Icons.menu_book), text: 'المصحف الشريف'),
                  Tab(icon: Icon(Icons.calendar_today), text: 'الآذان والمواقيت'),
                ],
              ),
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

// شاشة فهرس سور القرآن الكريم المطور مع لمسة جمالية
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
        title: const Text('مصحف المدينة المنورة', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        itemCount: quranSuwar.length,
        itemBuilder: (context, index) {
          final surah = quranSuwar[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5D5B6).withOpacity(0.5), width: 1),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFAF7F0),
                ),
                child: Center(
                  child: Text(
                    '${surah['id']}',
                    style: const TextStyle(color: Color(0xFF8C7040), fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              title: Text(
                surah['name'],
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF0F4C3A)),
              ),
              subtitle: Text(
                '${surah['type']} ❖ آياتها ${surah['verses']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF8C7040)),
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

// شاشة عرض آيات السورة الكريمة بإطار زخرفي محاكي للمصحف الشريف
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
          "قُلْ أَعُوذُ بِرَبِّ النَّاسِ",
          "مَلِكِ النَّاسِ",
          "إِلَهِ النَّاسِ",
          "مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ",
          "الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ",
          "مِنَ الْجِنَّةِ وَالنَّاسِ"
        ];
      default:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "جاري تجميع وضبط النص الكامل بالتشكيل والرموز لهذه السورة الكريمة في التحديث القادم لـ وِرْدْ..."
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
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(4),
          // إطار خارجي يحاكي إطارات صفحات المصحف
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF8C7040), width: 2),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5D5B6).withOpacity(0.5), width: 1),
            ),
            child: SingleChildScrollView(
              child: RichText(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: List.generate(verses.length, (index) {
                    return TextSpan(
                      children: [
                        TextSpan(
                          text: "${verses[index]} ",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                            height: 2.3,
                          ),
                        ),
                        TextSpan(
                          text: "﴿${index + 1}﴾ ",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8C7040),
                          ),
                        ),
                      ],
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

// شاشة مواقيت الصلاة بتصميم لوحة حية فاخرة
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F4C3A), Color(0xFF166D53)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: const Color(0xFF0F4C3A).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.star_border_purple_500, color: Color(0xFFE5D5B6), size: 28),
                const SizedBox(height: 6),
                const Text(
                  "١٦ ذو الحجة ١٤٤٧ هـ",
                  style: TextStyle(color: Color(0xFFE5D5B6), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "الموافق ميلادياً: $dateString",
                  style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Colors.white12, height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on, color: Color(0xFFE5D5B6), size: 16),
                    SizedBox(width: 4),
                    Text(
                      "توقيت جمهورية مصر العربية المحلي",
                      style: TextStyle(color: Colors.white90, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [
                _buildPrayerRow("الفجر", "04:12 ص", Icons.wb_twilight),
                _buildPrayerRow("الشروق", "05:50 ص", Icons.wb_sunny_outlined),
                _buildPrayerRow("الظهر", "12:55 م", Icons.wb_sunny),
                _buildPrayerRow("العصر", "04:30 م", Icons.cloud_queue),
                _buildPrayerRow("المغرب", "07:58 م", Icons.nights_stay_outlined),
                _buildPrayerRow("العشاء", "09:32 م", Icons.nights_stay),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerRow(String name, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.03), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8C7040), size: 22),
        title: Text(
          name, 
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F4C3A)),
        ),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8C7040)),
        ),
      ),
    );
  }
}
