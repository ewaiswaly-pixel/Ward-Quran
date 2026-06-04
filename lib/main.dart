import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; 
import 'package:adhan/adhan.dart'; 
import 'package:quran/quran.dart' as quran; 

void main() async {
  // تهيئة خدمات فلاتر الأساسية
  WidgetsFlutterBinding.ensureInitialized();
  
  // حل مشكلة الشاشة السوداء والخطأ LocaleDataException
  await initializeDateFormatting('ar', null); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'المصحف الشريف الموثق',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const QuranScreen(),       // تبويب المصحف (0)
    const PrayerTimesScreen(), // تبويب المواقيت (1)
    const AzkarScreen(),       // تبويب الأذكار (2)
    const SettingsScreen(),    // تبويب العدادات (3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2C2C2C), 
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'مصحف'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'مواقيت'),
          BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_outlined), label: 'الأذكار'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'عدادات'),
        ],
      ),
    );
  }
}

// ================= 1. شاشة المصحف الشريف كاملاً =================
class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text('المصحف الشريف الموثق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView.separated(
          itemCount: quran.totalSurahCount, // 114 سورة تلقائياً
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            int surahNumber = index + 1;
            return ListTile(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              title: Text(
                quran.getSurahNameArabic(surahNumber),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              subtitle: Row(
                children: [
                  Text(quran.getPlaceOfRevelation(surahNumber) == 'Makkah' ? "مكية" : "مدنية", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(width: 8),
                  const Icon(Icons.brightness_3, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text("آياتها ${quran.getVerseCount(surahNumber)}", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              trailing: Text("صفحة ${quran.getPageNumber(surahNumber, 1)}", style: const TextStyle(color: Colors.grey, fontSize: 16)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SurahDetailsScreen(surahNumber: surahNumber)));
              },
            );
          },
        ),
      ),
    );
  }
}

// شاشة عرض آيات السورة بالتفصيل عند الضغط عليها
class SurahDetailsScreen extends StatelessWidget {
  final int surahNumber;
  const SurahDetailsScreen({required this.surahNumber, super.key});

  @override
  Widget build(BuildContext context) {
    int verseCount = quran.getVerseCount(surahNumber);
    List<String> verses = [];
    for (int i = 1; i <= verseCount; i++) {
      verses.add("${quran.getVerse(surahNumber, i)} ﴿$i﴾");
    }
    String fullSurahText = verses.join(" ");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: Text(quran.getSurahNameArabic(surahNumber), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (surahNumber != 1 && surahNumber != 9)
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(quran.basmala, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              Text(fullSurahText, style: const TextStyle(fontSize: 22, height: 2.0), textAlign: TextAlign.justify),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= 2. شاشة مواقيت الصلاة الحقيقية (المصححة والمؤمنة) =================
class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  PrayerTimes _calculateTimes() {
    final coordinates = Coordinates(30.0444, 31.2357); // إحداثيات مستقرة ودقيقة
    final dateComponents = DateComponents.fromDateTime(DateTime.now());
    final params = CalculationMethod.umm_al_qura.getParameters();
    return PrayerTimes(coordinates, dateComponents, params);
  }

  @override
  Widget build(BuildContext context) {
    final prayerTimes = _calculateTimes();

    String formatTime(DateTime time) {
      int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
      String period = time.hour >= 12 ? "م" : "ص";
      String minute = time.minute.toString().padLeft(2, '0');
      return "$hour:$minute $period";
    }

    // هنا تم تأمين الكلمة باللغة الإنجليزية بالكامل لقراءة الشروق بدون أي حرف عربي عارض
    final List<Map<String, dynamic>> prayers = [
      {"name": "الفجر", "time": formatTime(prayerTimes.fajr), "icon": Icons.wb_twighlight},
      {"name": "الشروق", "time": formatTime(prayerTimes.sunrise), "icon": Icons.wb_sunny_outlined},
      {"name": "الظهر", "time": formatTime(prayerTimes.dhuhr), "icon": Icons.wb_sunny},
      {"name": "العصر", "time": formatTime(prayerTimes.asr), "icon": Icons.cloud_queue},
      {"name": "المغرب", "time": formatTime(prayerTimes.maghrib), "icon": Icons.nights_stay_outlined},
      {"name": "العشاء", "time": formatTime(prayerTimes.isha), "icon": Icons.nights_stay},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text('مواقيت الصلاة الحقيقية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: prayers.length,
          itemBuilder: (context, index) {
            final prayer = prayers[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(prayer["icon"], color: const Color(0xFF4A4A4A), size: 28),
                title: Text(prayer["name"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Text(prayer["time"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================= 3. شاشة الأذكار والسبحة الرقمية =================
class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  final List<Map<String, dynamic>> _azkarList = [
    {"text": "سُبْحَانَ اللهِ وَبِحَمْدِهِ", "target": 33, "current": 0, "reward": "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ."},
    {"text": "أَسْتَغْفِرُ اللهَ وَأَتُوبُ إِلَيْهِ", "target": 100, "current": 0, "reward": "متاعاً حسناً، وتيسيراً للأمور، وغفراناً للذنوب."},
    {"text": "اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ", "target": 10, "current": 0, "reward": "من صلى عليّ صلاة صلى الله عليه بها عشراً."},
    {"text": "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللهِ", "target": 33, "current": 0, "reward": "كنز من كنوز الجنة."}
  ];

  void _resetAllCounters() {
    setState(() {
      for (var zikr in _azkarList) {
        zikr["current"] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text('الأذكار والسبحة الرقمية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: _resetAllCounters)
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _azkarList.length,
          itemBuilder: (context, index) {
            final zikr = _azkarList[index];
            final bool isCompleted = zikr["current"] >= zikr["target"];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green.shade50 : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isCompleted ? Colors.green.shade300 : Colors.grey.shade300, width: isCompleted ? 2 : 1),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(zikr["text"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isCompleted ? Colors.green.shade800 : Colors.black87)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(zikr["reward"], style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontStyle: FontStyle.italic)),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: isCompleted ? Colors.green : const Color(0xFF4A4A4A)),
                  onPressed: () {
                    if (!isCompleted) {
                      setState(() {
                        zikr["current"]++;
                      });
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${zikr["current"]} / ${zikr["target"]}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Icon(isCompleted ? Icons.check_circle : Icons.touch_app, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================= 4. شاشة العدادات (الإعدادات) =================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text('العدادات والإعدادات', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('نسخة التطبيق 1.0.0 - جاهز ومستقر بفضل الله', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ),
      ),
    );
  }
}
