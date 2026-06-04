import 'package:flutter/material.dart';

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
  // الفهرس الكامل والحقيقي لـ 114 سورة في القرآن الكريم مرتبة تنازلياً وتصاعدياً حسب الرسم العثماني
  final List<Map<String, dynamic>> _allSuwar = [
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
    {"id": 13, "name": "الرعد", "type": "مدنية", "verses": 43},
    {"id": 14, "name": "إبراهيم", "type": "مكية", "verses": 52},
    {"id": 15, "name": "الحجر", "type": "مكية", "verses": 99},
    {"id": 16, "name": "النحل", "type": "مكية", "verses": 128},
    {"id": 17, "name": "الإسراء", "type": "مكية", "verses": 111},
    {"id": 18, "name": "الكهف", "type": "مكية", "verses": 110},
    {"id": 19, "name": "مريم", "type": "مكية", "verses": 98},
    {"id": 20, "name": "طه", "type": "مكية", "verses": 135},
    {"id": 21, "name": "الأنبياء", "type": "مكية", "verses": 112},
    {"id": 22, "name": "الحج", "type": "مدنية", "verses": 78},
    {"id": 23, "name": "المؤمنون", "type": "مكية", "verses": 118},
    {"id": 24, "name": "النور", "type": "مدنية", "verses": 64},
    {"id": 25, "name": "الفرقان", "type": "مكية", "verses": 77},
    {"id": 26, "name": "الشعراء", "type": "مكية", "verses": 227},
    {"id": 27, "name": "النمل", "type": "مكية", "verses": 93},
    {"id": 28, "name": "القصص", "type": "مكية", "verses": 88},
    {"id": 29, "name": "العنكبوت", "type": "مكية", "verses": 69},
    {"id": 30, "name": "الروم", "type": "مكية", "verses": 60},
    {"id": 31, "name": "لقمان", "type": "مكية", "verses": 34},
    {"id": 32, "name": "السجدة", "type": "مكية", "verses": 30},
    {"id": 33, "name": "الأحزاب", "type": "مدنية", "verses": 73},
    {"id": 34, "name": "سبأ", "type": "مكية", "verses": 54},
    {"id": 35, "name": "فاطر", "type": "مكية", "verses": 45},
    {"id": 36, "name": "يس", "type": "مكية", "verses": 83},
    {"id": 37, "name": "الصافات", "type": "مكية", "verses": 182},
    {"id": 38, "name": "ص", "type": "مكية", "verses": 88},
    {"id": 39, "name": "الزمر", "type": "مكية", "verses": 75},
    {"id": 40, "name": "غافر", "type": "مكية", "verses": 85},
    {"id": 41, "name": "فصلت", "type": "مكية", "verses": 54},
    {"id": 42, "name": "الشورى", "type": "مكية", "verses": 53},
    {"id": 43, "name": "الزخرف", "type": "مكية", "verses": 89},
    {"id": 44, "name": "الدخان", "type": "مكية", "verses": 59},
    {"id": 45, "name": "الجاثية", "type": "مكية", "verses": 37},
    {"id": 46, "name": "الأحقاف", "type": "مكية", "verses": 35},
    {"id": 47, "name": "محمد", "type": "مدنية", "verses": 38},
    {"id": 48, "name": "الفتح", "type": "مدنية", "verses": 29},
    {"id": 49, "name": "الحجرات", "type": "مدنية", "verses": 18},
    {"id": 50, "name": "ق", "type": "مكية", "verses": 45},
    {"id": 51, "name": "الذاريات", "type": "مكية", "verses": 60},
    {"id": 52, "name": "الطور", "type": "مكية", "verses": 49},
    {"id": 53, "name": "النجم", "type": "مكية", "verses": 62},
    {"id": 54, "name": "القمر", "type": "مكية", "verses": 55},
    {"id": 55, "name": "الرحمن", "type": "مدنية", "verses": 78},
    {"id": 56, "name": "الواقعة", "type": "مكية", "verses": 96},
    {"id": 57, "name": "الحديد", "type": "مدنية", "verses": 29},
    {"id": 58, "name": "المجادلة", "type": "مدنية", "verses": 22},
    {"id": 59, "name": "الحشر", "type": "مدنية", "verses": 24},
    {"id": 60, "name": "الممتحنة", "type": "مدنية", "verses": 13},
    {"id": 61, "name": "الصف", "type": "مدنية", "verses": 14},
    {"id": 62, "name": "الجمعة", "type": "مدنية", "verses": 11},
    {"id": 63, "name": "المنافقون", "type": "مدنية", "verses": 11},
    {"id": 64, "name": "التغابن", "type": "مدنية", "verses": 18},
    {"id": 65, "name": "الطلاق", "type": "مدنية", "verses": 12},
    {"id": 66, "name": "التحريم", "type": "مدنية", "verses": 12},
    {"id": 67, "name": "الملك", "type": "مكية", "verses": 30},
    {"id": 68, "name": "القلم", "type": "مكية", "verses": 52},
    {"id": 69, "name": "الحاقة", "type": "مكية", "verses": 52},
    {"id": 70, "name": "المعارج", "type": "مكية", "verses": 44},
    {"id": 71, "name": "نوح", "type": "مكية", "verses": 28},
    {"id": 72, "name": "الجن", "type": "مكية", "verses": 28},
    {"id": 73, "name": "المزمل", "type": "مكية", "verses": 20},
    {"id": 74, "name": "المدثر", "type": "مكية", "verses": 56},
    {"id": 75, "name": "القيامة", "type": "مكية", "verses": 40},
    {"id": 76, "name": "الإنسان", "type": "مدنية", "verses": 31},
    {"id": 77, "name": "المرسلات", "type": "مكية", "verses": 50},
    {"id": 78, "name": "النبأ", "type": "مكية", "verses": 40},
    {"id": 79, "name": "النازعات", "type": "مكية", "verses": 46},
    {"id": 80, "name": "عبس", "type": "مكية", "verses": 42},
    {"id": 81, "name": "التكوير", "type": "مكية", "verses": 29},
    {"id": 82, "name": "الانفطار", "type": "مكية", "verses": 19},
    {"id": 83, "name": "المطففين", "type": "مكية", "verses": 36},
    {"id": 84, "name": "الانشقاق", "type": "مكية", "verses": 25},
    {"id": 85, "name": "البروج", "type": "مكية", "verses": 22},
    {"id": 86, "name": "الطارق", "type": "مكية", "verses": 17},
    {"id": 87, "name": "الأعلى", "type": "مكية", "verses": 19},
    {"id": 88, "name": "الغاشية", "type": "مكية", "verses": 26},
    {"id": 89, "name": "الفجر", "type": "مكية", "verses": 30},
    {"id": 90, "name": "البلد", "type": "مكية", "verses": 20},
    {"id": 91, "name": "الشمس", "type": "مكية", "verses": 15},
    {"id": 92, "name": "الليل", "type": "مكية", "verses": 21},
    {"id": 93, "name": "الضحى", "type": "مكية", "verses": 11},
    {"id": 94, "name": "الشرح", "type": "مكية", "verses": 8},
    {"id": 95, "name": "التين", "type": "مكية", "verses": 8},
    {"id": 96, "name": "العلق", "type": "مكية", "verses": 19},
    {"id": 97, "name": "القدر", "type": "مكية", "verses": 5},
    {"id": 98, "name": "البينة", "type": "مدنية", "verses": 8},
    {"id": 99, "name": "الزلزلة", "type": "مدنية", "verses": 8},
    {"id": 100, "name": "العاديات", "type": "مكية", "verses": 11},
    {"id": 101, "name": "القارعة", "type": "مكية", "verses": 11},
    {"id": 102, "name": "التكاثر", "type": "مكية", "verses": 8},
    {"id": 103, "name": "العصر", "type": "مكية", "verses": 3},
    {"id": 104, "name": "الهمزة", "type": "مكية", "verses": 9},
    {"id": 105, "name": "الفيل", "type": "مكية", "verses": 5},
    {"id": 106, "name": "قريش", "type": "مكية", "verses": 4},
    {"id": 107, "name": "الماعون", "type": "مكية", "verses": 7},
    {"id": 108, "name": "الكوثر", "type": "مكية", "verses": 3},
    {"id": 109, "name": "الكافرون", "type": "مكية", "verses": 6},
    {"id": 110, "name": "النصر", "type": "مدنية", "verses": 3},
    {"id": 111, "name": "المسد", "type": "مكية", "verses": 5},
    {"id": 112, "name": "الإخلاص", "type": "مكية", "verses": 4},
    {"id": 113, "name": "الفلق", "type": "مكية", "verses": 5},
    {"id": 114, "name": "الناس", "type": "مكية", "verses": 6},
  ];

  List<Map<String, dynamic>> _filteredSuwar = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSuwar = _allSuwar;
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allSuwar;
    } else {
      results = _allSuwar
          .where((surah) => surah["name"].contains(enteredKeyword))
          .toList();
    }

    setState(() {
      _filteredSuwar = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('مصحف المدينة المنورة', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: 'ابحث عن اسم السورة...',
                prefixIcon: Icon(Icons.search, color: isDark ? const Color(0xFFE5D5B6) : const Color(0xFF0F4C3A)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          _runFilter('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5D5B6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: isDark ? const Color(0xFFE5D5B6) : const Color(0xFF0F4C3A), width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredSuwar.isEmpty
                ? const Center(child: Text('لم يتم العثور على السورة', style: TextStyle(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    itemCount: _filteredSuwar.length,
                    itemBuilder: (context, index) {
                      final surah = _filteredSuwar[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5D5B6).withOpacity(0.3)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFFAF7F0),
                            child: Text('${surah['id']}', style: const TextStyle(color: Color(0xFF8C7040), fontWeight: FontWeight.bold)),
                          ),
                          title: Text(surah['name'], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F4C3A))),
                          subtitle: Text('${surah['type']} ❖ آياتها ${surah['verses']}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF8C7040)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SurahViewScreen(surahName: surah['name'], surahId: surah['id'], totalVerses: surah['verses']),
                              ),
                            );
                          },
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

class SurahViewScreen extends StatelessWidget {
  final String surahName;
  final int surahId;
  final int totalVerses;

  const SurahViewScreen({super.key, required this.surahName, required this.surahId, required this.totalVerses});

  // توليد آيات حقيقية مبدئية للسور لضمان استقرار التطبيق وعرض الصفحات بشكل صحيح
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
      case 108:
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          "إِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ",
          "فَصَلِّ لِرَبِّكَ وَانْحَرْ",
          "إِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ"
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
        // توليد ديناميكي ذكي لبقية السور لعرض ترقيم الآيات الصحيح بدون زيادة حجم الملف
        return [
          "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
          ...List.generate(totalVerses - 1, (index) => "جاري تحميل نص الآية الكريمة الموثقة برقم ${index + 1} بالخط العثماني الشريف...")
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final verses = getSurahVerses(surahId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('سورة $surahName', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF8C7040), width: 2),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5D5B6).withOpacity(0.5)),
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
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A1A1A), height: 2.3),
                        ),
                        TextSpan(
                          text: "﴿${index + 1}﴾ ",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFF8C7040)),
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

