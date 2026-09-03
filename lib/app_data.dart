import 'package:flutter/material.dart';

class NewsItem {
  final String title, detail, time;
  final IconData icon;
  const NewsItem(this.title, this.detail, this.time, this.icon);
}

class TaskItem {
  final String title, subject, due;
  const TaskItem(this.title, this.subject, this.due);
}

class FileItem {
  final String title, subject, type;
  const FileItem(this.title, this.subject, this.type);
}

class SubjectItem {
  final String name, count;
  final IconData icon;
  final Color color;
  const SubjectItem(this.name, this.count, this.icon, this.color);
}

class ExamItem {
  final String subject, type, date, time, place;
  const ExamItem(this.subject, this.type, this.date, this.time, this.place);
}

class SectionItem {
  final String subject, day, time, section, teacher, room;
  const SectionItem(
      this.subject, this.day, this.time, this.section, this.teacher, this.room);
}

const news = [
  NewsItem('تحديث خطة الأسبوع', 'تم تحديث محتوى الخطة الدراسية', 'منذ ساعتين',
      Icons.campaign_outlined),
  NewsItem('تنبيه مهم للطلاب', 'تأكد من متابعة مواعيد المحاضرات', 'منذ 4 ساعات',
      Icons.info_outline_rounded),
  NewsItem('إضافة محتوى جديد', 'تم تحسين تنظيم مكتبة الكلية', 'أمس',
      Icons.auto_awesome_outlined),
];
const tasks = [
  TaskItem(
      'Programming Sheet 2', 'Programming', 'التسليم 12 سبتمبر • 11:59 PM'),
  TaskItem('Database Assignment', 'Database', 'التسليم 15 سبتمبر • 11:59 PM')
];
const recentFiles = [
  FileItem('محاضرة 3 - التكامل', 'رياضة', 'PDF'),
  FileItem('Sheet 2 - Loops', 'Programming', 'PDF'),
  FileItem('Lecture 4 - Normalization', 'Database', 'PDF')
];
const subjects = [
  SubjectItem('Database', '18 ملف', Icons.storage_rounded, Color(0xFF10B981)),
  SubjectItem('Programming', '24 ملف', Icons.code_rounded, Color(0xFF3B82F6)),
  SubjectItem('رياضة', '16 ملف', Icons.functions_rounded, Color(0xFFF59E0B)),
  SubjectItem('Networks', '14 ملف', Icons.hub_outlined, Color(0xFF06B6D4))
];
const upcomingExams = [
  ExamItem('رياضة', 'Midterm', '10 سبتمبر', '10:00 ص', 'قاعة 204'),
  ExamItem('Database', 'Final', '18 سبتمبر', '12:00 م', 'قاعة 301')
];
const pastExams = [
  ExamItem('Database', 'Final 2025', '2025', '', ''),
  ExamItem('Programming', 'Midterm 2025', '2025', '', '')
];
const sections = [
  SectionItem(
      'رياضة', 'السبت', '10:00 - 11:30', 'Section 2', 'م. أحمد', 'Room 204'),
  SectionItem(
      'رياضة', 'الثلاثاء', '12:00 - 01:30', 'Section 4', 'م. محمد', 'Room 205'),
  SectionItem(
      'Programming', 'الأحد', '01:00 - 02:30', 'Section 3', 'م. محمد', 'Lab 2')
];
