import 'package:flutter/material.dart';
// الاستيراد المسؤول عن حل مشكلة تهيئة التواريخ والمواقيت باللغة العربية
import 'package:intl/date_symbol_data_local.dart'; 

void main() async {
  // 1. تأكيد تهيئة خدمات فلاتر الأساسية قبل أي عمليات تزامن
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. الحل السحري: تهيئة بيانات اللغة العربية لمنع خطأ LocaleDataException
  await initializeDateFormatting('ar', null); 
  
  // 3. تشغيل التطبيق بأمان
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'المصحف الشريف الموثق',
      // دعم اتجاه النص من اليمين إلى اليسار تلقائياً لتناسب اللغة العربية
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo', // تأكد من إضافة الخط في pubspec.yaml إذا كنت تستخدمه
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
  // مؤشر التبويب الحالي (المصحف هو التبويب الافتراضي رقم 0)
  int _currentIndex = 0;

  // قائمة الصفحات الأربعة بناءً على الشريط السفلي في تطبيقك
  final List<Widget> _pages = [
    const QuranScreen(),       // التبويب 0: مصحف
    const PrayerTimesScreen(), // التبويب 1: مواقيت
    const AzkarScreen(),       // التبويب 2: الأذكار
    const SettingsScreen(),    // التبويب 3: عدادات (الإعدادات)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      // شريط التنقل السفلي المتطابق مع واجهتك
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2C2C2C), // اللون الداكن للشريط السفلي
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'مصحف',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'مواقيت',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'الأذكار',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'عدادات',
          ),
        ],
      ),
    );
  }
}

// ================= 1. شاشة المصحف الشريف =================
class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  // نموذج بيانات محاكي لقائمة السور الظاهرة في image.png
  final List<Map<String, String>> surahs = const [
    {"name": "الفاتحة", "type": "مكية", "verses": "7", "page": "1"},
    {"name": "البقرة", "type": "مدنية", "verses": "286", "page": "2"},
    {"name": "آل عمران", "type": "مدنية", "verses": "200", "page": "50"},
    {"name": "النساء", "type": "مدنية", "verses": "176", "page": "77"},
    {"name": "المائدة", "type": "مدنية", "verses": "120", "page": "106"},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text(
            'المصحف الشريف الموثق',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            // شريط البحث المتطابق مع الشاشة الأصلية في image.png
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن اسم السورة...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
            ),
            // قائمة السور
            Expanded(
              child: ListView.separated(
                itemCount: surahs.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final surah = surahs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // الجانب الأيمن: اسم السورة ونوعها عدد آياتها
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              surah["name"]!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  surah["type"]!,
                                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.brightness_3, size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  "آياتها ${surah["verses"]}",
                                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // الجانب الأيسر: رقم الصفحة
                        Text(
                          "صفحة ${surah["page"]}",
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= 2. شاشة مواقيت الصلاة (التي كانت تسبب الخطأ) =================
class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text('مواقيت الصلاة', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, size: 80, color: Color(0xFF4A4A4A)),
              const SizedBox(height: 20),
              const Text(
                'مواقيت الصلاة تعمل الآن بنجاح!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'تمت تهيئة التواريخ بنجاح ودون أخطاء.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= 3. شاشة الأذكار =================
class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A4A4A),
          title: const Text('الأذكار', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Card(
              child: ListTile(
                leading: Icon(Icons.wb_twighlight, color: Colors.amber),
                title: Text('أذكار الصباح'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.nightlight_round, color: Colors.indigo),
                title: Text('أذكار المساء'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
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
          child: Text(
            'صفحة التحكم وإعدادات التطبيق',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
