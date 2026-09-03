import 'package:flutter/material.dart';
import '../app_data.dart';
import '../main.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});
  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = subjects
        .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
      padding: const EdgeInsets.only(bottom: 28),
      children: [
        const AppPageTitle('المواد'),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBox(
                hint: 'ابحث عن مادة',
                onChanged: (v) => setState(() => query = v))),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            for (final subject in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 0,
                  color: surface,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    leading: SoftIcon(icon: subject.icon, color: subject.color),
                    title: Text(subject.name,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text(subject.count),
                    trailing: const Icon(Icons.chevron_left_rounded,
                        color: secondaryText),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                SubjectDetailsPage(subject: subject))),
                  ),
                ),
              ),
          ]),
        ),
      ],
    );
  }
}

class SubjectDetailsPage extends StatelessWidget {
  final SubjectItem subject;
  const SubjectDetailsPage({super.key, required this.subject});
  @override
  Widget build(BuildContext context) {
    final items = [
      ('المحاضرات', '8 ملفات', Icons.menu_book_outlined),
      ('الملازم', '5 ملفات', Icons.article_outlined),
      ('Sheets', '4 ملفات', Icons.assignment_outlined),
      ('الامتحانات', '6 ملفات', Icons.description_outlined),
      ('الحلول', '5 ملفات', Icons.check_circle_outline)
    ];
    return DetailPage(
      title: subject.name,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => Card(
          elevation: 0,
          color: surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              leading: SoftIcon(icon: items[i].$3, color: subject.color),
              title: Text(items[i].$1,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(items[i].$2),
              trailing:
                  const Icon(Icons.chevron_left_rounded, color: secondaryText),
              onTap: () {}),
        ),
      ),
    );
  }
}
