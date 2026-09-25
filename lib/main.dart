import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Put ONLY the base project URL here, ending with .supabase.co (no /rest/v1)
const supabaseUrl = 'https://exrtustvushcwdthambg.supabase.co';
// Put the sb_publishable_... key here. Never use sb_secret_ or service_role.
const supabasePublishableKey = 'sb_publishable_m9emDvWJiyId4csc2p0Mkw_WOKB--1C';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );

  runApp(const CavtApp());
}

final supabase = Supabase.instance.client;

class CavtApp extends StatefulWidget {
  const CavtApp({super.key});
  @override
  State<CavtApp> createState() => _CavtAppState();
}

class _CavtAppState extends State<CavtApp> {
  bool ar = true;
  bool dark = true;

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFB3262D),
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF5A61),
      brightness: Brightness.dark,
    );

    ThemeData buildTheme(ColorScheme scheme, Brightness brightness) {
      return ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorScheme: scheme,
        scaffoldBackgroundColor: brightness == Brightness.dark
            ? const Color(0xFF090C11)
            : const Color(0xFFF6F7F9),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: scheme.onSurface,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: brightness == Brightness.dark
              ? Colors.white.withValues(alpha: .055)
              : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: scheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: scheme.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 72,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAVT Smart Admissions',
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: buildTheme(lightScheme, Brightness.light),
      darkTheme: buildTheme(darkScheme, Brightness.dark),
      builder: (context, child) => Directionality(
        textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
        child: child ?? const SizedBox.shrink(),
      ),
      home: HomeGate(
        ar: ar,
        dark: dark,
        toggleLang: () => setState(() => ar = !ar),
        toggleTheme: () => setState(() => dark = !dark),
      ),
    );
  }
}

class T {
  final bool ar;
  const T(this.ar);
  String x(String a, String e) => ar ? a : e;
}

class CavtMark extends StatelessWidget {
  final double size;
  const CavtMark({super.key, this.size = 92});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7E1118), Color(0xFFB3262D)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        'CAVT',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * .22,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

class Program {
  final String id,
      arName,
      enName,
      arFamily,
      enFamily,
      levelAr,
      levelEn,
      durationAr,
      durationEn;
  final IconData icon;
  final List<String> branches;
  const Program({
    required this.id,
    required this.arName,
    required this.enName,
    required this.arFamily,
    required this.enFamily,
    required this.levelAr,
    required this.levelEn,
    required this.durationAr,
    required this.durationEn,
    required this.icon,
    required this.branches,
  });
  String name(bool ar) => ar ? arName : enName;
  String family(bool ar) => ar ? arFamily : enFamily;
  String level(bool ar) => ar ? levelAr : levelEn;
  String duration(bool ar) => ar ? durationAr : durationEn;
}

const branchNames = <String, List<String>>{
  'hakama': ['حكما', 'Hakama'],
  'irbid_female': ['إربد - إناث', 'Irbid - Female'],
  'yajouz': ['ياجوز', 'Yajouz'],
  'sahab': ['سحاب', 'Sahab'],
  'ain_al_basha': ['عين الباشا', 'Ain Al-Basha'],
  'ghor_safi': ['غور الصافي', 'Ghor Al-Safi'],
  'aqaba': ['العقبة', 'Aqaba'],
};

const programs = <Program>[
  Program(
    id: 'admin',
    arName: 'منسق إداري طبي',
    enName: 'Medical Administrative Coordinator',
    arFamily: 'الإدارة',
    enFamily: 'Administration',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.medical_information_outlined,
    branches: ['hakama', 'yajouz'],
  ),
  Program(
    id: 'mobile',
    arName: 'إلكتروني / هواتف خلوية',
    enName: 'Electronics / Mobile Phones',
    arFamily: 'الإلكترونيات',
    enFamily: 'Electronics',
    levelAr: 'الماهر',
    levelEn: 'Skilled',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.phone_android_rounded,
    branches: ['yajouz', 'hakama'],
  ),
  Program(
    id: 'beauty',
    arName: 'التجميل والحلاقة',
    enName: 'Beauty & Hairdressing',
    arFamily: 'التجميل والحلاقة',
    enFamily: 'Beauty & Hairdressing',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'حسب البرنامج',
    durationEn: 'Depends on program',
    icon: Icons.content_cut_rounded,
    branches: ['hakama', 'irbid_female', 'ain_al_basha', 'ghor_safi', 'aqaba'],
  ),
  Program(
    id: 'welding',
    arName: 'الحدادة واللحام',
    enName: 'Blacksmithing & Welding',
    arFamily: 'الحدادة واللحام',
    enFamily: 'Blacksmithing & Welding',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'حسب البرنامج',
    durationEn: 'Depends on program',
    icon: Icons.hardware_rounded,
    branches: [
      'hakama',
      'yajouz',
      'sahab',
      'ain_al_basha',
      'ghor_safi',
      'aqaba',
    ],
  ),
  Program(
    id: 'electricity',
    arName: 'الكهرباء والتمديدات الكهربائية',
    enName: 'Electricity & Electrical Installations',
    arFamily: 'الكهرباء',
    enFamily: 'Electricity',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'حسب البرنامج',
    durationEn: 'Depends on program',
    icon: Icons.electrical_services_rounded,
    branches: [
      'hakama',
      'yajouz',
      'sahab',
      'ain_al_basha',
      'ghor_safi',
      'aqaba',
    ],
  ),
  Program(
    id: 'cnc',
    arName: 'مشغل آلات تشغيل محوسبة CNC',
    enName: 'CNC Machine Operator',
    arFamily: 'الخراطة وتشغيل الآلات',
    enFamily: 'Machining & Machine Operation',
    levelAr: 'الماهر',
    levelEn: 'Skilled',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.precision_manufacturing_rounded,
    branches: ['sahab', 'yajouz'],
  ),
  Program(
    id: 'data',
    arName: 'مدخل بيانات',
    enName: 'Data Entry',
    arFamily: 'تكنولوجيا المعلومات',
    enFamily: 'Information Technology',
    levelAr: 'الماهر',
    levelEn: 'Skilled',
    durationAr: 'فصل تقريبًا',
    durationEn: 'About one semester',
    icon: Icons.keyboard_alt_rounded,
    branches: [
      'hakama',
      'irbid_female',
      'yajouz',
      'sahab',
      'ain_al_basha',
      'ghor_safi',
      'aqaba',
    ],
  ),
  Program(
    id: 'apps',
    arName: 'مطور التطبيقات المتقدمة',
    enName: 'Advanced Application Developer',
    arFamily: 'تكنولوجيا المعلومات',
    enFamily: 'Information Technology',
    levelAr: 'دبلوم فني',
    levelEn: 'Technical Diploma',
    durationAr: '4 فصول تقريبًا',
    durationEn: 'About 4 semesters',
    icon: Icons.code_rounded,
    branches: ['hakama', 'ain_al_basha'],
  ),
  Program(
    id: 'mechanic',
    arName: 'ميكانيكي مركبات خفيفة',
    enName: 'Light Vehicle Mechanic',
    arFamily: 'صيانة المركبات',
    enFamily: 'Vehicle Maintenance',
    levelAr: 'الماهر',
    levelEn: 'Skilled',
    durationAr: '3 فصول تقريبًا',
    durationEn: 'About 3 semesters',
    icon: Icons.car_repair_rounded,
    branches: ['hakama', 'yajouz', 'sahab', 'ain_al_basha', 'aqaba'],
  ),
  Program(
    id: 'velectric',
    arName: 'كهربائي مركبات',
    enName: 'Vehicle Electrician',
    arFamily: 'كهرباء المركبات',
    enFamily: 'Vehicle Electricity',
    levelAr: 'الماهر',
    levelEn: 'Skilled',
    durationAr: '3 فصول تقريبًا',
    durationEn: 'About 3 semesters',
    icon: Icons.electric_car_rounded,
    branches: ['hakama', 'sahab', 'ain_al_basha', 'ghor_safi', 'aqaba'],
  ),
  Program(
    id: 'body',
    arName: 'دهان ومجلس مركبات',
    enName: 'Vehicle Painting & Body Repair',
    arFamily: 'صيانة المركبات',
    enFamily: 'Vehicle Maintenance',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'حسب البرنامج',
    durationEn: 'Depends on program',
    icon: Icons.format_paint_rounded,
    branches: ['yajouz', 'sahab', 'aqaba'],
  ),
  Program(
    id: 'hvac',
    arName: 'التكييف والتبريد',
    enName: 'HVAC & Refrigeration',
    arFamily: 'التكييف والتبريد',
    enFamily: 'HVAC & Refrigeration',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'حسب البرنامج',
    durationEn: 'Depends on program',
    icon: Icons.ac_unit_rounded,
    branches: [
      'hakama',
      'yajouz',
      'sahab',
      'ain_al_basha',
      'ghor_safi',
      'aqaba',
    ],
  ),
  Program(
    id: 'plumbing',
    arName: 'التمديدات الصحية',
    enName: 'Plumbing',
    arFamily: 'التمديدات الصحية',
    enFamily: 'Plumbing',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'حسب البرنامج',
    durationEn: 'Depends on program',
    icon: Icons.plumbing_rounded,
    branches: ['hakama', 'yajouz', 'sahab', 'ain_al_basha', 'aqaba'],
  ),
  Program(
    id: 'carpentry',
    arName: 'النجارة وصناعة الأثاث',
    enName: 'Carpentry & Furniture',
    arFamily: 'النجارة',
    enFamily: 'Carpentry',
    levelAr: 'الماهر',
    levelEn: 'Skilled',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.carpenter_rounded,
    branches: ['hakama', 'yajouz', 'sahab', 'ain_al_basha', 'aqaba'],
  ),
  Program(
    id: 'sewing',
    arName: 'الخياطة والصناعات النسيجية',
    enName: 'Sewing & Textiles',
    arFamily: 'الخياطة',
    enFamily: 'Sewing',
    levelAr: 'الماهر / محدد المهارات',
    levelEn: 'Skilled / Limited Skills',
    durationAr: 'فصل إلى فصلين تقريبًا',
    durationEn: 'About 1-2 semesters',
    icon: Icons.checkroom_rounded,
    branches: ['hakama', 'irbid_female', 'ain_al_basha', 'ghor_safi', 'aqaba'],
  ),
  Program(
    id: 'food',
    arName: 'فنون الطهي والصناعات الغذائية',
    enName: 'Culinary Arts & Food Production',
    arFamily: 'فنون الطهي والصناعات الغذائية',
    enFamily: 'Culinary Arts & Food Production',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.restaurant_rounded,
    branches: ['sahab', 'aqaba'],
  ),
  Program(
    id: 'health',
    arName: 'الرعاية الشخصية والصحية',
    enName: 'Personal & Healthcare Services',
    arFamily: 'الرعاية الصحية',
    enFamily: 'Healthcare',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.health_and_safety_outlined,
    branches: ['hakama', 'irbid_female'],
  ),
  Program(
    id: 'decor',
    arName: 'الديكور',
    enName: 'Decoration',
    arFamily: 'الديكور',
    enFamily: 'Decoration',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.design_services_rounded,
    branches: ['hakama', 'yajouz'],
  ),
  Program(
    id: 'logistics',
    arName: 'الدعم اللوجستي',
    enName: 'Logistics Support',
    arFamily: 'الدعم اللوجستي',
    enFamily: 'Logistics',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.local_shipping_outlined,
    branches: ['sahab', 'aqaba'],
  ),
  Program(
    id: 'retail',
    arName: 'البيع بالتجزئة',
    enName: 'Retail',
    arFamily: 'البيع بالتجزئة',
    enFamily: 'Retail',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.storefront_outlined,
    branches: ['hakama', 'aqaba'],
  ),
  Program(
    id: 'osh',
    arName: 'السلامة والصحة المهنية',
    enName: 'Occupational Safety & Health',
    arFamily: 'السلامة والصحة المهنية',
    enFamily: 'Occupational Safety & Health',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.health_and_safety_rounded,
    branches: ['hakama', 'sahab'],
  ),
  Program(
    id: 'maintenance',
    arName: 'الصيانة العامة',
    enName: 'General Maintenance',
    arFamily: 'الصيانة العامة',
    enFamily: 'General Maintenance',
    levelAr: 'برنامج مهني',
    levelEn: 'Vocational Program',
    durationAr: 'حسب الخطة المعتمدة',
    durationEn: 'Per approved plan',
    icon: Icons.build_circle_outlined,
    branches: ['yajouz', 'sahab', 'ain_al_basha'],
  ),
];

