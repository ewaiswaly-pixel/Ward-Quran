import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
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

// --- شاشة المصحف الشريف ---
class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('المصحف الشريف'))),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index) {
          int surahNumber = index + 1;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Text('$surahNumber')),
              title: Text(quran.getSurahNameArabic(surahNumber)),
              subtitle: Text('عدد آياتها: ${quran.getVerseCount(surahNumber)}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahDetailPage(surahNumber: surahNumber),
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
  final int surahNumber;
  const SurahDetailPage({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    int totalVerses = quran.getVerseCount(surahNumber);
    return Scaffold(
      appBar: AppBar(title: Text(quran.getSurahNameArabic(surahNumber))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: totalVerses,
          itemBuilder: (context, index) {
            int verseNumber = index + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '${quran.getVerse(surahNumber, verseNumber)} ﴿$verseNumber﴾',
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 20, height: 1.8),
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
    final coordinates = Coordinates(30.0444, 31.2357); // إحداثيات افتراضية مصر
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
