import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  home: WardSplashScreen(),
  theme: ThemeData(fontFamily: 'Cairo'),
  debugShowCheckedModeBanner: false,
));

// 1. شاشة اللوجو والافتتاحية الأخضر والذهبي
class WardSplashScreen extends StatefulWidget {
  @override
  _WardSplashScreenState createState() => _WardSplashScreenState();
}

class _WardSplashScreenState extends State<WardSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuranWardApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF042F2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xFF064E3B),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFD97706), width: 3),
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 12, offset: Offset(0, 5))],
              ),
              child: Icon(Icons.auto_stories, size: 70, color: Color(0xFFD97706)),
            ),
            SizedBox(height: 25),
            Text("تطبيق وِرْدْ", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFD97706), letterSpacing: 1.5)),
            SizedBox(height: 10),
            Text("رفيقك الذكي لحفظ القرآن الكريم", style: TextStyle(fontSize: 16, color: Color(0xFF2DD4BF), fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}

// 2. واجهة الورد والمصحف التفاعلية المحسنة تشبه الورق
class QuranWardApp extends StatefulWidget {
  @override
  _QuranWardAppState createState() => _QuranWardAppState();
}

class _QuranWardAppState extends State<QuranWardApp> {
  int _currentPage = 1; 
  int _secondsRemaining = 60;
  Timer? _timer;

  final Map<int, Map<String, dynamic>> _quranData = {
    1: {
      "surah": "سُورَةُ الفَاتِحَةِ",
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ﴿١﴾ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ﴿٢﴾ الرَّحْمَٰنِ الرَّحِيمِ ﴿٣﴾ مَالِكِ يَوْمِ الدِّينِ ﴿٤﴾ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ﴿٥﴾ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ﴿٦﴾ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ ﴿٧﴾",
      "reason": "تسمى أم الكتاب، وهي أول سورة نزلت كاملة دفعة واحدة كرقية ومقدمة لكتاب الله العظيم.",
    }
  };

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() { _secondsRemaining--; });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _showReasonOfRevelation(String reason) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFFFFDF3),
        title: Text("سبب النزول (التفسير الميسر)", textAlign: TextAlign.right, style: TextStyle(color: Color(0xFF064E3B), fontWeight: FontWeight.bold)),
        content: Text(reason, textAlign: TextAlign.right, style: TextStyle(fontSize: 16, height: 1.5)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("إغلاق", style: TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var pageData = _quranData[_currentPage] ?? _quranData[1]!;

    return Scaffold(
      backgroundColor: Color(0xFF042F2E),
      appBar: AppBar(
        title: Text("وِرْدُ الحِفْظِ اليَوْمِي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF064E3B),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundColor: Color(0xFF064E3B),
                radius: 24,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Color(0xFFD97706), width: 1.5)),
                  alignment: Alignment.center,
                  child: Text("$_secondsRemaining", style: TextStyle(color: Color(0xFFD97706), fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),

            // ورقة المصحف مع إضافة إطار محاكي للمصحف الورقي
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(8), // مسافة للإطار الخارجي
                    decoration: BoxDecoration(
                      color: Color(0xFFD97706), // لون الإطار الذهبي للمصحف
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFDF3), // لون الورق المريح
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF064E3B), width: 2), // إطار داخلي أخضر
                      ),
                      child: SingleChildScrollView(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [
                              Text(pageData['surah'], style: TextStyle(fontSize: 22, color: Color(0xFF064E3B), fontWeight: FontWeight.bold, letterSpacing: 1)),
                              Text("صفحة [ $_currentPage ]", style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                              Divider(color: Color(0xFFD97706), thickness: 1.5, height: 30),
                              SizedBox(height: 10),
                              
                              // عرض الآيات بشكل منساب ومريح جداً للقراءة والتسميع
                              Text(
                                pageData['text'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24, 
                                  height: 2.3, 
                                  color: Colors.black87, 
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'serif' // محاولة تحسين الخط برمجياً للموقع التجريبي
                                ),
                              ),
                            ],
                        ),
                      ),
                    ),
                  ),
                  ),

                  // زر أسباب النزول الهامشي بالذهبي
                  Positioned(
                    left: 28,
                    top: 28,
                    child: FloatingActionButton.small(
                      backgroundColor: Color(0xFFD97706),
                      child: Icon(Icons.menu_book, color: Colors.white, size: 20),
                      onPressed: () => _showReasonOfRevelation(pageData['reason']),
                    ),
                  )
                ],
              ),
            ),

            // منطقة التحكم السفلية المتناسقة
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _timer?.cancel();
                      SystemNavigator.pop(); 
                    },
                    icon: Icon(Icons.flash_on, color: Colors.white),
                    label: Text("تجاوز اضطراري", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_circle_left, size: 45, color: Color(0xFFD97706)),
                      onPressed: () {
                        setState(() {
                          _currentPage++;
                          _startTimer();
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
