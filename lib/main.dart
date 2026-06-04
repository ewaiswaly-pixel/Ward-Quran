import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const QuranWardApp());
}

class QuranWardApp extends StatefulWidget {
  const QuranWardApp({super.key});

  @override
  State<QuranWardApp> createState() => _QuranWardAppState();
}

class _QuranWardAppState extends State<QuranWardApp> {
  bool _isDarkMode = false;
  bool _keepScreenAwake = true;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _toggleScreenAwake(bool value) {
    setState(() {
      _keepScreenAwake = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق وِرْدْ',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C3A),
          primary: const Color(0xFF0F4C3A),
          secondary: const Color(0xFF8C7040),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F4C3A),
          foregroundColor: Color(0xFFE5D5B6),
          elevation: 3,
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C3A),
          primary: const Color(0xFF0F4C3A),
          secondary: const Color(0xFFE5D5B6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: Color(0xFFE5D5B6),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: MainTabController(
        isDarkMode: _isDarkMode,
        keepScreenAwake: _keepScreenAwake,
        onThemeChanged: _toggleTheme,
        onAwakeChanged: _toggleScreenAwake,
      ),
    );
  }
}

class MainTabController extends StatelessWidget {
  final bool isDarkMode;
  final bool keepScreenAwake;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<bool> onAwakeChanged;

  const MainTabController({
    super.key,
    required this.isDarkMode,
    required this.keepScreenAwake,
    required this.onThemeChanged,
    required this.onAwakeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Material(
              color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFF0F4C3A),
              child: const TabBar(
                labelColor: Color(0xFFE5D5B6),
                unselectedLabelColor: Colors.white60,
                indicatorColor: Color(0xFF8C7040),
                indicatorWeight: 3,
                tabs: [
                  Tab(icon: Icon(Icons.menu_book), text: 'المصحف'),
                  Tab(icon: Icon(Icons.access_time), text: 'المواقيت'),
                  Tab(icon: Icon(Icons.wb_sunny_outlined), text: 'الأذكار'),
                  Tab(icon: Icon(Icons.settings), text: 'الإعدادات'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              const QuranIndexScreen(),
              const LivePrayerTimesScreen(),
              const AzkarScreen(),
              AppSettingsScreen(
                isDarkMode: isDarkMode,
                keepScreenAwake: keepScreenAwake,
                onThemeChanged: onThemeChanged,
                onAwakeChanged: onAwakeChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuranIndexScreen extends StatefulWidget {
  const QuranIndexScreen({super.key});

  @override
  State<QuranIndexScreen> createState() => _QuranIndexScreenState();
}

class _QuranIndexScreenState extends State<QuranIndexScreen> {
  final List<Map<String, dynamic>> _allSuwar = [
    {"id": 1, "name": "الفاتحة", "type": "مكية", "verses": 7, "page": 1},
    {"id": 2, "name": "البقرة", "type": "مدنية", "verses": 286, "page": 2},
    {"id": 3, "name": "آل عمران", "type": "مدنية", "verses": 200, "page": 50},
    {"id": 4, "name": "النساء", "type": "مدنية", "verses": 176, "page": 77},
    {"id": 5, "name": "المائدة", "type": "مدنية", "verses": 120, "page": 106},
    {"id": 6, "name": "الأنعام", "type": "مكية", "verses": 165, "page": 128},
    {"id": 7, "name": "الأعراف", "type": "مكية", "verses": 206, "page": 151},
  ];

  List<Map<String, dynamic>> _filteredSuwar = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSuwar = _allSuwar;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('المصحف الشريف الموثق', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filteredSuwar = value.isEmpty 
                      ? _allSuwar 
                      : _allSuwar.where((s) => s["name"].contains(value)).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'ابحث عن اسم السورة...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSuwar.length,
              itemBuilder: (context, index) {
                final surah = _filteredSuwar[index];
                return ListTile(
                  title: Text(surah['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('${surah['type']} ❖ آياتها ${surah['verses']}'),
                  trailing: Text('صفحة ${surah['page']}', style: const TextStyle(color: Color(0xFF8C7040))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuranPdfViewScreen(
                          surahName: surah['name'],
                          initialPage: surah['page'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuranPdfViewScreen extends StatelessWidget {
  final String surahName;
  final int initialPage;

  const QuranPdfViewScreen({super.key, required this.surahName, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    final PdfViewerController pdfViewerController = PdfViewerController();

    return Scaffold(
      appBar: AppBar(title: Text('سورة $surahName')),
      body: SfPdfViewer.network(
        'https://archive.org/download/quran-pdf-high-quality/quran.pdf',
        controller: pdfViewerController,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          pdfViewerController.jumpToPage(initialPage);
        },
      ),
    );
  }
}

class LivePrayerTimesScreen extends StatefulWidget {
  const LivePrayerTimesScreen({super.key});
  @override
  State<LivePrayerTimesScreen> createState() => _LivePrayerTimesScreenState();
}

class _LivePrayerTimesScreenState extends State<LivePrayerTimesScreen> {
  PrayerTimes? _prayerTimes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDefaultTimes();
  }

  void _loadDefaultTimes() {
    final coordinates = Coordinates(30.0444, 31.2357); 
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    setState(() {
      _prayerTimes = PrayerTimes.today(coordinates, params);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(14),
              children: [
                ListTile(title: const Text("الفجر"), trailing: Text(_prayerTimes != null ? DateFormat.jm('ar_EG').format(_prayerTimes!.fajr) : "--:--")),
                ListTile(title: const Text("الظهر"), trailing: Text(_prayerTimes != null ? DateFormat.jm('ar_EG').format(_prayerTimes!.dhuhr) : "--:--")),
                ListTile(title: const Text("العصر"), trailing: Text(_prayerTimes != null ? DateFormat.jm('ar_EG').format(_prayerTimes!.asr) : "--:--")),
                ListTile(title: const Text("المغرب"), trailing: Text(_prayerTimes != null ? DateFormat.jm('ar_EG').format(_prayerTimes!.maghrib) : "--:--")),
                ListTile(title: const Text("العشاء"), trailing: Text(_prayerTimes != null ? DateFormat.jm('ar_EG').format(_prayerTimes!.isha) : "--:--")),
              ],
            ),
    );
  }
}

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأذكار اليومية')),
      body: const Center(child: Text("تمت القراءة والمتابعة")),
    );
  }
}

class AppSettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final bool keepScreenAwake;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<bool> onAwakeChanged;

  const AppSettingsScreen({super.key, required this.isDarkMode, required this.keepScreenAwake, required this.onThemeChanged, required this.onAwakeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعدادات التطبيق')),
      body: SwitchListTile(title: const Text('الوضع الداكن'), value: isDarkMode, onChanged: onThemeChanged),
    );
  }
}
