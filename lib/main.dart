import 'package:flutter/material.dart';

void main() {
  runApp(const CollegeHubApp());
}

const primary = Color(0xFF10B981);
const primaryDark = Color(0xFF0F172A);
const secondaryText = Color(0xFF64748B);
const background = Color(0xFFF8FAFC);
const surface = Colors.white;

class CollegeHubApp extends StatelessWidget {
  const CollegeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Hub',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        fontFamily: 'sans',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: primaryDark),
          titleLarge: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: primaryDark),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: primaryDark),
          bodyLarge: TextStyle(fontSize: 15, color: primaryDark),
          bodyMedium: TextStyle(fontSize: 13, color: secondaryText),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [HomePage(), SubjectsPage(), ExamsPage(), MorePage()];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(begin: const Offset(0.02, 0), end: Offset.zero).animate(animation),
                child: child,
              ),
            ),
            child: KeyedSubtree(key: ValueKey(index), child: pages[index]),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          height: 70,
          backgroundColor: surface,
          indicatorColor: primary.withOpacity(.12),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'المواد'),
            NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description), label: 'الامتحانات'),
            NavigationDestination(icon: Icon(Icons.more_horiz), selectedIcon: Icon(Icons.more_horiz), label: 'المزيد'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('أهلاً، Engineer', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 4),
                      const Text('جاهز ليوم جديد من المذاكرة؟', style: TextStyle(color: secondaryText)),
                    ],
                  ),
                ),
                _IconButton(icon: Icons.notifications_none_rounded, badge: true),
              ],
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 26)),
        SliverToBoxAdapter(child: SectionHeader(title: 'آخر الأخبار')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NewsCard(
              title: 'تم تأجيل محاضرة Database',
              subtitle: 'إلى يوم الثلاثاء 10 سبتمبر',
              time: 'منذ ساعتين',
              icon: Icons.campaign_outlined,
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 22)),
        SliverToBoxAdapter(child: SectionHeader(title: 'المهام القادمة')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TaskCard(
              title: 'Database Assignment 2',
              subtitle: 'التسليم 10 سبتمبر • 11:59 PM',
              remaining: 'متبقي 7 أيام',
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 22)),
        SliverToBoxAdapter(child: SectionHeader(title: 'آخر الملفات')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.list(children: const [
            FileRow(title: 'Lecture 4 - Normalization', subject: 'Database'),
            SizedBox(height: 10),
            FileRow(title: 'Sheet 3', subject: 'Programming'),
            SizedBox(height: 24),
          ]),
        ),
      ],
    );
  }
}

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = const [
      Subject('Database', '18 ملف', Icons.storage_rounded, Color(0xFF10B981)),
      Subject('Programming', '24 ملف', Icons.code_rounded, Color(0xFF3B82F6)),
      Subject('Mathematics', '16 ملف', Icons.functions_rounded, Color(0xFF8B5CF6)),
      Subject('Networks', '14 ملف', Icons.hub_outlined, Color(0xFFF59E0B)),
      Subject('Operating Systems', '12 ملف', Icons.desktop_windows_outlined, Color(0xFF06B6D4)),
    ];

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
          sliver: SliverToBoxAdapter(
            child: Text('المواد', style: Theme.of(context).textTheme.headlineSmall),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(child: SearchBox(hint: 'ابحث عن مادة')),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.separated(
            itemCount: subjects.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => SubjectCard(subject: subjects[i]),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}

class SubjectPage extends StatelessWidget {
  final Subject subject;
  const SubjectPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('المحاضرات', '8 ملفات', Icons.menu_book_outlined, Color(0xFF10B981)),
      ('الملازم', '5 ملفات', Icons.article_outlined, Color(0xFF3B82F6)),
      ('Sheets', '4 ملفات', Icons.assignment_outlined, Color(0xFFF59E0B)),
      ('الامتحانات', '6 ملفات', Icons.description_outlined, Color(0xFF8B5CF6)),
      ('الحلول', '5 ملفات', Icons.check_circle_outline, Color(0xFF06B6D4)),
    ];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(subject.name, style: const TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final s = sections[i];
          return Card(
            elevation: 0,
            color: surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              leading: SoftIcon(icon: s.$3, color: s.$4),
              title: Text(s.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(s.$2),
              trailing: const Icon(Icons.chevron_left_rounded, color: secondaryText),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
          sliver: SliverToBoxAdapter(child: Text('الامتحانات', style: Theme.of(context).textTheme.headlineSmall)),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(child: SearchBox(hint: 'ابحث عن امتحان')),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 14)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              spacing: 8,
              children: const [FilterChip(label: Text('الكل'), selected: true, onSelected: _noop), FilterChip(label: Text('Database'), onSelected: _noop), FilterChip(label: Text('Programming'), onSelected: _noop)],
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 18)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.list(children: const [
            YearHeader(year: '2026'),
            SizedBox(height: 10),
            YearHeader(year: '2025', expanded: true),
            SizedBox(height: 8),
            ExamRow(title: 'Database Final 2025'),
            ExamRow(title: 'Database Midterm 2025'),
            ExamRow(title: 'Programming Final 2025'),
            ExamRow(title: 'Programming Midterm 2025'),
            SizedBox(height: 10),
            YearHeader(year: '2024'),
            SizedBox(height: 10),
            YearHeader(year: '2023'),
            SizedBox(height: 20),
          ]),
        ),
      ],
    );
  }
}

