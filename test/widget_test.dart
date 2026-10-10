import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samirnet_video/app.dart';

void main() {
  testWidgets('onboarding shows SamirNet Video branding', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SamirNetApp()));
    expect(find.text('SamirNet Video'), findsOneWidget);
    expect(find.text('ابدأ الآن  ›'), findsOneWidget);
  });
}