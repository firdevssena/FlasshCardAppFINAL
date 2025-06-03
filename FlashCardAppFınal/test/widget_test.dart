import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard_app/main.dart';  // Burada FlashcardApp'ı import edin

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Uygulamayı oluşturup bir frame tetikleyelim
    await tester.pumpWidget(const FlashcardApp());  // MyApp yerine FlashcardApp

    // Sayfanın başlangıçta 0 sayısını içerdiğini doğrulayalım
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // '+' ikonuna tıklayalım ve bir frame tetikleyelim
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Sayacın arttığını doğrulayalım
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