void _noop(bool _) {}

class ExamDetailsPage extends StatelessWidget {
  final String title;
  const ExamDetailsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(34),
            decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(22)),
            child: Column(children: const [
              Icon(Icons.picture_as_pdf_rounded, size: 72, color: Color(0xFFEF4444)),
              SizedBox(height: 14),
              Text('Database Final 2025', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text('2025', style: TextStyle(color: secondaryText)),
            ]),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.visibility_outlined), label: const Text('عرض الامتحان'), style: FilledButton.styleFrom(backgroundColor: primary, minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
          const SizedBox(height: 10),
          OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.check_circle_outline), label: const Text('عرض الحل'), style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52), side: const BorderSide(color: primary), foregroundColor: primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
          const SizedBox(height: 22),
          const Text('معلومات', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(height: 12),
          const InfoLine(label: 'المادة', value: 'Database', icon: Icons.layers_outlined),
          const InfoLine(label: 'السنة', value: '2025', icon: Icons.calendar_today_outlined),
          const InfoLine(label: 'النوع', value: 'Final Exam', icon: Icons.label_outline),
          const InfoLine(label: 'تاريخ الإضافة', value: 'منذ 3 أيام', icon: Icons.access_time_rounded),
        ],
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('جدول المحاضرات', Icons.calendar_month_outlined),
      ('المهام', Icons.assignment_turned_in_outlined),
      ('الإشعارات', Icons.notifications_none_rounded),
      ('المفضلة', Icons.star_border_rounded),
      ('التحميلات', Icons.download_outlined),
      ('عن التطبيق', Icons.info_outline),
      ('تواصل معنا', Icons.chat_bubble_outline),
      ('الإعدادات', Icons.settings_outlined),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: [
        Text('المزيد', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Column(children: [
            for (int i = 0; i < items.length; i++) ...[
              ListTile(
                leading: Icon(items[i].$2, color: i == 0 ? primary : secondaryText),
                title: Text(items[i].$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.chevron_left_rounded, color: secondaryText),
                onTap: () {},
              ),
              if (i != items.length - 1) const Divider(height: 1, indent: 62),
            ]
          ]),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
    child: Row(children: [
      Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
      Text('عرض الكل', style: TextStyle(color: primary, fontWeight: FontWeight.w700, fontSize: 13)),
    ]),
  );
}

