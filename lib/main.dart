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
        scaffoldBackgroundColor: const Color(0xFFFBF9F1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A4D2E),
          elevation: 2,
        ),
      ),
      home: const MainTabController(),
    );
  }
}

// متحكم التبويبات الرئيسي للتنقل بين المصحف ومواقيت الصلاة
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
                Tab(icon: Icon(Icons.menu_book), text: 'المصحف الشريف'),
                Tab(icon: Icon(Icons.access_time), text: 'مواقيت الصلاة'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              QuranIndexScreen(),
              PrayerTimesScreen(),
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
        title: const Text('مصحف المدينة المنورة', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
        title: Text('سورة $surahName', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              verses[index] + " ﴿${index + 1}﴾",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF2C3E50), height: 1.8),
              textAlign: TextAlign.justify,
            ),
          );
        },
      ),
    );
  }
}

// الشاشة الجديدة المخصصة لمواقيت الصلاة والأذان تلقائياً
class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  // محاكاة ذكية للمواقيت المحلية مبدئياً لحين تفعيل حزم الخرائط
  static const List<Map<String, String>> dummyPrayerTimes = [
    {"prayer": "الفجر", "time": "03:45 ص"},
    {"prayer": "الشروق", "time": "05:15 ص"},
    {"prayer": "الظهر", "time": "12:00 م"},
    {"prayer": "العصر", "time": "03:30 م"},
    {"prayer": "المغرب", "time": "06:45 م"},
    {"prayer": "العشاء", "time": "08:15 م"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة والأذان', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // لوحة علوية مميزة تظهر الصلاة القادمة والموقع التلقائي للمستخدم
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A4D2E),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              children: [
                Icon(Icons.location_on, color: Color(0xFFE8E9A1), size: 30),
                SizedBox(height: 5),
                Text('تحديد الموقع الجغرافي: تلقائي (GPS)', style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 15),
                Text('الصلاة القادمة: صلاة المغرب', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('متبقي: 45 دقيقة و 12 ثانية لتكبيرات الأذان', style: TextStyle(color: Color(0xFFE8E9A1), fontSize: 16)),
              ],
            ),
          ),
          
          // عرض المواقيت في قائمة منظمة
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: dummyPrayerTimes.length,
              itemBuilder: (context, index) {
                final item = dummyPrayerTimes[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.notifications_active, color: Color(0xFF1A4D2E)),
                    title: Text(item['prayer']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    trailing: Text(item['time']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.green)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
