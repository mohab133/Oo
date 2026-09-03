import 'package:flutter/material.dart';
import 'screens/exams_page.dart';
import 'screens/home_page.dart';
import 'screens/schedule_page.dart';
import 'screens/subjects_page.dart';

const primary = Color(0xFF10B981);
const primaryDark = Color(0xFF0F172A);
const secondaryText = Color(0xFF64748B);
const background = Color(0xFFF8FAFC);
const surface = Colors.white;

void main() => runApp(const CollegeHubApp());

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
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF1F5F9),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800, color: primaryDark),
          titleLarge: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w800, color: primaryDark),
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
  final pages = const [HomePage(), SubjectsPage(), ExamsPage(), SchedulePage()];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child:
                    KeyedSubtree(key: ValueKey(index), child: pages[index]))),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          backgroundColor: surface,
          indicatorColor: primary.withValues(alpha: .12),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'الرئيسية'),
            NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'المواد'),
            NavigationDestination(
                icon: Icon(Icons.description_outlined),
                selectedIcon: Icon(Icons.description),
                label: 'الامتحانات'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'الجدول'),
          ],
        ),
      ),
    );
  }
}

void showNotifications(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => const Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 18, 20, 12),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: Icon(Icons.description_outlined, color: primary),
                title: Text('تم إضافة ملف جديد'),
                subtitle: Text('Sheet 2 - Loops')),
            ListTile(
                leading: Icon(Icons.campaign_outlined, color: primary),
                title: Text('تم إضافة خبر'),
                subtitle: Text('تعديل موعد محاضرة Database')),
            ListTile(
                leading: Icon(Icons.event_outlined, color: primary),
                title: Text('تمت إضافة امتحان'),
                subtitle: Text('رياضة - Midterm')),
          ]),
        ),
      ),
    ),
  );
}

class AppPageTitle extends StatelessWidget {
  final String title;
  const AppPageTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall));
}

class InfoPill extends StatelessWidget {
  final String text;
  const InfoPill(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
          color: primary.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(9)),
      child: Text(text,
          style: const TextStyle(
              color: primary, fontSize: 11, fontWeight: FontWeight.w700)));
}

class SoftIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const SoftIcon({super.key, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: color.withValues(alpha: .11),
          borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: color, size: 20));
}

class SearchBox extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  const SearchBox(
      {super.key, required this.hint, this.onChanged, this.onSubmitted});
  @override
  Widget build(BuildContext context) => TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search_rounded, color: secondaryText),
          contentPadding: const EdgeInsets.symmetric(vertical: 15)));
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge));
}

class CarouselSection<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item) builder;
  const CarouselSection(
      {super.key,
      required this.title,
      required this.items,
      required this.builder});
  @override
  State<CarouselSection<T>> createState() => _CarouselSectionState<T>();
}

class _CarouselSectionState<T> extends State<CarouselSection<T>> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle(widget.title),
      SizedBox(
        height: 150,
        child: PageView.builder(
          controller: PageController(
              viewportFraction: widget.items.length > 1 ? .88 : 1),
          itemCount: widget.items.length,
          onPageChanged: (value) => setState(() => page = value),
          itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: widget.builder(widget.items[i])),
        ),
      ),
      if (widget.items.length > 1)
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.items.length,
                (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == page ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                          color: i == page ? primary : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(9)),
                    )),
          ),
        ),
    ]);
  }
}

class SimpleCard extends StatelessWidget {
  final Widget child;
  const SimpleCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Card(
      elevation: 0,
      color: surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(padding: const EdgeInsets.all(14), child: child));
}

class DetailPage extends StatelessWidget {
  final String title;
  final Widget child;
  const DetailPage({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
      body: child);
}
