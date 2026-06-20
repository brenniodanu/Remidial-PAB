import 'package:flutter_test/flutter_test.dart';
import 'package:remidi/main.dart';
import 'package:remidi/splash_screen.dart';

void main() {
  testWidgets('SpaceNews Core App Smoke Test', (WidgetTester tester) async {
    // Bangun aplikasi SpaceNewsApp kita dan picu frame awal.
    await tester.pumpWidget(const SpaceNewsApp());

    // Memverifikasi apakah halaman pertama yang muncul adalah SplashScreen
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}