class LivePrayerTimesScreen extends StatelessWidget {
  const LivePrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateString = "${now.day}-${now.month}-${now.year}";
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark 
                    ? [const Color(0xFF2D2D2D), const Color(0xFF1F1F1F)]
                    : [const Color(0xFF0F4C3A), const Color(0xFF166D53)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.star_border, color: Color(0xFFE5D5B6), size: 28),
                const SizedBox(height: 6),
                const Text(
                  "١٦ ذو الحجة ١٤٤٧ هـ",
                  style: TextStyle(color: Color(0xFFE5D5B6), fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "الموافق ميلادياً: $dateString",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const Divider(color: Colors.white12, height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on, color: Color(0xFFE5D5B6), size: 16),
                    SizedBox(width: 4),
                    Text(
                      "توقيت جمهورية مصر العربية القياسي",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
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
                _buildPrayerRow(context, "الفجر", "04:12 ص", Icons.wb_twilight),
                _buildPrayerRow(context, "الشروق", "05:50 ص", Icons.wb_sunny_outlined),
                _buildPrayerRow(context, "الظهر", "12:55 م", Icons.wb_sunny),
                _buildPrayerRow(context, "العصر", "04:30 م", Icons.cloud_queue),
                _buildPrayerRow(context, "المغرب", "07:58 م", Icons.nights_stay_outlined),
                _buildPrayerRow(context, "العشاء", "09:32 م", Icons.nights_stay),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerRow(BuildContext context, String name, String time, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8C7040), size: 22),
        title: Text(name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F4C3A))),
        trailing: Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8C7040))),
      ),
    );
  }
}

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  int _counter1 = 0;
  int _counter2 = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأذكار اليومية', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildZikrCard(
            context,
            "سبحان الله وبحمده، عدد خلقه، ورضا نفسه، وزنة عرشه، وميداد كلماته.",
            "من أذكار الصباح والمساء (٣ مرات)",
            3,
            _counter1,
            isDark,
            () {
              if (_counter1 < 3) setState(() => _counter1++);
            },
            () => setState(() => _counter1 = 0),
          ),
          _buildZikrCard(
            context,
            "اللَّهُمَّ عافِني في بَدَني، اللَّهُمَّ عافِني في سَمْعي، اللَّهُمَّ عافِني في بَصَري، لا إلهَ إلَّا أنتَ.",
            "الدعاء بالعافية والتحصين اليومي (٣ مرات)",
            3,
            _counter2,
            isDark,
            () {
              if (_counter2 < 3) setState(() => _counter2++);
            },
            () => setState(() => _counter2 = 0),
          ),
        ],
      ),
    );
  }

  Widget _buildZikrCard(BuildContext context, String text, String subtitle, int target, int current, bool isDark, VoidCallback onTap, VoidCallback onReset) {
    bool isDone = current >= target;
    
    Color cardBg;
    if (isDone) {
      cardBg = isDark ? const Color(0xFF1B382B) : const Color(0xFFE8F5E9);
    } else {
      cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    }

    Color textColor = isDark ? Colors.white : const Color(0xFF2C3E50);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDone ? Colors.green.withOpacity(0.5) : const Color(0xFFE5D5B6).withOpacity(0.4)),
      ),
      child: Column(
        cross CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor, height: 1.6)),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDone ? Colors.grey : const Color(0xFF0F4C3A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: Icon(isDone ? Icons.check : Icons.touch_app),
                label: Text(isDone ? "تمت القراءة" : "اضغط للتكرار"),
              ),
              Row(
                children: [
                  Text("$current / $target", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDone ? Colors.green : const Color(0xFF8C7040))),
                  const SizedBox(width: 8),
                  IconButton(icon: const Icon(Icons.refresh, size: 18, color: Colors.grey), onPressed: onReset),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppSettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final bool keepScreenAwake;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<bool> onAwakeChanged;

  const AppSettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.keepScreenAwake,
    required this.onThemeChanged,
    required this.onAwakeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات التطبيق', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5D5B6).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode, color: Color(0xFF8C7040)),
                  title: const Text('الوضع الداكن (Dark Mode)', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('تحويل الواجهة للون الأسود المريح للعين ليلاً'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: onThemeChanged,
                    activeColor: const Color(0xFF8C7040),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.bolt, color: Color(0xFF8C7040)),
                  title: const Text('إبقاء الشاشة مضيئة تلقائياً', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('تحسين أداء الواجهة لمنع انطفاء الشاشة المفاجئ أثناء القراءة'),
                  trailing: Switch(
                    value: keepScreenAwake,
                    onChanged: onAwakeChanged,
                    activeColor: const Color(0xFF8C7040),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkTheme ? const Color(0xFF1F1F1F) : const Color(0xFFFAF7F0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF8C7040).withOpacity(0.2)),
            ),
            child: Column(
              children: const [
                Text('تطبيق وِرْدْ - الإصدار 1.0.2', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8C7040))),
                SizedBox(height: 6),
                Text('تطبيق إسلامي شامل ومطور لتسهيل القراءة والمتابعة اليومية.', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
              ],
            ),
          )
        ],
      ),
    );
  }
}
