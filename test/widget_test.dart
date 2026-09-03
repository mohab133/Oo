import 'package:flutter_test/flutter_test.dart';
import 'package:college_hub/main.dart';

void main() {
  testWidgets('College Hub keeps the four-item RTL navigation', (tester) async {
    await tester.pumpWidget(const CollegeHubApp());
    await tester.pumpAndSettle();

    expect(find.text('أهلاً يا Engineer 👋'), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('المواد'), findsOneWidget);
    expect(find.text('الامتحانات'), findsOneWidget);
    expect(find.text('الجدول'), findsOneWidget);

    await tester.tap(find.text('الامتحانات'));
    await tester.pumpAndSettle();
    expect(find.text('الامتحانات القادمة'), findsOneWidget);
    expect(find.text('الامتحانات السابقة'), findsNothing);
  });
}
