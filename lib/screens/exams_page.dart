import 'package:flutter/material.dart';
import '../app_data.dart';
import '../main.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});
  @override
  Widget build(BuildContext context) =>
      ListView(padding: const EdgeInsets.only(bottom: 28), children: [
        AppPageTitle('الامتحانات'),
        const SectionTitle('الامتحانات القادمة'),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              for (final exam in upcomingExams)
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _UpcomingExam(exam))
            ])),
        const SizedBox(height: 16),
        const SectionTitle('الامتحانات السابقة'),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              for (final exam in pastExams)
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                        tileColor: surface,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        leading: const Icon(Icons.picture_as_pdf_outlined,
                            color: Color(0xFFEF4444)),
                        title: Text(exam.subject,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text('${exam.type} • ${exam.date}'),
                        trailing: const Icon(Icons.download_outlined,
                            color: primary)))
            ]))
      ]);
}

class _UpcomingExam extends StatelessWidget {
  final ExamItem exam;
  const _UpcomingExam(this.exam);
  @override
  Widget build(BuildContext context) => SimpleCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(exam.subject,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          const Spacer(),
          InfoPill(exam.type)
        ]),
        const SizedBox(height: 14),
        Wrap(spacing: 14, runSpacing: 9, children: [
          Text('📅 ${exam.date}'),
          Text('⏰ ${exam.time}'),
          Text('📍 ${exam.place}')
        ])
      ]));
}
