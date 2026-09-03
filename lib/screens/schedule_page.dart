import 'package:flutter/material.dart';
import '../app_data.dart';
import '../main.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedSection = 'Section 3';
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.only(bottom: 28), children: [
      const AppPageTitle('الجدول'),
      const SectionTitle('المحاضرات'),
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _ScheduleTile(
              time: '09:00 ص',
              title: 'Database',
              teacher: 'د. أحمد',
              room: 'Room 201')),
      const SizedBox(height: 22),
      const SectionTitle('السكشن بتاعي'),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Row(children: [
              Text(selectedSection,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              const Spacer(),
              TextButton.icon(
                  onPressed: _changeSection,
                  icon: const Icon(Icons.swap_horiz_rounded),
                  label: const Text('تغيير'))
            ]),
            const SizedBox(height: 6),
            const _ScheduleTile(
                time: '01:00 م',
                title: 'Programming',
                teacher: 'م. محمد',
                room: 'Lab 2'),
            const SizedBox(height: 9),
            const _ScheduleTile(
                time: '03:00 م',
                title: 'رياضة',
                teacher: 'م. أحمد',
                room: 'Room 204'),
          ])),
      const SizedBox(height: 22),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ExploreSectionsPage())),
              borderRadius: BorderRadius.circular(18),
              child: const SimpleCard(
                  child: Row(children: [
                SoftIcon(icon: Icons.explore_outlined, color: primary),
                SizedBox(width: 14),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('استكشف السكاشن',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      SizedBox(height: 5),
                      Text('اعرف مواعيد كل السكاشن لمادة معينة',
                          style: TextStyle(color: secondaryText))
                    ])),
                Icon(Icons.chevron_left_rounded, color: secondaryText)
              ])))),
    ]);
  }

  void _changeSection() => showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ['Section 1', 'Section 2', 'Section 3', 'Section 4']
                      .map((s) => ListTile(
                          title: Text(s),
                          trailing: s == selectedSection
                              ? const Icon(Icons.check, color: primary)
                              : null,
                          onTap: () {
                            setState(() => selectedSection = s);
                            Navigator.pop(context);
                          }))
                      .toList()))));
}

class _ScheduleTile extends StatelessWidget {
  final String time, title, teacher, room;
  const _ScheduleTile(
      {required this.time,
      required this.title,
      required this.teacher,
      required this.room});
  @override
  Widget build(BuildContext context) => SimpleCard(
          child: Row(children: [
        SizedBox(
            width: 70,
            child: Text(time,
                style: const TextStyle(
                    color: primary, fontWeight: FontWeight.w800))),
        Container(
            width: 3,
            height: 52,
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text('$teacher • $room', style: const TextStyle(color: secondaryText))
        ]))
      ]));
}

class ExploreSectionsPage extends StatefulWidget {
  const ExploreSectionsPage({super.key});
  @override
  State<ExploreSectionsPage> createState() => _ExploreSectionsPageState();
}

class _ExploreSectionsPageState extends State<ExploreSectionsPage> {
  String subject = 'رياضة';
  String day = 'كل الأيام';
  @override
  Widget build(BuildContext context) {
    final filtered = sections
        .where(
            (s) => s.subject == subject && (day == 'كل الأيام' || s.day == day))
        .toList();
    return DetailPage(
        title: 'استكشف السكاشن',
        child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
            children: [
              const Text('المادة',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 7),
              _Dropdown(
                  value: subject,
                  values: const ['رياضة', 'Programming', 'Database'],
                  onChanged: (v) => setState(() => subject = v)),
              const SizedBox(height: 18),
              const Text('اليوم',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 7),
              _Dropdown(
                  value: day,
                  values: const [
                    'كل الأيام',
                    'السبت',
                    'الأحد',
                    'الاثنين',
                    'الثلاثاء',
                    'الأربعاء',
                    'الخميس'
                  ],
                  onChanged: (v) => setState(() => day = v)),
              const SizedBox(height: 22),
              for (final item in filtered)
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SimpleCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Row(children: [
                            Text(item.time,
                                style: const TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w800)),
                            const Spacer(),
                            InfoPill(item.day)
                          ]),
                          const SizedBox(height: 9),
                          Text(item.section,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(height: 5),
                          Text('${item.teacher} • ${item.room}',
                              style: const TextStyle(color: secondaryText))
                        ]))),
            ]));
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;
  const _Dropdown(
      {required this.value, required this.values, required this.onChanged});
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
      initialValue: value,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 3)),
      items: values
          .map((v) => DropdownMenuItem(value: v, child: Text(v)))
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      });
}
