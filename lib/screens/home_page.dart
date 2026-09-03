import 'package:flutter/material.dart';
import '../app_data.dart';
import '../main.dart';

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
            child: Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('أهلاً يا Engineer 👋',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    const Text('كل اللي محتاجه لدراستك، في مكان واحد.',
                        style: TextStyle(color: secondaryText, fontSize: 14)),
                  ])),
              IconButton(
                  onPressed: () => showNotifications(context),
                  icon: const Icon(Icons.notifications_none_rounded,
                      color: primaryDark)),
            ]),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 22)),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(
              child: SearchBox(
                  hint: 'ابحث عن مادة أو ملف أو امتحان',
                  onSubmitted: (query) {
                    if (query.trim().isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SearchResultsPage(query: query)));
                    }
                  })),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 26)),
        SliverToBoxAdapter(
          child: CarouselSection<NewsItem>(
            title: 'آخر الأخبار',
            items: news,
            builder: (item) => SimpleCard(
                child: Row(children: [
              SoftIcon(icon: item.icon, color: primary),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16)),
                    const SizedBox(height: 7),
                    Text(item.detail,
                        style: const TextStyle(color: secondaryText)),
                    const SizedBox(height: 8),
                    Text(item.time,
                        style: const TextStyle(
                            color: secondaryText, fontSize: 11)),
                  ])),
            ])),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 26)),
        SliverToBoxAdapter(
          child: CarouselSection<TaskItem>(
            title: 'المهام القادمة',
            items: tasks,
            builder: (item) => SimpleCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    const SoftIcon(
                        icon: Icons.assignment_outlined,
                        color: Color(0xFFF59E0B)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(item.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16))),
                  ]),
                  const SizedBox(height: 10),
                  Text(item.subject,
                      style:
                          const TextStyle(color: secondaryText, fontSize: 12)),
                  const Spacer(),
                  Text(item.due,
                      style:
                          const TextStyle(color: secondaryText, fontSize: 12)),
                ])),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 26)),
        SliverToBoxAdapter(
          child: CarouselSection<FileItem>(
            title: 'آخر الملفات',
            items: recentFiles,
            builder: (item) => SimpleCard(
                child: Row(children: [
              const SoftIcon(
                  icon: Icons.picture_as_pdf_outlined,
                  color: Color(0xFFEF4444)),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 7),
                    Text('${item.subject} • ${item.type}',
                        style: const TextStyle(color: secondaryText))
                  ])),
            ])),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 28)),
      ],
    );
  }
}

class SearchResultsPage extends StatelessWidget {
  final String query;
  const SearchResultsPage({super.key, required this.query});
  @override
  Widget build(BuildContext context) {
    final q = query.toLowerCase();
    final results = [
      ...subjects
          .where((item) => item.name.toLowerCase().contains(q))
          .map((item) => '${item.name} • مادة'),
      ...recentFiles
          .where((item) =>
              '${item.title} ${item.subject}'.toLowerCase().contains(q))
          .map((item) => '${item.title} • ${item.subject}'),
      ...news
          .where((item) =>
              '${item.title} ${item.detail}'.toLowerCase().contains(q))
          .map((item) => '${item.title} • خبر'),
    ];
    return DetailPage(
        title: 'نتائج البحث',
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Text('نتائج عن: $query',
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 14),
          if (results.isEmpty)
            const Text('لا توجد نتائج مطابقة',
                style: TextStyle(color: secondaryText))
          else
            ...results.map((item) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.search_rounded, color: primary),
                title: Text(item)))
        ]));
  }
}
