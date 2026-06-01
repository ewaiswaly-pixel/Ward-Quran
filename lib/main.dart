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
          seedColor: const Color(0xFF0F4C3A),
          primary: const Color(0xFF0F4C3A),
          secondary: const Color(0xFF8C7040),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F4C3A),
          foregroundColor: Color(0xFFE5D5B6),
          elevation: 3,
          centerTitle: true,
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
        length: 3,
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
                  Tab(icon: Icon(Icons.menu_book), text: 'المصحف'),
                  Tab(icon: Icon(Icons.access_time), text: 'المواقيت'),
                  Tab(icon: Icon(Icons.wb_sunny_outlined), text: 'الأذكار'),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              QuranIndexScreen(),
              LivePrayerTimesScreen(),
              AzkarScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

// شاشة فهرس سور القرآن الكريم مع خاصية البحث
class QuranIndexScreen extends StatefulWidget {
  const QuranIndexScreen({super.key});

  @override
  State<QuranIndexScreen> createState() => _QuranIndexScreenState();
}

class _QuranIndexScreenState extends State<QuranIndexScreen> {
  final List<Map<String, dynamic>> _allSuwar = [
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
                prefixIcon: const Icon(Icons.search, color: Color(0xFF0F4C3A)),
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
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5D5B6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0F4C3A), width: 1.5),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5D5B6).withOpacity(0.4)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFFAF7F0),
                            child: Text('${surah['id']}', style: const TextStyle(color: Color(0xFF8C7040), fontWeight: FontWeight.bold)),
                          ),
                          title: Text(surah['name'], style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF0F4C3A))),
                          subtitle: Text('${surah['type']} ❖ آياتها ${surah['verses']}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
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
          ),
        ],
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
          "قُل * أَعُوذُ بِرَبِّ الْفَلَقِ",
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
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
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
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A), height: 2.3),
                        ),
                        TextSpan(
                          text: "﴿${index + 1}﴾ ",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xFF8C7040)),
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

// شاشة مواقيت الصلاة (تم تنظيف الـ const الخاطئ تماماً)
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
                      "توقيت جمهورية مصر العربية المحلي القياسي",
                      style: TextStyle(color: Colors.white90, fontSize: 13),
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
        border: Border.all(color: Colors.black.withOpacity(0.02)),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8C7040), size: 22),
        title: Text(name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F4C3A))),
        trailing: Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8C7040))),
      ),
    );
  }
}

// شاشة الأذكار الجديدة مع عداد إلكتروني تفاعلي
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأذكار اليومية', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildZikrCard(
            "سبحان الله وبحمده، عدد خلقه، ورضا نفسه، وزنة عرشه، وميداد كلماته.",
            "من أذكار الصباح والمساء (٣ مرات)",
            3,
            _counter1,
            () {
              if (_counter1 < 3) setState(() => _counter1++);
            },
            () => setState(() => _counter1 = 0),
          ),
          _buildZikrCard(
            "اللَّهُمَّ عافِني في بَدَني، اللَّهُمَّ عافِني في سَمْعي، اللَّهُمَّ عافِني في بَصَري، لا إلهَ إلَّا أنتَ.",
            "الدعاء بالعافية والتحصين اليومي (٣ مرات)",
            3,
            _counter2,
            () {
              if (_counter2 < 3) setState(() => _counter2++);
            },
            () => setState(() => _counter2 = 0),
          ),
        ],
      ),
    );
  }

  Widget _buildZikrCard(String text, String subtitle, int target, int current, VoidCallback onTap, VoidCallback onReset) {
    bool isDone = current >= target;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDone ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDone ? Colors.green.withOpacity(0.5) : const Color(0xFFE5D5B6).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2C3E50), height: 1.6)),
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
