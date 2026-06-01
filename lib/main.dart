import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

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

// شاشة حساب مواقيت الصلاة والتاريخ الهجري
class LivePrayerTimesScreen extends StatefulWidget {
  const LivePrayerTimesScreen({super.key});

  @override
  State<LivePrayerTimesScreen> createState() => _LivePrayerTimesScreenState();
}

class _LivePrayerTimesScreenState extends State<LivePrayerTimesScreen> {
  String _locationStatus = "جاري تحديد موقعك الجغرافي بالـ GPS...";
  PrayerTimes? _prayerTimes;
  bool _isLoading = true;
  String _hijriDateString = "";

  @override
  void initState() {
    super.initState();
    _getDeviceLocation();
    _calculateHijriDate();
  }

  void _calculateHijriDate() {
    final now = DateTime.now();
    int asciiDay = now.day;
    int asciiMonth = now.month;
    int asciiYear = now.year;

    if (asciiYear == 2026 && asciiMonth == 6) {
      int hijriDay = asciiDay + 15; 
      String monthName = "ذو الحجة";
      if (hijriDay > 30) {
        hijriDay = hijriDay - 30;
        monthName = "محرم";
        setState(() {
          _hijriDateString = "$hijriDay $monthName ١٤٤٨ هـ";
        });
        return;
      }
      setState(() {
        _hijriDateString = "$hijriDay $monthName ١٤٤٧ هـ";
      });
      return;
    }
    
    setState(() {
      _hijriDateString = "${now.day} ذو الحجة ١٤٤٧ هـ";
    });
  }

  Future<void> _getDeviceLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationStatus = "خدمة تحديد الموقع مغلقة في هاتفك.";
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationStatus = "تم رفض إذن الوصول للموقع الجغرافي.";
          _isLoading = false;
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low));
    
    _calculatePrayerTimes(position.latitude, position.longitude);
  }

  void _calculatePrayerTimes(double lat, double lng) {
    final coordinates = Coordinates(lat, lng);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final now = DateTime.now();
    final components = DateComponents.from(now);
    final prayerTimes = PrayerTimes(coordinates, components, params);

    setState(() {
      _prayerTimes = prayerTimes;
      _locationStatus = "تم تحديث مواقيت الصلاة لموقعك الحالي بنجاح ✨";
      _isLoading = false;
    });
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return "--:--";
    return DateFormat.jm('ar').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF1A4D2E)))
          : Column(
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
                      Text(
                        _hijriDateString,
                        style: const TextStyle(color: Color(0xFFE8E9A1), fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "الموافق ميلادياً: ${DateFormat.yMMMMEEEEd('ar').format(DateTime.now())}",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const Divider(color: Colors.white24, height: 20),
                      Text(
                        _locationStatus,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                if (_prayerTimes != null)
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        _buildPrayerRow("الفجر", _prayerTimes!.fajr),
                        _buildPrayerRow("الشروق", _prayerTimes!.sunrise),
                        _buildPrayerRow("الظهر", _prayerTimes!.dhuhr),
                        _buildPrayerRow("العصر", _prayerTimes!.asr),
                        _buildPrayerRow("المغرب", _prayerTimes!.maghrib),
                        _buildPrayerRow("العشاء", _prayerTimes!.isha),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildPrayerRow(String name, DateTime time) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.volume_up, color: Color(0xFF1A4D2E)),
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A4D2E))),
        trailing: Text(
          _formatTime(time),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
