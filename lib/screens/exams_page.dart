import 'package:flutter/material.dart';
import '../app_data.dart';
import '../main.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          const AppPageTitle('الامتحانات'),
          const SectionTitle('الامتحانات القادمة'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                for (final exam in upcomingExams)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _UpcomingExam(exam),
                  ),
              ],
            ),
          ),
        ],
      );
}

class _UpcomingExam extends StatelessWidget {
  final ExamItem exam;
  const _UpcomingExam(this.exam);
  @override
  Widget build(BuildContext context) => SimpleCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(exam.subject,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
                const Spacer(),
                InfoPill(exam.type),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 7,
              children: [
                Text(exam.date,
                    style: const TextStyle(color: secondaryText, fontSize: 13)),
                Text(exam.time,
                    style: const TextStyle(color: secondaryText, fontSize: 13)),
                Text(exam.place,
                    style: const TextStyle(color: secondaryText, fontSize: 13)),
              ],
            ),
          ],
        ),
      );
}