class HomeGate extends StatefulWidget {
  final bool ar, dark;
  final VoidCallback toggleLang, toggleTheme;

  const HomeGate({
    super.key,
    required this.ar,
    required this.dark,
    required this.toggleLang,
    required this.toggleTheme,
  });

  @override
  State<HomeGate> createState() => _HomeGateState();
}

class _HomeGateState extends State<HomeGate> {
  bool guest = false;
  String? portalIntent;

  Future<void> _logout() async {
    await supabase.auth.signOut();
    if (mounted) {
      setState(() {
        guest = false;
        portalIntent = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;

        if (session != null) {
          return RoleGate(
            ar: widget.ar,
            dark: widget.dark,
            expectedPortal: portalIntent,
            toggleLang: widget.toggleLang,
            toggleTheme: widget.toggleTheme,
            onLogout: _logout,
          );
        }

        if (guest) {
          return MainShell(
            ar: widget.ar,
            dark: widget.dark,
            user: widget.ar ? 'زائر' : 'Guest',
            isGuest: true,
            toggleLang: widget.toggleLang,
            toggleTheme: widget.toggleTheme,
            onLogout: () => setState(() => guest = false),
          );
        }

        return LoginPage(
          ar: widget.ar,
          dark: widget.dark,
          toggleLang: widget.toggleLang,
          toggleTheme: widget.toggleTheme,
          onGuest: () {
            setState(() {
              portalIntent = 'student';
              guest = true;
            });
          },
          onPortalIntent: (value) {
            if (mounted) setState(() => portalIntent = value);
          },
        );
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  final bool ar, dark;
  final VoidCallback toggleLang, toggleTheme, onGuest;
  final ValueChanged<String> onPortalIntent;

  const LoginPage({
    super.key,
    required this.ar,
    required this.dark,
    required this.toggleLang,
    required this.toggleTheme,
    required this.onGuest,
    required this.onPortalIntent,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  String portal = 'student';
  bool hide = true;
  bool createAccount = false;
  bool loading = false;

  bool get isAdminPortal => portal == 'admin';

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  void _message(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _setPortal(String value) {
    if (loading || value == portal) return;
    setState(() {
      portal = value;
      createAccount = false;
    });
    widget.onPortalIntent(value);
  }

  Future<void> _submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final t = T(widget.ar);
    widget.onPortalIntent(portal);
    setState(() => loading = true);

    try {
      if (!isAdminPortal && createAccount) {
        final response = await supabase.auth.signUp(
          email: email.text.trim(),
          password: pass.text,
          data: {'full_name': name.text.trim()},
        );

        if (response.session == null) {
          _message(
            t.x(
              'تم إنشاء الحساب. افتح بريدك الإلكتروني وأكّد الحساب ثم سجّل الدخول من بوابة الطالب.',
              'Account created. Confirm your email, then sign in from the Student Portal.',
            ),
          );
          if (mounted) setState(() => createAccount = false);
        }
      } else {
        await supabase.auth.signInWithPassword(
          email: email.text.trim(),
          password: pass.text,
        );
      }
    } on AuthException catch (e) {
      _message(e.message);
    } catch (e) {
      _message(
        t.x(
          'تعذر إكمال العملية. حاول مرة أخرى.',
          'Could not complete the request. Please try again.',
        ),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _forgotPassword() async {
    final t = T(widget.ar);
    final value = email.text.trim();

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      _message(
        t.x('اكتب بريدك الإلكتروني أولًا.', 'Enter your email address first.'),
      );
      return;
    }

    try {
      await supabase.auth.resetPasswordForEmail(value);
      _message(
        t.x(
          'تم إرسال رسالة استعادة كلمة المرور إلى بريدك.',
          'A password recovery email has been sent.',
        ),
      );
    } on AuthException catch (e) {
      _message(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: widget.toggleLang,
            child: Text(widget.ar ? 'English' : 'العربية'),
          ),
          IconButton(
            tooltip: t.x('تغيير المظهر', 'Change theme'),
            onPressed: widget.toggleTheme,
            icon: Icon(
              widget.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(child: CavtMark(size: 96)),
                        const SizedBox(height: 18),
                        Text(
                          t.x(
                            'كلية التدريب المهني المتقدم',
                            'College of Advanced Vocational Training',
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          t.x(
                            'بوابة القبول والتسجيل الذكية',
                            'Smart Admissions Portal',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          t.x('اختر بوابة الدخول', 'Choose Portal'),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _PortalChoiceCard(
                                selected: portal == 'student',
                                icon: Icons.school_rounded,
                                title: t.x(
                                  'التسجيل والقبول',
                                  'Student Admissions',
                                ),
                                subtitle: t.x(
                                  'للطلاب والمتقدمين',
                                  'For applicants',
                                ),
                                onTap: () => _setPortal('student'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _PortalChoiceCard(
                                selected: portal == 'admin',
                                icon: Icons.admin_panel_settings_rounded,
                                title: t.x('الإدارة', 'Administration'),
                                subtitle: t.x(
                                  'لموظفي الفروع',
                                  'For branch staff',
                                ),
                                onTap: () => _setPortal('admin'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: cs.primary.withValues(
                                          alpha: .12,
                                        ),
                                        child: Icon(
                                          isAdminPortal
                                              ? Icons.badge_outlined
                                              : Icons.person_outline_rounded,
                                          color: cs.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              isAdminPortal
                                                  ? t.x(
                                                      'دخول إدارة القبول',
                                                      'Admissions Staff Sign In',
                                                    )
                                                  : t.x(
                                                      createAccount
                                                          ? 'إنشاء حساب طالب'
                                                          : 'دخول الطالب',
                                                      createAccount
                                                          ? 'Create Student Account'
                                                          : 'Student Sign In',
                                                    ),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              isAdminPortal
                                                  ? t.x(
                                                      'هذه البوابة للحسابات الإدارية المعتمدة فقط.',
                                                      'Only approved staff accounts can use this portal.',
                                                    )
                                                  : t.x(
                                                      'يمكن لأي متقدم إنشاء حساب ومتابعة طلبه.',
                                                      'Any applicant can create an account and track an application.',
                                                    ),
                                              style: TextStyle(
                                                color: cs.onSurfaceVariant,
                                                height: 1.35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (!isAdminPortal) ...[
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: cs.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: !createAccount
                                                ? FilledButton.tonal(
                                                    onPressed: null,
                                                    child: Text(
                                                      t.x(
                                                        'تسجيل الدخول',
                                                        'Sign In',
                                                      ),
                                                    ),
                                                  )
                                                : TextButton(
                                                    onPressed: loading
                                                        ? null
                                                        : () => setState(
                                                            () =>
                                                                createAccount =
                                                                    false,
                                                          ),
                                                    child: Text(
                                                      t.x(
                                                        'تسجيل الدخول',
                                                        'Sign In',
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: createAccount
                                                ? FilledButton.tonal(
                                                    onPressed: null,
                                                    child: Text(
                                                      t.x(
                                                        'إنشاء حساب',
                                                        'Create Account',
                                                      ),
                                                    ),
                                                  )
                                                : TextButton(
                                                    onPressed: loading
                                                        ? null
                                                        : () => setState(
                                                            () =>
                                                                createAccount =
                                                                    true,
                                                          ),
                                                    child: Text(
                                                      t.x(
                                                        'إنشاء حساب',
                                                        'Create Account',
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 16),
                                  if (!isAdminPortal && createAccount) ...[
                                    TextFormField(
                                      controller: name,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: t.x(
                                          'الاسم الكامل',
                                          'Full Name',
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                        ),
                                      ),
                                      validator: (v) =>
                                          (v ?? '').trim().length >= 3
                                          ? null
                                          : t.x(
                                              'أدخل الاسم الكامل.',
                                              'Enter your full name.',
                                            ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  TextFormField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      labelText: t.x(
                                        'البريد الإلكتروني',
                                        'Email',
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                      ),
                                    ),
                                    validator: (v) {
                                      final value = (v ?? '').trim();
                                      return RegExp(
                                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                          ).hasMatch(value)
                                          ? null
                                          : t.x(
                                              'أدخل بريدًا إلكترونيًا صحيحًا.',
                                              'Enter a valid email address.',
                                            );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: pass,
                                    obscureText: hide,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: loading
                                        ? null
                                        : (_) => _submit(),
                                    decoration: InputDecoration(
                                      labelText: t.x('كلمة المرور', 'Password'),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            setState(() => hide = !hide),
                                        icon: Icon(
                                          hide
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                        ),
                                      ),
                                    ),
                                    validator: (v) {
                                      if ((v ?? '').length < 6) {
                                        return t.x(
                                          'كلمة المرور يجب أن تكون 6 أحرف على الأقل.',
                                          'Password must be at least 6 characters.',
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                                  if (!(createAccount && !isAdminPortal))
                                    Align(
                                      alignment: widget.ar
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: loading
                                            ? null
                                            : _forgotPassword,
                                        child: Text(
                                          t.x(
                                            'نسيت كلمة المرور؟',
                                            'Forgot password?',
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 14),
                                  FilledButton.icon(
                                    onPressed: loading ? null : _submit,
                                    icon: loading
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Icon(
                                            !isAdminPortal && createAccount
                                                ? Icons.person_add_alt_1_rounded
                                                : Icons.login_rounded,
                                          ),
                                    label: Text(
                                      !isAdminPortal && createAccount
                                          ? t.x(
                                              'إنشاء حساب الطالب',
                                              'Create Student Account',
                                            )
                                          : isAdminPortal
                                          ? t.x('دخول الإدارة', 'Staff Sign In')
                                          : t.x(
                                              'دخول الطالب',
                                              'Student Sign In',
                                            ),
                                    ),
                                  ),
                                  if (!isAdminPortal) ...[
                                    const SizedBox(height: 10),
                                    OutlinedButton.icon(
                                      onPressed: loading
                                          ? null
                                          : widget.onGuest,
                                      icon: const Icon(Icons.explore_outlined),
                                      label: Text(
                                        t.x(
                                          'استكشاف البرامج كزائر',
                                          'Explore Programs as Guest',
                                        ),
                                      ),
                                    ),
                                  ],
                                  if (isAdminPortal) ...[
                                    const SizedBox(height: 12),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.lock_person_outlined,
                                          size: 19,
                                          color: cs.onSurfaceVariant,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            t.x(
                                              'لا يمكن إنشاء حساب إدارة من التطبيق. الحسابات الإدارية ينشئها مسؤول النظام ويحدد الفرع التابع لكل حساب.',
                                              'Staff accounts cannot be created from the app. They are provisioned by the system administrator and assigned to a branch.',
                                            ),
                                            style: TextStyle(
                                              color: cs.onSurfaceVariant,
                                              height: 1.45,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _PortalChoiceCard extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;

  const _PortalChoiceCard({
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? cs.primaryContainer
          : cs.surfaceContainerHighest.withValues(alpha: .62),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? cs.primary : cs.outlineVariant,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: selected ? cs.primary : cs.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleGate extends StatefulWidget {
  final bool ar, dark;
  final String? expectedPortal;
  final VoidCallback toggleLang, toggleTheme;
  final FutureOr<void> Function() onLogout;

  const RoleGate({
    super.key,
    required this.ar,
    required this.dark,
    required this.expectedPortal,
    required this.toggleLang,
    required this.toggleTheme,
    required this.onLogout,
  });

  @override
  State<RoleGate> createState() => _RoleGateState();
}

class _RoleGateState extends State<RoleGate> {
  late Future<Map<String, dynamic>> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadProfile();
  }

  Future<Map<String, dynamic>> _loadProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      return {'role': 'student', 'full_name': '', 'branch_id': null};
    }

    final row = await supabase
        .from('profiles')
        .select('full_name, role, branch_id')
        .eq('id', user.id)
        .single();

    return Map<String, dynamic>.from(row);
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);

    return FutureBuilder<Map<String, dynamic>>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return _PortalAccessMessage(
            icon: Icons.error_outline_rounded,
            title: t.x(
              'تعذر التحقق من صلاحيات الحساب',
              'Could Not Verify Account Access',
            ),
            message: t.x(
              'تأكد من اتصال الإنترنت ومن إعداد قاعدة البيانات ثم حاول تسجيل الدخول مرة أخرى.',
              'Check the internet connection and database setup, then sign in again.',
            ),
            buttonLabel: t.x('العودة لتسجيل الدخول', 'Back to Sign In'),
            onPressed: () => widget.onLogout(),
          );
        }

        final user = supabase.auth.currentUser;
        final data = snapshot.data ?? const <String, dynamic>{};
        final role = (data['role'] ?? 'student').toString();
        final branchId = data['branch_id']?.toString();
        final profileName = (data['full_name'] ?? '').toString().trim();
        final metadataName =
            (user?.userMetadata?['full_name'] as String?)?.trim() ?? '';
        final displayName = profileName.isNotEmpty
            ? profileName
            : (metadataName.isNotEmpty
                  ? metadataName
                  : (user?.email?.split('@').first ??
                        (widget.ar ? 'مستخدم' : 'User')));

        final isStaff = role == 'admin' || role == 'reviewer';

        if (widget.expectedPortal == 'admin' && !isStaff) {
          return _PortalAccessMessage(
            icon: Icons.admin_panel_settings_outlined,
            title: t.x(
              'هذا الحساب ليس حساب إدارة',
              'This Is Not a Staff Account',
            ),
            message: t.x(
              'حسابات الطلاب تدخل من بوابة التسجيل والقبول. لا يمكن للطالب الدخول إلى لوحة الإدارة.',
              'Student accounts must use the Student Admissions portal and cannot access the admin dashboard.',
            ),
            buttonLabel: t.x('العودة', 'Go Back'),
            onPressed: () => widget.onLogout(),
          );
        }

        if (widget.expectedPortal == 'student' && isStaff) {
          return _PortalAccessMessage(
            icon: Icons.school_outlined,
            title: t.x('هذا حساب إدارة', 'This Is a Staff Account'),
            message: t.x(
              'استخدم بوابة الإدارة للدخول بهذا الحساب.',
              'Use the Administration portal to sign in with this account.',
            ),
            buttonLabel: t.x('العودة', 'Go Back'),
            onPressed: () => widget.onLogout(),
          );
        }

        if (isStaff) {
          if (branchId == null ||
              branchId.isEmpty ||
              !branchNames.containsKey(branchId)) {
            return _PortalAccessMessage(
              icon: Icons.location_off_outlined,
              title: t.x(
                'حساب الإدارة غير مربوط بفرع',
                'Staff Account Has No Branch',
              ),
              message: t.x(
                'يجب أن يحدد مسؤول النظام الفرع التابع لهذا الحساب قبل استخدام لوحة الإدارة.',
                'A system administrator must assign this staff account to a branch before the dashboard can be used.',
              ),
              buttonLabel: t.x('تسجيل الخروج', 'Sign Out'),
              onPressed: () => widget.onLogout(),
            );
          }

          return AdminShell(
            ar: widget.ar,
            dark: widget.dark,
            user: displayName,
            role: role,
            branchId: branchId,
            toggleLang: widget.toggleLang,
            toggleTheme: widget.toggleTheme,
            onLogout: widget.onLogout,
          );
        }

        return MainShell(
          ar: widget.ar,
          dark: widget.dark,
          user: displayName,
          isGuest: false,
          toggleLang: widget.toggleLang,
          toggleTheme: widget.toggleTheme,
          onLogout: widget.onLogout,
        );
      },
    );
  }
}

class _PortalAccessMessage extends StatelessWidget {
  final IconData icon;
  final String title, message, buttonLabel;
  final VoidCallback onPressed;

  const _PortalAccessMessage({
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(icon, size: 58, color: cs.primary),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton.icon(
                        onPressed: onPressed,
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: Text(buttonLabel),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _adminStatusLabel(bool ar, String? code) {
  switch (code) {
    case 'under_review':
      return ar ? 'قيد المراجعة' : 'Under Review';
    case 'document_review':
      return ar ? 'تدقيق الوثائق' : 'Document Review';
    case 'interview':
      return ar ? 'المقابلة' : 'Interview';
    case 'decision':
      return ar ? 'قرار القبول' : 'Admission Decision';
    case 'accepted':
      return ar ? 'مقبول' : 'Accepted';
    case 'rejected':
      return ar ? 'مرفوض' : 'Rejected';
    case 'completed':
      return ar ? 'تم استكمال التسجيل' : 'Registration Completed';
    default:
      return ar ? 'تم الاستلام' : 'Received';
  }
}

String _adminDocumentLabel(bool ar, String? code) {
  switch (code) {
    case 'identity':
      return ar ? 'الهوية' : 'Identity';
    case 'certificate':
      return ar ? 'الشهادة' : 'Certificate';
    default:
      return ar ? 'مرفق آخر' : 'Other Document';
  }
}

String _simpleDate(dynamic value) {
  if (value == null) return '-';
  final parsed = DateTime.tryParse(value.toString())?.toLocal();
  if (parsed == null) return value.toString();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${parsed.year}-${two(parsed.month)}-${two(parsed.day)} '
      '${two(parsed.hour)}:${two(parsed.minute)}';
}

class AdminShell extends StatefulWidget {
  final bool ar, dark;
  final String user, role, branchId;
  final VoidCallback toggleLang, toggleTheme;
  final FutureOr<void> Function() onLogout;

  const AdminShell({
    super.key,
    required this.ar,
    required this.dark,
    required this.user,
    required this.role,
    required this.branchId,
    required this.toggleLang,
    required this.toggleTheme,
    required this.onLogout,
  });

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int index = 0;
  int revision = 0;

  void _open(int value) {
    setState(() => index = value);
  }

  void _refreshAdminData() {
    setState(() => revision++);
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);

    final pages = [
      AdminDashboardPage(
        key: ValueKey('admin-dashboard-$revision'),
        ar: widget.ar,
        user: widget.user,
        branchId: widget.branchId,
        openApplications: () => _open(1),
      ),
      AdminApplicationsPage(
        key: ValueKey('admin-applications-$revision'),
        ar: widget.ar,
        branchId: widget.branchId,
        onChanged: _refreshAdminData,
      ),
      AdminProfilePage(
        ar: widget.ar,
        dark: widget.dark,
        user: widget.user,
        role: widget.role,
        branchId: widget.branchId,
        toggleLang: widget.toggleLang,
        toggleTheme: widget.toggleTheme,
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: _open,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard_rounded),
            label: t.x('لوحة التحكم', 'Dashboard'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.fact_check_outlined),
            selectedIcon: const Icon(Icons.fact_check_rounded),
            label: t.x('الطلبات', 'Applications'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            selectedIcon: const Icon(Icons.admin_panel_settings_rounded),
            label: t.x('حساب الإدارة', 'Admin Account'),
          ),
        ],
      ),
    );
  }
}

class AdminDashboardPage extends StatefulWidget {
  final bool ar;
  final String user, branchId;
  final VoidCallback openApplications;

  const AdminDashboardPage({
    super.key,
    required this.ar,
    required this.user,
    required this.branchId,
    required this.openApplications,
  });

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool loading = true;
  String? error;
  List<Map<String, dynamic>> applications = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final rows = await supabase
          .from('applications')
          .select('id, status, created_at, branch_id')
          .eq('branch_id', widget.branchId)
          .order('created_at', ascending: false);
      applications = List<Map<String, dynamic>>.from(rows);
    } on PostgrestException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    }

    if (mounted) setState(() => loading = false);
  }

  int _count(String status) =>
      applications.where((a) => a['status'] == status).length;

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final cs = Theme.of(context).colorScheme;
    final inProgress = applications.where((a) {
      final s = a['status'];
      return s == 'under_review' ||
          s == 'document_review' ||
          s == 'interview' ||
          s == 'decision';
    }).length;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              t.x(
                'لوحة إدارة القبول - ${branchNames[widget.branchId]?[0] ?? widget.branchId}',
                'Admissions Dashboard - ${branchNames[widget.branchId]?[1] ?? widget.branchId}',
              ),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              t.x(
                'مرحبًا ${widget.user}. راقب الطلبات وحدّث مراحل القبول من مكان واحد.',
                'Welcome ${widget.user}. Review applications and manage admission stages from one place.',
              ),
              style: TextStyle(color: cs.onSurfaceVariant, height: 1.5),
            ),
            const SizedBox(height: 18),
            if (loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(error!),
                ),
              )
            else ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _AdminStatCard(
                    icon: Icons.inventory_2_outlined,
                    label: t.x('طلبات الفرع', 'Branch Applications'),
                    value: applications.length,
                  ),
                  _AdminStatCard(
                    icon: Icons.mark_email_unread_outlined,
                    label: t.x('طلبات جديدة', 'New'),
                    value: _count('received'),
                  ),
                  _AdminStatCard(
                    icon: Icons.pending_actions_outlined,
                    label: t.x('قيد المعالجة', 'In Progress'),
                    value: inProgress,
                  ),
                  _AdminStatCard(
                    icon: Icons.check_circle_outline,
                    label: t.x('مقبول', 'Accepted'),
                    value: _count('accepted'),
                  ),
                  _AdminStatCard(
                    icon: Icons.cancel_outlined,
                    label: t.x('مرفوض', 'Rejected'),
                    value: _count('rejected'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.x('إدارة الطلبات', 'Application Management'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.x(
                          'افتح قائمة الطلبات لمراجعة بيانات المتقدمين والمرفقات وتغيير حالة كل طلب وإضافة ملاحظة للمراجعة.',
                          'Open the application list to review applicant data and attachments, change status, and add a reviewer note.',
                        ),
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 14),
                      FilledButton.icon(
                        onPressed: widget.openApplications,
                        icon: const Icon(Icons.fact_check_rounded),
                        label: Text(
                          t.x('فتح طلبات الفرع', 'Open Branch Applications'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AdminStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const _AdminStatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final width = (MediaQuery.sizeOf(context).width - 42) / 2;
    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: cs.primary),
              const SizedBox(height: 12),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminApplicationsPage extends StatefulWidget {
  final bool ar;
  final String branchId;
  final VoidCallback onChanged;

  const AdminApplicationsPage({
    super.key,
    required this.ar,
    required this.branchId,
    required this.onChanged,
  });

  @override
  State<AdminApplicationsPage> createState() => _AdminApplicationsPageState();
}

class _AdminApplicationsPageState extends State<AdminApplicationsPage> {
  bool loading = true;
  String? error;
  String query = '';
  String filter = 'all';
  List<Map<String, dynamic>> applications = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final rows = await supabase
          .from('applications')
          .select(
            'id, application_number, applicant_id, applicant_name, national_id, phone, education_level, program_id, branch_id, status, reviewer_note, created_at, updated_at',
          )
          .eq('branch_id', widget.branchId)
          .order('created_at', ascending: false);
      applications = List<Map<String, dynamic>>.from(rows);
    } on PostgrestException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    }

    if (mounted) setState(() => loading = false);
  }

  List<Map<String, dynamic>> get visible {
    final q = query.trim().toLowerCase();
    return applications.where((a) {
      final matchesStatus = filter == 'all' || a['status'] == filter;
      final haystack = [
        a['application_number'],
        a['applicant_name'],
        a['national_id'],
        a['phone'],
        a['program_id'],
        a['branch_id'],
      ].map((v) => (v ?? '').toString().toLowerCase()).join(' ');
      final matchesQuery = q.isEmpty || haystack.contains(q);
      return matchesStatus && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.x(
                      'طلبات ${branchNames[widget.branchId]?[0] ?? widget.branchId}',
                      '${branchNames[widget.branchId]?[1] ?? widget.branchId} Applications',
                    ),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: t.x('تحديث', 'Refresh'),
                  onPressed: _load,
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: t.x(
                  'ابحث بالاسم أو رقم الطلب أو الرقم الوطني...',
                  'Search by name, application number, or national ID...',
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: filter,
              decoration: InputDecoration(
                labelText: t.x('تصفية حسب الحالة', 'Filter by Status'),
              ),
              items: [
                DropdownMenuItem(
                  value: 'all',
                  child: Text(t.x('كل الحالات', 'All Statuses')),
                ),
                ...[
                  'received',
                  'under_review',
                  'document_review',
                  'interview',
                  'decision',
                  'accepted',
                  'rejected',
                  'completed',
                ].map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(_adminStatusLabel(widget.ar, s)),
                  ),
                ),
              ],
              onChanged: (v) => setState(() => filter = v ?? 'all'),
            ),
            const SizedBox(height: 14),
            if (loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(error!),
                ),
              )
            else if (visible.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Text(
                    t.x('لا توجد طلبات مطابقة.', 'No matching applications.'),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...visible.map((a) {
                final program = programs.firstWhere(
                  (p) => p.id == a['program_id'],
                  orElse: () => programs.first,
                );
                final branchId = a['branch_id']?.toString();
                final branchName =
                    branchNames[branchId]?[widget.ar ? 0 : 1] ??
                    (branchId ?? '-');

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: cs.primary.withValues(alpha: .12),
                        child: Icon(
                          Icons.person_search_rounded,
                          color: cs.primary,
                        ),
                      ),
                      title: Text(
                        (a['applicant_name'] ?? '-').toString(),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      subtitle: Text(
                        '${a['application_number']}\n'
                        '${program.name(widget.ar)} • $branchName',
                      ),
                      isThreeLine: true,
                      trailing: Chip(
                        label: Text(
                          _adminStatusLabel(widget.ar, a['status']?.toString()),
                        ),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminApplicationDetailsPage(
                              ar: widget.ar,
                              applicationId: a['id'].toString(),
                            ),
                          ),
                        );
                        await _load();
                        widget.onChanged();
                      },
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class AdminApplicationDetailsPage extends StatefulWidget {
  final bool ar;
  final String applicationId;

  const AdminApplicationDetailsPage({
    super.key,
    required this.ar,
    required this.applicationId,
  });

  @override
  State<AdminApplicationDetailsPage> createState() =>
      _AdminApplicationDetailsPageState();
}

class _AdminApplicationDetailsPageState
    extends State<AdminApplicationDetailsPage> {
  bool loading = true;
  bool saving = false;
  String? error;
  Map<String, dynamic>? application;
  List<Map<String, dynamic>> documents = [];
  List<Map<String, dynamic>> history = [];
  String status = 'received';
  final note = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final appRow = await supabase
          .from('applications')
          .select(
            'id, application_number, applicant_id, applicant_name, national_id, phone, education_level, program_id, branch_id, status, reviewer_note, created_at, updated_at',
          )
          .eq('id', widget.applicationId)
          .single();

      final docRows = await supabase
          .from('application_documents')
          .select('id, document_type, storage_path, original_name, created_at')
          .eq('application_id', widget.applicationId)
          .order('created_at');

      final historyRows = await supabase
          .from('application_status_history')
          .select('id, status, note, changed_by, created_at')
          .eq('application_id', widget.applicationId)
          .order('created_at');

      application = Map<String, dynamic>.from(appRow);
      documents = List<Map<String, dynamic>>.from(docRows);
      history = List<Map<String, dynamic>>.from(historyRows);
      status = application?['status']?.toString() ?? 'received';
      note.text = application?['reviewer_note']?.toString() ?? '';
    } on PostgrestException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    }

    if (mounted) setState(() => loading = false);
  }

  Future<void> _save() async {
    final t = T(widget.ar);
    setState(() => saving = true);

    try {
      await supabase
          .from('applications')
          .update({
            'status': status,
            'reviewer_note': note.text.trim().isEmpty ? null : note.text.trim(),
          })
          .eq('id', widget.applicationId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.x('تم تحديث الطلب بنجاح.', 'Application updated successfully.'),
          ),
        ),
      );

      await _load();
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final a = application;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('تفاصيل الطلب', 'Application Details')),
        actions: [
          IconButton(
            tooltip: t.x('تحديث', 'Refresh'),
            onPressed: _load,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(error!),
              ),
            )
          : a == null
          ? Center(
              child: Text(
                t.x('تعذر العثور على الطلب.', 'Application not found.'),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (a['application_number'] ?? '-').toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _kv(
                          t.x('اسم المتقدم', 'Applicant'),
                          (a['applicant_name'] ?? '-').toString(),
                        ),
                        _kv(
                          t.x('الرقم الوطني', 'National ID'),
                          (a['national_id'] ?? '-').toString(),
                        ),
                        _kv(
                          t.x('رقم الهاتف', 'Phone'),
                          (a['phone'] ?? '-').toString(),
                        ),
                        _kv(
                          t.x('المؤهل الدراسي', 'Education'),
                          (a['education_level'] ?? '-').toString(),
                        ),
                        _kv(
                          t.x('التخصص', 'Program'),
                          programs
                              .firstWhere(
                                (p) => p.id == a['program_id'],
                                orElse: () => programs.first,
                              )
                              .name(widget.ar),
                        ),
                        _kv(
                          t.x('الفرع', 'Branch'),
                          branchNames[a['branch_id']]?[widget.ar ? 0 : 1] ??
                              (a['branch_id'] ?? '-').toString(),
                        ),
                        _kv(
                          t.x('تاريخ التقديم', 'Submitted'),
                          _simpleDate(a['created_at']),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.x('قرار ومراجعة الطلب', 'Review & Decision'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          initialValue: status,
                          decoration: InputDecoration(
                            labelText: t.x('حالة الطلب', 'Application Status'),
                          ),
                          items:
                              [
                                    'received',
                                    'under_review',
                                    'document_review',
                                    'interview',
                                    'decision',
                                    'accepted',
                                    'rejected',
                                    'completed',
                                  ]
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(
                                        _adminStatusLabel(widget.ar, s),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: saving
                              ? null
                              : (v) {
                                  if (v != null) {
                                    setState(() => status = v);
                                  }
                                },
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: note,
                          enabled: !saving,
                          minLines: 3,
                          maxLines: 6,
                          decoration: InputDecoration(
                            labelText: t.x('ملاحظة المراجع', 'Reviewer Note'),
                            hintText: t.x(
                              'مثال: الوثائق مكتملة أو يرجى إحضار الأصل للمقابلة.',
                              'Example: Documents complete or bring originals to the interview.',
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        FilledButton.icon(
                          onPressed: saving ? null : _save,
                          icon: saving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save_rounded),
                          label: Text(
                            saving
                                ? t.x('جاري الحفظ...', 'Saving...')
                                : t.x('حفظ التحديث', 'Save Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.x('المرفقات', 'Attachments'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (documents.isEmpty)
                          Text(t.x('لا توجد مرفقات.', 'No attachments.'))
                        else
                          ...documents.map(
                            (d) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.attach_file_rounded),
                              title: Text(
                                _adminDocumentLabel(
                                  widget.ar,
                                  d['document_type']?.toString(),
                                ),
                              ),
                              subtitle: Text(
                                (d['original_name'] ?? d['storage_path'] ?? '-')
                                    .toString(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.x('سجل الحالة', 'Status History'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (history.isEmpty)
                          Text(t.x('لا يوجد سجل بعد.', 'No history yet.'))
                        else
                          ...history.reversed.map(
                            (h) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.history_rounded),
                              title: Text(
                                _adminStatusLabel(
                                  widget.ar,
                                  h['status']?.toString(),
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              subtitle: Text(
                                [
                                  if ((h['note'] ?? '')
                                      .toString()
                                      .trim()
                                      .isNotEmpty)
                                    h['note'].toString(),
                                  _simpleDate(h['created_at']),
                                ].join('\n'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class AdminProfilePage extends StatelessWidget {
  final bool ar, dark;
  final String user, role, branchId;
  final VoidCallback toggleLang, toggleTheme;
  final FutureOr<void> Function() onLogout;

  const AdminProfilePage({
    super.key,
    required this.ar,
    required this.dark,
    required this.user,
    required this.role,
    required this.branchId,
    required this.toggleLang,
    required this.toggleTheme,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    final cs = Theme.of(context).colorScheme;
    final roleLabel = role == 'reviewer'
        ? t.x('مراجع طلبات', 'Reviewer')
        : t.x('مسؤول فرع', 'Branch Administrator');
    final branchLabel = branchNames[branchId]?[ar ? 0 : 1] ?? branchId;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t.x('حساب الإدارة', 'Admin Account'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xFFB3262D),
                    child: Icon(
                      Icons.admin_panel_settings_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          roleLabel,
                          style: TextStyle(
                            color: cs.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          t.x('الفرع: $branchLabel', 'Branch: $branchLabel'),
                          style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          supabase.auth.currentUser?.email ?? '',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(t.x('اللغة', 'Language')),
                  subtitle: Text(ar ? 'العربية' : 'English'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: toggleLang,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: Text(t.x('الوضع الداكن', 'Dark Mode')),
                  value: dark,
                  onChanged: (_) => toggleTheme(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => onLogout(),
            icon: const Icon(Icons.logout_rounded),
            label: Text(t.x('تسجيل الخروج', 'Sign Out')),
          ),
        ],
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  final bool ar, dark, isGuest;
  final String user;
  final VoidCallback toggleLang, toggleTheme;
  final FutureOr<void> Function() onLogout;

  const MainShell({
    super.key,
    required this.ar,
    required this.dark,
    required this.user,
    required this.isGuest,
    required this.toggleLang,
    required this.toggleTheme,
    required this.onLogout,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  int applicationsRevision = 0;

  bool _requiresAccount(int targetIndex) =>
      targetIndex == 2 || targetIndex == 3;

  void _open(int targetIndex) {
    final t = T(widget.ar);

    if (widget.isGuest && _requiresAccount(targetIndex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.x(
              'سجّل الدخول أو أنشئ حسابًا لتقديم الطلبات ومتابعتها.',
              'Sign in or create an account to apply and track applications.',
            ),
          ),
          action: SnackBarAction(
            label: t.x('دخول', 'Sign In'),
            onPressed: () => widget.onLogout(),
          ),
        ),
      );
      return;
    }

    setState(() => index = targetIndex);
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);

    final pages = [
      DashboardPage(
        ar: widget.ar,
        user: widget.user,
        openPrograms: () => _open(1),
        openApply: () => _open(2),
      ),
      ProgramsPage(ar: widget.ar),
      ApplyPage(
        ar: widget.ar,
        onSubmitted: () => setState(() => applicationsRevision++),
      ),
      ApplicationsPage(key: ValueKey(applicationsRevision), ar: widget.ar),
      ProfilePage(
        ar: widget.ar,
        dark: widget.dark,
        user: widget.user,
        isGuest: widget.isGuest,
        toggleLang: widget.toggleLang,
        toggleTheme: widget.toggleTheme,
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: _open,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: t.x('الرئيسية', 'Home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.school_outlined),
            selectedIcon: const Icon(Icons.school_rounded),
            label: t.x('البرامج', 'Programs'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.add_circle_outline),
            selectedIcon: const Icon(Icons.add_circle_rounded),
            label: t.x('تسجيل', 'Apply'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.description_outlined),
            selectedIcon: const Icon(Icons.description_rounded),
            label: t.x('طلباتي', 'My Applications'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person_rounded),
            label: t.x('حسابي', 'Profile'),
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final bool ar;
  final String user;
  final VoidCallback openPrograms, openApply;
  const DashboardPage({
    super.key,
    required this.ar,
    required this.user,
    required this.openPrograms,
    required this.openApply,
  });

  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t.x('مرحبًا، $user', 'Welcome, $user'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            t.x(
              'اكتشف تخصصك، تحقق من أهليتك، قدّم طلبك وتابع حالة القبول.',
              'Discover your program, check eligibility, apply, and track your admission.',
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFB3262D), Color(0xFF78151B)],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.campaign, color: Colors.white, size: 34),
                const SizedBox(height: 10),
                Text(
                  t.x('التسجيل مفتوح الآن', 'Admissions Are Open'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.x(
                    'اكتشف البرامج المتاحة وقدّم طلبك إلكترونيًا.',
                    'Explore available programs and apply online.',
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: openApply,
                  child: Text(t.x('سجّل الآن', 'Apply Now')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: [
              _Dash(
                icon: Icons.school,
                title: t.x('اكتشف التخصصات', 'Explore Programs'),
                onTap: openPrograms,
              ),
              _Dash(
                icon: Icons.location_city,
                title: t.x('الفروع', 'Branches'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BranchesPage(ar: ar)),
                ),
              ),
              _Dash(
                icon: Icons.auto_awesome,
                title: t.x('رشّح لي تخصصًا', 'Recommend a Program'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RecommendPage(ar: ar)),
                ),
              ),
              _Dash(
                icon: Icons.verified_user_outlined,
                title: t.x('هل أنا مؤهل؟', 'Am I Eligible?'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EligibilityPage(ar: ar)),
                ),
              ),
              _Dash(
                icon: Icons.compare_arrows,
                title: t.x('قارن تخصصين', 'Compare Programs'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ComparePage(ar: ar)),
                ),
              ),
              _Dash(
                icon: Icons.info_outline,
                title: t.x('عن الكلية', 'About the College'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutPage(ar: ar)),
                ),
              ),
              _Dash(
                icon: Icons.help_outline,
                title: t.x('الأسئلة الشائعة', 'FAQ'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FaqPage(ar: ar)),
                ),
              ),
              _Dash(
                icon: Icons.contact_support_outlined,
                title: t.x('تواصل معنا', 'Contact Us'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactPage(ar: ar)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dash extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _Dash({required this.icon, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFB3262D), size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ),
  );
}

class ProgramsPage extends StatefulWidget {
  final bool ar;
  const ProgramsPage({super.key, required this.ar});
  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  String q = '';
  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final list = programs
        .where(
          (p) =>
              p.name(widget.ar).toLowerCase().contains(q.toLowerCase()) ||
              p.family(widget.ar).toLowerCase().contains(q.toLowerCase()),
        )
        .toList();
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t.x('البرامج والتخصصات', 'Programs & Specialties'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          TextField(
            onChanged: (v) => setState(() => q = v),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: t.x(
                'ابحث عن تخصص أو عائلة مهنية...',
                'Search programs or career families...',
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...list.map(
            (p) => Card(
              child: ListTile(
                leading: Icon(p.icon, color: const Color(0xFFB3262D)),
                title: Text(
                  p.name(widget.ar),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  '${p.family(widget.ar)} • ${p.level(widget.ar)}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProgramDetailsPage(ar: widget.ar, p: p),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramDetailsPage extends StatelessWidget {
  final bool ar;
  final Program p;
  const ProgramDetailsPage({super.key, required this.ar, required this.p});
  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: Text(p.name(ar))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: const Color(
                      0xFFB3262D,
                    ).withValues(alpha: .12),
                    child: Icon(
                      p.icon,
                      size: 40,
                      color: const Color(0xFFB3262D),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p.name(ar),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _kv(t.x('العائلة المهنية', 'Career Family'), p.family(ar)),
                  _kv(t.x('المستوى', 'Level'), p.level(ar)),
                  _kv(t.x('مدة الدراسة', 'Duration'), p.duration(ar)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.x('الفروع المتاحة', 'Available Branches'),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...p.branches.map(
                    (id) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text('• ${branchNames[id]![ar ? 0 : 1]}'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                t.x(
                  'ملاحظة: شروط القبول والرسوم والمدة قد تختلف حسب الدفعة والمستوى، ويجب اعتماد أحدث إعلان رسمي عند فتح التسجيل.',
                  'Note: admission requirements, fees, and duration may vary by intake and level. Always use the latest official admissions notice.',
                ),
                style: const TextStyle(height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _kv(String k, String v) => Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: Text(k, style: const TextStyle(fontWeight: FontWeight.w900)),
      ),
      Expanded(child: Text(v)),
    ],
  ),
);

class BranchesPage extends StatelessWidget {
  final bool ar;
  const BranchesPage({super.key, required this.ar});
  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('الفروع', 'Branches')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: branchNames.entries.map((e) {
          final count = programs
              .where((p) => p.branches.contains(e.key))
              .length;
          return Card(
            child: ExpansionTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFB3262D),
                child: Icon(Icons.location_on, color: Colors.white),
              ),
              title: Text(
                e.value[ar ? 0 : 1],
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              subtitle: Text('$count ${t.x('برنامج', 'programs')}'),
              children: programs
                  .where((p) => p.branches.contains(e.key))
                  .map(
                    (p) => ListTile(
                      leading: Icon(p.icon, color: const Color(0xFFB3262D)),
                      title: Text(p.name(ar)),
                      subtitle: Text(p.level(ar)),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProgramDetailsPage(ar: ar, p: p),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ApplyPage extends StatefulWidget {
  final bool ar;
  final VoidCallback? onSubmitted;

  const ApplyPage({super.key, required this.ar, this.onSubmitted});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final nid = TextEditingController();
  final phone = TextEditingController();
  final education = TextEditingController();

  Program? p;
  String? branch;
  PlatformFile? idFile;
  PlatformFile? certificateFile;
  bool submitting = false;

  @override
  void dispose() {
    name.dispose();
    nid.dispose();
    phone.dispose();
    education.dispose();
    super.dispose();
  }

  void _message(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<PlatformFile?> _pickFile() async {
    return FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
  }

  Future<void> _submit(T t) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (p == null || branch == null) return;

    final user = supabase.auth.currentUser;
    if (user == null) {
      _message(
        t.x(
          'يجب تسجيل الدخول قبل تقديم الطلب.',
          'You must sign in before submitting an application.',
        ),
      );
      return;
    }

    setState(() => submitting = true);

    try {
      await supabase
          .from('profiles')
          .update({
            'full_name': name.text.trim(),
            'national_id': nid.text.trim(),
            'phone': phone.text.trim(),
            'education_level': education.text.trim(),
          })
          .eq('id', user.id);

      final row = await supabase
          .from('applications')
          .insert({
            'program_id': p!.id,
            'branch_id': branch!,
            'applicant_name': name.text.trim(),
            'national_id': nid.text.trim(),
            'phone': phone.text.trim(),
            'education_level': education.text.trim(),
          })
          .select('id, application_number')
          .single();

      final applicationId = row['id'] as String;
      final applicationNumber = row['application_number'] as String;

      Future<void> uploadDocument(
        PlatformFile? file,
        String documentType,
        String stem,
      ) async {
        if (file == null) return;

        final bytes = await file.readAsBytes();
        final extension = file.extension?.toLowerCase() ?? 'bin';
        final storagePath = '${user.id}/$applicationId/$stem.$extension';

        await supabase.storage
            .from('application-documents')
            .uploadBinary(
              storagePath,
              bytes,
              fileOptions: const FileOptions(upsert: false),
            );

        await supabase.from('application_documents').insert({
          'application_id': applicationId,
          'document_type': documentType,
          'storage_path': storagePath,
          'original_name': file.name,
        });
      }

      await uploadDocument(idFile, 'identity', 'identity');
      await uploadDocument(certificateFile, 'certificate', 'certificate');

      widget.onSubmitted?.call();

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          icon: const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 52,
          ),
          title: Text(
            t.x('تم تقديم طلبك بنجاح', 'Application Submitted Successfully'),
          ),
          content: Text(
            '${t.x('رقم الطلب', 'Application Number')}: '
            '$applicationNumber\n\n'
            '${t.x('تم حفظ الطلب في قاعدة البيانات ويمكن متابعته من صفحة طلباتي.', 'Your application is saved in the database and can be tracked from My Applications.')}',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(t.x('تم', 'Done')),
            ),
          ],
        ),
      );

      name.clear();
      nid.clear();
      phone.clear();
      education.clear();
      setState(() {
        p = null;
        branch = null;
        idFile = null;
        certificateFile = null;
      });
    } on PostgrestException catch (e) {
      _message(e.message);
    } on StorageException catch (e) {
      _message(e.message);
    } catch (e) {
      _message(
        t.x(
          'حدث خطأ أثناء إرسال الطلب.',
          'An error occurred while submitting the application.',
        ),
      );
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final validBranches = p == null ? <String>[] : p!.branches;
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t.x('تقديم طلب تسجيل', 'Submit Application'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            t.x(
              'أدخل بياناتك بدقة، ثم اختر التخصص والفرع المناسبين.',
              'Enter your information carefully, then choose your program and branch.',
            ),
            style: TextStyle(color: cs.onSurfaceVariant, height: 1.5),
          ),
          const SizedBox(height: 16),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: t.x('الاسم الكامل', 'Full Name'),
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                  ),
                  validator: (v) => (v ?? '').trim().length < 3
                      ? t.x('أدخل الاسم الكامل.', 'Enter your full name.')
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nid,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: t.x(
                      'الرقم الوطني / رقم الوثيقة',
                      'National ID / Document Number',
                    ),
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  validator: (v) => (v ?? '').trim().length < 5
                      ? t.x(
                          'أدخل رقم هوية أو وثيقة صحيحًا.',
                          'Enter a valid ID or document number.',
                        )
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: t.x('رقم الهاتف', 'Phone Number'),
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                  validator: (v) {
                    final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                    return digits.length < 8
                        ? t.x(
                            'أدخل رقم هاتف صحيحًا.',
                            'Enter a valid phone number.',
                          )
                        : null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: education,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: t.x('المؤهل الدراسي', 'Education Level'),
                    prefixIcon: const Icon(Icons.school_outlined),
                  ),
                  validator: (v) => (v ?? '').trim().isEmpty
                      ? t.x(
                          'أدخل المؤهل الدراسي.',
                          'Enter your education level.',
                        )
                      : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<Program>(
                  initialValue: p,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: t.x('اختر التخصص', 'Choose Program'),
                    prefixIcon: const Icon(Icons.workspace_premium_outlined),
                  ),
                  items: programs
                      .map(
                        (x) => DropdownMenuItem(
                          value: x,
                          child: Text(
                            x.name(widget.ar),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() {
                    p = v;
                    branch = null;
                  }),
                  validator: (v) => v == null
                      ? t.x('اختر التخصص.', 'Choose a program.')
                      : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: branch,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: t.x('اختر الفرع', 'Choose Branch'),
                    prefixIcon: const Icon(Icons.location_city_outlined),
                  ),
                  items: validBranches
                      .map(
                        (id) => DropdownMenuItem(
                          value: id,
                          child: Text(branchNames[id]![widget.ar ? 0 : 1]),
                        ),
                      )
                      .toList(),
                  onChanged: p == null
                      ? null
                      : (v) => setState(() => branch = v),
                  validator: (v) =>
                      v == null ? t.x('اختر الفرع.', 'Choose a branch.') : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  onTap: submitting
                      ? null
                      : () async {
                          final file = await _pickFile();
                          if (file != null && mounted) {
                            setState(() => idFile = file);
                          }
                        },
                  leading: Icon(
                    idFile == null
                        ? Icons.upload_file_rounded
                        : Icons.check_circle_rounded,
                    color: idFile == null
                        ? const Color(0xFFB3262D)
                        : Colors.green,
                  ),
                  title: Text(t.x('إرفاق الهوية', 'Attach ID')),
                  subtitle: Text(
                    idFile?.name ?? t.x('PDF / JPG / PNG', 'PDF / JPG / PNG'),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: submitting
                      ? null
                      : () async {
                          final file = await _pickFile();
                          if (file != null && mounted) {
                            setState(() => certificateFile = file);
                          }
                        },
                  leading: Icon(
                    certificateFile == null
                        ? Icons.upload_file_rounded
                        : Icons.check_circle_rounded,
                    color: certificateFile == null
                        ? const Color(0xFFB3262D)
                        : Colors.green,
                  ),
                  title: Text(t.x('إرفاق الشهادة', 'Attach Certificate')),
                  subtitle: Text(
                    certificateFile?.name ??
                        t.x('PDF / JPG / PNG', 'PDF / JPG / PNG'),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            icon: submitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_rounded),
            onPressed: submitting ? null : () => _submit(t),
            label: Text(
              submitting
                  ? t.x('جاري الإرسال...', 'Submitting...')
                  : t.x('إرسال الطلب', 'Submit Application'),
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationsPage extends StatefulWidget {
  final bool ar;

  const ApplicationsPage({super.key, required this.ar});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  bool loading = true;
  String? error;
  List<Map<String, dynamic>> applications = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final rows = await supabase
          .from('applications')
          .select(
            'id, application_number, applicant_name, program_id, branch_id, status, created_at',
          )
          .order('created_at', ascending: false);

      applications = List<Map<String, dynamic>>.from(rows);
    } on PostgrestException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  String _status(bool ar, String? code) {
    switch (code) {
      case 'under_review':
        return ar ? 'قيد المراجعة' : 'Under Review';
      case 'document_review':
        return ar ? 'تدقيق الوثائق' : 'Document Review';
      case 'interview':
        return ar ? 'المقابلة' : 'Interview';
      case 'decision':
        return ar ? 'قرار القبول' : 'Admission Decision';
      case 'accepted':
        return ar ? 'مقبول' : 'Accepted';
      case 'rejected':
        return ar ? 'مرفوض' : 'Rejected';
      case 'completed':
        return ar ? 'تم استكمال التسجيل' : 'Registration Completed';
      default:
        return ar ? 'تم الاستلام' : 'Received';
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.x('طلباتي', 'My Applications'),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: t.x('تحديث', 'Refresh'),
                  onPressed: _load,
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              t.x(
                'تابع حالة طلباتك ومراحل معالجتها.',
                'Track your applications and their processing stages.',
              ),
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            if (loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(error!),
                ),
              )
            else if (applications.isEmpty)
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 48,
                        color: cs.onSurfaceVariant,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.x('لا توجد طلبات بعد', 'No applications yet'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...applications.map((a) {
                final program = programs.firstWhere(
                  (p) => p.id == a['program_id'],
                  orElse: () => programs.first,
                );
                final branchId = a['branch_id'] as String?;
                final branchName =
                    branchNames[branchId]?[widget.ar ? 0 : 1] ??
                    (branchId ?? '-');

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const CircleAvatar(
                        backgroundColor: Color(0x1AB3262D),
                        child: Icon(
                          Icons.description_outlined,
                          color: Color(0xFFB3262D),
                        ),
                      ),
                      title: Text(
                        program.name(widget.ar),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      subtitle: Text('$branchName\n${a['application_number']}'),
                      isThreeLine: true,
                      trailing: Chip(
                        label: Text(_status(widget.ar, a['status'] as String?)),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrackingPage(ar: widget.ar, a: a),
                        ),
                      ).then((_) => _load()),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class TrackingPage extends StatefulWidget {
  final bool ar;
  final Map<String, dynamic> a;

  const TrackingPage({super.key, required this.ar, required this.a});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  late Map<String, dynamic> application;
  List<Map<String, dynamic>> history = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    application = Map<String, dynamic>.from(widget.a);
    _load();
  }

  int _statusIndex(String? status) {
    switch (status) {
      case 'under_review':
        return 1;
      case 'document_review':
        return 2;
      case 'interview':
        return 3;
      case 'decision':
      case 'accepted':
      case 'rejected':
        return 4;
      case 'completed':
        return 5;
      default:
        return 0;
    }
  }

  Future<void> _load() async {
    try {
      final updated = await supabase
          .from('applications')
          .select()
          .eq('id', application['id'])
          .single();

      final rows = await supabase
          .from('application_status_history')
          .select('status, note, created_at')
          .eq('application_id', application['id'])
          .order('created_at');

      if (mounted) {
        setState(() {
          application = Map<String, dynamic>.from(updated);
          history = List<Map<String, dynamic>>.from(rows);
          loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    final steps = [
      t.x('تم الاستلام', 'Received'),
      t.x('قيد المراجعة', 'Under Review'),
      t.x('تدقيق الوثائق', 'Document Review'),
      t.x('المقابلة', 'Interview'),
      t.x('قرار القبول', 'Admission Decision'),
      t.x('تم استكمال التسجيل', 'Registration Completed'),
    ];

    final current = _statusIndex(application['status'] as String?);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('متابعة الطلب', 'Track Application')),
        actions: [
          IconButton(onPressed: _load, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _kv(
                          t.x('رقم الطلب', 'Application Number'),
                          application['application_number']?.toString() ?? '-',
                        ),
                        _kv(
                          t.x('الحالة الحالية', 'Current Status'),
                          application['status']?.toString() ?? 'received',
                        ),
                        _kv(
                          t.x('اسم المتقدم', 'Applicant'),
                          application['applicant_name']?.toString() ?? '-',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                ...List.generate(
                  steps.length,
                  (i) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: i <= current
                                ? Colors.green
                                : Colors.grey.shade500,
                            child: Icon(
                              i < current
                                  ? Icons.check_rounded
                                  : i == current
                                  ? Icons.timelapse_rounded
                                  : Icons.circle_outlined,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                          if (i < steps.length - 1)
                            Container(
                              width: 2,
                              height: 48,
                              color: i < current
                                  ? Colors.green
                                  : Theme.of(context).dividerColor,
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            steps[i],
                            style: TextStyle(
                              fontWeight: i == current
                                  ? FontWeight.w900
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (history.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    t.x('سجل الحالة', 'Status History'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...history.map(
                    (h) => Card(
                      child: ListTile(
                        title: Text(h['status']?.toString() ?? ''),
                        subtitle: h['note'] == null
                            ? null
                            : Text(h['note'].toString()),
                        trailing: Text(
                          h['created_at']?.toString().split('T').first ?? '',
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

class RecommendPage extends StatefulWidget {
  final bool ar;
  const RecommendPage({super.key, required this.ar});
  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  int tech = 0, hands = 0, people = 0, machines = 0;
  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('ساعدني أختار تخصصًا', 'Program Match')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _slider(
            t.x(
              'أحب التكنولوجيا والكمبيوتر',
              'I enjoy technology and computers',
            ),
            tech,
            (v) => setState(() => tech = v),
          ),
          _slider(
            t.x(
              'أفضل العمل اليدوي والتطبيقي',
              'I prefer hands-on practical work',
            ),
            hands,
            (v) => setState(() => hands = v),
          ),
          _slider(
            t.x('أحب التعامل مع الناس', 'I enjoy working with people'),
            people,
            (v) => setState(() => people = v),
          ),
          _slider(
            t.x('أحب المركبات والآلات', 'I enjoy vehicles and machines'),
            machines,
            (v) => setState(() => machines = v),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {
              List<Program> r;
              if (tech >= hands && tech >= people && tech >= machines) {
                r = [
                  programs.firstWhere((p) => p.id == 'apps'),
                  programs.firstWhere((p) => p.id == 'data'),
                  programs.firstWhere((p) => p.id == 'mobile'),
                ];
              } else if (machines >= hands) {
                r = [
                  programs.firstWhere((p) => p.id == 'mechanic'),
                  programs.firstWhere((p) => p.id == 'velectric'),
                  programs.firstWhere((p) => p.id == 'cnc'),
                ];
              } else if (people >= hands) {
                r = [
                  programs.firstWhere((p) => p.id == 'beauty'),
                  programs.firstWhere((p) => p.id == 'admin'),
                  programs.firstWhere((p) => p.id == 'health'),
                ];
              } else {
                r = [
                  programs.firstWhere((p) => p.id == 'electricity'),
                  programs.firstWhere((p) => p.id == 'welding'),
                  programs.firstWhere((p) => p.id == 'carpentry'),
                ];
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecommendResultPage(ar: widget.ar, result: r),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(t.x('اعرض اقتراحاتي', 'Show Recommendations')),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _slider(String title, int value, ValueChanged<int> onChanged) => Card(
  child: Padding(
    padding: const EdgeInsets.all(14),
    child: Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        Slider(
          min: 0,
          max: 5,
          divisions: 5,
          value: value.toDouble(),
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    ),
  ),
);

class RecommendResultPage extends StatelessWidget {
  final bool ar;
  final List<Program> result;
  const RecommendResultPage({
    super.key,
    required this.ar,
    required this.result,
  });
  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('نتيجة الترشيح', 'Recommendation Result')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t.x(
              'تخصصات مناسبة حسب إجاباتك',
              'Programs Matched to Your Answers',
            ),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            result.length,
            (i) => Card(
              child: ListTile(
                leading: Icon(result[i].icon, color: const Color(0xFFB3262D)),
                title: Text(
                  result[i].name(ar),
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  '${t.x('نسبة التوافق', 'Match')}: ${92 - i * 6}%',
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProgramDetailsPage(ar: ar, p: result[i]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EligibilityPage extends StatefulWidget {
  final bool ar;
  const EligibilityPage({super.key, required this.ar});
  @override
  State<EligibilityPage> createState() => _EligibilityPageState();
}

class _EligibilityPageState extends State<EligibilityPage> {
  final age = TextEditingController(), edu = TextEditingController();
  Program? p;
  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('هل أنا مؤهل؟', 'Am I Eligible?')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: t.x('العمر', 'Age')),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: edu,
            decoration: InputDecoration(
              labelText: t.x('المؤهل الدراسي', 'Education Level'),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<Program>(
            initialValue: p,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: t.x('اختر التخصص', 'Choose Program'),
            ),
            items: programs
                .map(
                  (x) => DropdownMenuItem(
                    value: x,
                    child: Text(x.name(widget.ar)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => p = v),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: () {
              final ok =
                  (int.tryParse(age.text) ?? 0) >= 16 &&
                  edu.text.trim().isNotEmpty &&
                  p != null;
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  icon: Icon(
                    ok ? Icons.check_circle : Icons.warning_amber,
                    color: ok ? Colors.green : Colors.orange,
                    size: 48,
                  ),
                  title: Text(
                    ok
                        ? t.x('مؤهل مبدئيًا', 'Preliminarily Eligible')
                        : t.x('تحقق من الشروط', 'Check Requirements'),
                  ),
                  content: Text(
                    ok
                        ? t.x(
                            'يبدو أنك مؤهل مبدئيًا. القرار النهائي يخضع للشروط الرسمية وتدقيق الكلية.',
                            'You appear preliminarily eligible. Final admission is subject to official requirements and college verification.',
                          )
                        : t.x(
                            'أكمل البيانات أو راجع شروط البرنامج.',
                            'Complete the information or review program requirements.',
                          ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(t.x('تحقق', 'Check')),
            ),
          ),
        ],
      ),
    );
  }
}

class ComparePage extends StatefulWidget {
  final bool ar;
  const ComparePage({super.key, required this.ar});
  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Program? a, b;
  @override
  Widget build(BuildContext context) {
    final t = T(widget.ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('قارن تخصصين', 'Compare Programs')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<Program>(
            initialValue: a,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: t.x('التخصص الأول', 'First Program'),
            ),
            items: programs
                .map(
                  (x) => DropdownMenuItem(
                    value: x,
                    child: Text(x.name(widget.ar)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => a = v),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<Program>(
            initialValue: b,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: t.x('التخصص الثاني', 'Second Program'),
            ),
            items: programs
                .map(
                  (x) => DropdownMenuItem(
                    value: x,
                    child: Text(x.name(widget.ar)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => b = v),
          ),
          const SizedBox(height: 14),
          if (a != null && b != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _kv(
                      t.x('المستوى', 'Level'),
                      '${a!.level(widget.ar)}  |  ${b!.level(widget.ar)}',
                    ),
                    _kv(
                      t.x('المدة', 'Duration'),
                      '${a!.duration(widget.ar)}  |  ${b!.duration(widget.ar)}',
                    ),
                    _kv(
                      t.x('عدد الفروع', 'Branches'),
                      '${a!.branches.length}  |  ${b!.branches.length}',
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final bool ar;
  const AboutPage({super.key, required this.ar});
  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('عن الكلية', 'About the College')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(
            t.x('من هي الكلية؟', 'About CAVT'),
            t.x(
              'تأسست كلية التدريب المهني المتقدم في الأردن عام 2022 بهدف تطوير التعليم والتدريب المهني والتقني وربطه باحتياجات سوق العمل من خلال برامج تطبيقية وشراكات مع القطاعين العام والخاص.',
              'CAVT was established in Jordan in 2022 to advance vocational and technical education and align practical training with labor-market needs.',
            ),
          ),
          _section(
            t.x('فائدة الكلية', 'Why CAVT Matters'),
            t.x(
              'تركز على المهارات المهنية القابلة للتطبيق مباشرة، التدريب العملي، دعم التشغيل والعمل الحر وريادة الأعمال، وتوسيع فرص التدريب للشباب والنساء.',
              'It focuses on job-ready practical skills, hands-on training, employment, self-employment, entrepreneurship, and broader access to training.',
            ),
          ),
          _section(
            t.x('الرؤية', 'Vision'),
            t.x(
              'تعزيز مكانة التعليم والتدريب المهني والتقني كمسار أساسي للتنمية الاقتصادية والاجتماعية.',
              'Strengthen vocational and technical education as a core path for economic and social development.',
            ),
          ),
          _section(
            t.x('الرسالة', 'Mission'),
            t.x(
              'تطوير شباب ماهرين ومؤهلين وتمكينهم من بناء مستقبل مهني مستدام والمساهمة في الاقتصاد الوطني.',
              'Develop skilled and empowered youth who can build sustainable careers and contribute to the economy.',
            ),
          ),
          _section(
            t.x('القيم', 'Values'),
            t.x(
              'التميز • الابتكار • التمكين • التعاون • الشمول وتكافؤ الفرص',
              'Excellence • Innovation • Empowerment • Collaboration • Inclusion & Equal Opportunity',
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                t.x(
                  'تم تصميمه وبرمجته من قبل الطالبة ميسم خليل مصح من كلية التدريب المهني المتقدم - حكما',
                  'Designed and developed by student Maysam Khalil Musah from the College of Advanced Vocational Training - Hakama',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _section(String title, String body) => Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Text(body, style: const TextStyle(height: 1.7)),
      ],
    ),
  ),
);

class FaqPage extends StatelessWidget {
  final bool ar;
  const FaqPage({super.key, required this.ar});
  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    final data = [
      [
        t.x('كيف أسجل؟', 'How do I apply?'),
        t.x(
          'أدخل بياناتك، اختر التخصص والفرع، أرفق الوثائق ثم أرسل الطلب.',
          'Enter your information, choose a program and branch, attach documents, and submit.',
        ),
      ],
      [
        t.x('كيف أتابع طلبي؟', 'How do I track my application?'),
        t.x(
          'من صفحة طلباتي ستجد رقم الطلب والحالة الحالية وخط المتابعة.',
          'Use My Applications to see the application number, current status, and timeline.',
        ),
      ],
      [
        t.x(
          'هل يمكن اختيار أي فرع لأي تخصص؟',
          'Can I choose any branch for any program?',
        ),
        t.x(
          'لا، التطبيق يعرض فقط الفروع التي توفر التخصص المختار.',
          'No. The app only shows branches that offer the selected program.',
        ),
      ],
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('الأسئلة الشائعة', 'FAQ')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: data
            .map(
              (x) => Card(
                child: ExpansionTile(
                  title: Text(
                    x[0],
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(x[1], style: const TextStyle(height: 1.6)),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final bool ar;
  const ContactPage({super.key, required this.ar});
  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(t.x('تواصل معنا', 'Contact Us')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.language, color: Color(0xFFB3262D)),
              title: Text(t.x('الموقع الإلكتروني', 'Website')),
              subtitle: const Text('www.cavt.jo'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.location_city,
                color: Color(0xFFB3262D),
              ),
              title: Text(t.x('الفروع', 'Branches')),
              subtitle: Text(
                branchNames.values.map((x) => x[ar ? 0 : 1]).join(' • '),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                t.x(
                  'يتم اعتماد أرقام التواصل وساعات الدوام من المصادر الرسمية عند ربط التطبيق بقاعدة البيانات.',
                  'Phone numbers and working hours should be loaded from official sources when the app is connected to the database.',
                ),
                style: const TextStyle(height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final bool ar, dark, isGuest;
  final String user;
  final VoidCallback toggleLang, toggleTheme;
  final FutureOr<void> Function() onLogout;

  const ProfilePage({
    super.key,
    required this.ar,
    required this.dark,
    required this.user,
    required this.isGuest,
    required this.toggleLang,
    required this.toggleTheme,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final t = T(ar);
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t.x('حسابي', 'Profile'),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xFFB3262D),
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGuest
                              ? t.x(
                                  'وضع الزائر - استكشاف فقط',
                                  'Guest mode - browse only',
                                )
                              : supabase.auth.currentUser?.email ??
                                    t.x(
                                      'حساب متقدم للقبول والتسجيل',
                                      'Admissions applicant account',
                                    ),
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(t.x('اللغة', 'Language')),
                  subtitle: Text(ar ? 'العربية' : 'English'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: toggleLang,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: Text(t.x('الوضع الداكن', 'Dark Mode')),
                  value: dark,
                  onChanged: (_) => toggleTheme(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => onLogout(),
            icon: const Icon(Icons.logout_rounded),
            label: Text(
              isGuest
                  ? t.x('العودة لتسجيل الدخول', 'Go to Sign In')
                  : t.x('تسجيل الخروج', 'Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