class NewsCard extends StatelessWidget {
  final String title, subtitle, time;
  final IconData icon;
  const NewsCard({super.key, required this.title, required this.subtitle, required this.time, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFFF0FDF9), borderRadius: BorderRadius.circular(18)),
    child: Row(children: [
      SoftIcon(icon: icon, color: primary),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text(subtitle, style: const TextStyle(color: secondaryText)),
        const SizedBox(height: 5),
        Text(time, style: const TextStyle(fontSize: 11, color: secondaryText)),
      ])),
    ]),
  );
}

class TaskCard extends StatelessWidget {
  final String title, subtitle, remaining;
  const TaskCard({super.key, required this.title, required this.subtitle, required this.remaining});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(18)),
    child: Row(children: [
      const SoftIcon(icon: Icons.assignment_outlined, color: Color(0xFFF59E0B)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text(subtitle, style: const TextStyle(color: secondaryText)),
      ])),
      Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFFFF3CD), borderRadius: BorderRadius.circular(10)), child: Text(remaining, style: const TextStyle(color: Color(0xFFB45309), fontSize: 11, fontWeight: FontWeight.w700))),
    ]),
  );
}

class FileRow extends StatelessWidget {
  final String title, subject;
  const FileRow({super.key, required this.title, required this.subject});
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color: surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      leading: const SoftIcon(icon: Icons.picture_as_pdf_outlined, color: Color(0xFFEF4444)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      subtitle: Text(subject),
      trailing: const Icon(Icons.download_outlined, color: primary),
      onTap: () {},
    ),
  );
}

class SearchBox extends StatelessWidget {
  final String hint;
  const SearchBox({super.key, required this.hint});
  @override
  Widget build(BuildContext context) => TextField(
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(Icons.search_rounded, color: secondaryText),
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );
}

class SoftIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const SoftIcon({super.key, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    width: 44, height: 44,
    decoration: BoxDecoration(color: color.withOpacity(.11), borderRadius: BorderRadius.circular(12)),
    child: Icon(icon, color: color, size: 23),
  );
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;
  const _IconButton({required this.icon, this.badge = false});
  @override
  Widget build(BuildContext context) => Stack(children: [
    IconButton(onPressed: () {}, icon: Icon(icon, color: primaryDark)),
    if (badge) Positioned(right: 10, top: 8, child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: primary, shape: BoxShape.circle))),
  ]);
}

class Subject {
  final String name, count;
  final IconData icon;
  final Color color;
  const Subject(this.name, this.count, this.icon, this.color);
}

class SubjectCard extends StatelessWidget {
  final Subject subject;
  const SubjectCard({super.key, required this.subject});
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    color: surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SubjectPage(subject: subject))),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          SoftIcon(icon: subject.icon, color: subject.color),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(subject.name, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text(subject.count)])),
          const Icon(Icons.chevron_left_rounded, color: secondaryText),
        ]),
      ),
    ),
  );
}

class YearHeader extends StatelessWidget {
  final String year;
  final bool expanded;
  const YearHeader({super.key, required this.year, this.expanded = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(15)),
    child: Row(children: [Expanded(child: Text(year, style: const TextStyle(fontWeight: FontWeight.w800))), Icon(expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: secondaryText)]),
  );
}

class ExamRow extends StatelessWidget {
  final String title;
  const ExamRow({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 7),
    elevation: 0,
    color: surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    child: ListTile(
      dense: true,
      leading: const Icon(Icons.picture_as_pdf_outlined, color: Color(0xFFEF4444)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      trailing: const Icon(Icons.download_outlined, color: primary, size: 20),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExamDetailsPage(title: title))),
    ),
  );
}

class InfoLine extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const InfoLine({super.key, required this.label, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(children: [Icon(icon, color: secondaryText, size: 20), const SizedBox(width: 12), Text(label, style: const TextStyle(color: secondaryText)), const Spacer(), Text(value, style: const TextStyle(fontWeight: FontWeight.w700))]),
  );
}
