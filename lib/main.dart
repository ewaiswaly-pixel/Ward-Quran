import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // هذا السطر هو الحل الجذري لخطأ الصورة AAAA20
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const WardQuranApp());
}

class WardQuranApp extends StatelessWidget {
  const WardQuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق ورد القرآن ومواقيت الصلاة',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const QuranPage(),
    const PrayerTimesPage(),
    const AzkarPage(),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'المصحف'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'المواقيت'),
          BottomNavigationBarItem(icon: Icon(Icons.fingerprint), label: 'الأذكار'),
        ],
      ),
    );
  }
}

// --- شاشة الفهرس والمصحف الشريف ---
class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  // قائمة سور القرآن الكريم كعينة مستقرة داخل التطبيق
  final List<Map<String, dynamic>> surahs = const [
    {"name": "الفاتحة", "verses": 7},
    {"name": "البقرة", "verses": 286},
    {"name": "آل عمران", "verses": 200},
    {"name": "النساء", "verses": 176},
    {"name": "المائدة", "verses": 120},
    {"name": "الأنعام", "verses": 165},
    {"name": "الأعراف", "verses": 206},
    {"name": "الأنفال", "verses": 75},
    {"name": "التوبة", "verses": 129},
    {"name": "يونس", "verses": 109},
    {"name": "هود", "verses": 123},
    {"name": "يوسف", "verses": 111},
    {"name": "الرعد", "verses": 43},
    {"name": "إبراهيم", "verses": 52},
    {"name": "الحجر", "verses": 99},
    {"name": "النحل", "verses": 128},
    {"name": "الإسراء", "verses": 111},
    {"name": "الكهف", "verses": 110},
    {"name": "مريم", "verses": 98},
    {"name": "طه", "verses": 135},
    {"name": "الأنبياء", "verses": 112},
    {"name": "الحج", "verses": 78},
    {"name": "المؤمنون", "verses": 118},
    {"name": "النور", "verses": 64},
    {"name": "الفرقان", "verses": 77},
    {"name": "الشعراء", "verses": 227},
    {"name": "النمل", "verses": 93},
    {"name": "القصص", "verses": 88},
    {"name": "العنكبوت", "verses": 69},
    {"name": "الروم", "verses": 60},
    {"name": "لقمان", "verses": 34},
    {"name": "السجدة", "verses": 30},
    {"name": "الأحزاب", "verses": 73},
    {"name": "سبأ", "verses": 54},
    {"name": "فاطر", "verses": 45},
    {"name": "يس", "verses": 83},
    {"name": "الصافات", "verses": 182},
    {"name": "ص", "verses": 88},
    {"name": "الزمر", "verses": 75},
    {"name": "غافر", "verses": 85},
    {"name": "فصلت", "verses": 54},
    {"name": "الشورى", "verses": 53},
    {"name": "الزخرف", "verses": 89},
    {"name": "الدخان", "verses": 59},
    {"name": "الجاثية", "verses": 37},
    {"name": "الأحقاف", "verses": 35},
    {"name": "محمد", "verses": 38},
    {"name": "الفتح", "verses": 29},
    {"name": "الحجرات", "verses": 18},
    {"name": "ق", "verses": 45},
    {"name": "الذاريات", "verses": 60},
    {"name": "الطور", "verses": 49},
    {"name": "النجم", "verses": 62},
    {"name": "القمر", "verses": 55},
    {"name": "الرحمن", "verses": 78},
    {"name": "الواقعة", "verses": 96},
    {"name": "الحديد", "verses": 29},
    {"name": "المجادلة", "verses": 22},
    {"name": "الحشر", "verses": 24},
    {"name": "الممتحنة", "verses": 13},
    {"name": "الصف", "verses": 14},
    {"name": "الجمعة", "verses": 11},
    {"name": "المنافقون", "verses": 11},
    {"name": "التغابن", "verses": 18},
    {"name": "الطلاق", "verses": 12},
    {"name": "التحريم", "verses": 12},
    {"name": "الملك", "verses": 30},
    {"name": "القلم", "verses": 52},
    {"name": "الحاقة", "verses": 52},
    {"name": "المعارج", "verses": 44},
    {"name": "نوح", "verses": 28},
    {"name": "الجن", "verses": 28},
    {"name": "المزمل", "verses": 20},
    {"name": "المدثر", "verses": 56},
    {"name": "القيامة", "verses": 40},
    {"name": "الإنسان", "verses": 31},
    {"name": "المرسلات", "verses": 50},
    {"name": "النبأ", "verses": 40},
    {"name": "النازعات", "verses": 46},
    {"name": "عبس", "verses": 42},
    {"name": "التكوير", "verses": 29},
    {"name": "الانفطار", "verses": 19},
    {"name": "المطففين", "verses": 36},
    {"name": "الانشقاق", "verses": 25},
    {"name": "البروج", "verses": 22},
    {"name": "الطارق", "verses": 17},
    {"name": "الأعلى", "verses": 19},
    {"name": "الغاشية", "verses": 26},
    {"name": "الفجر", "verses": 30},
    {"name": "البلد", "verses": 20},
    {"name": "الشمس", "verses": 15},
    {"name": "الليل", "verses": 21},
    {"name": "الضحى", "verses": 11},
    {"name": "الشرح", "verses": 8},
    {"name": "التين", "verses": 8},
    {"name": "العلق", "verses": 19},
    {"name": "القدر", "verses": 5},
    {"name": "البينة", "verses": 8},
    {"name": "الزلزلة", "verses": 8},
    {"name": "العاديات", "verses": 11},
    {"name": "القارعة", "verses": 11},
    {"name": "التكاثر", "verses": 8},
    {"name": "العصر", "verses": 3},
    {"name": "الهمزة", "verses": 9},
    {"name": "الفيل", "verses": 5},
    {"name": "قريش", "verses": 4},
    {"name": "الماعون", "verses": 7},
    {"name": "الكوثر", "verses": 3},
    {"name": "الكافرون", "verses": 6},
    {"name": "النصر", "verses": 3},
    {"name": "المسد", "verses": 5},
    {"name": "الإخلاص", "verses": 4},
    {"name": "الفلق", "verses": 5},
    {"name": "الناس", "verses": 6}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('المصحف الشريف (الفهرس)'))),
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          int surahNumber = index + 1;
          String name = surahs[index]["name"];
          int verses = surahs[index]["verses"];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Text('$surahNumber')),
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('عدد آياتها: $verses'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahDetailPage(surahName: name, totalVerses: verses),
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

class SurahDetailPage extends StatelessWidget {
  final String surahName;
  final int totalVerses;
  const SurahDetailPage({super.key, required this.surahName, required this.totalVerses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(surahName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: totalVerses,
          itemBuilder: (context, index) {
            int verseNumber = index + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'آية كريمة من سورة $surahName ﴿$verseNumber﴾',
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 18, height: 1.8),
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- شاشة مواقيت الصلاة ---
class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coordinates = Coordinates(30.0444, 31.2357); // إحداثيات مصر الافتراضية
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    
    final prayerTimes = PrayerTimes.today(coordinates, params);

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('مواقيت الصلاة'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPrayerRow('الفجر', prayerTimes.fajr),
            _buildPrayerRow('الظهر', prayerTimes.dhuhr),
            _buildPrayerRow('العصر', prayerTimes.asr),
            _buildPrayerRow('المغرب', prayerTimes.maghrib),
            _buildPrayerRow('العشاء', prayerTimes.isha),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerRow(String name, DateTime time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Text(DateFormat.jm().format(time), style: const TextStyle(fontSize: 18, color: Colors.green)),
      ),
    );
  }
}

// --- شاشة الأذكار ---
class AzkarPage extends StatefulWidget {
  const AzkarPage({super.key});

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('الأذكار والسبحة'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('استغفر الله العظيم واتوب إليه', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  _counter++;
                });
              },
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.green,
                child: Text('$_counter', style: const TextStyle(fontSize: 40, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('تصفير العداد', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
