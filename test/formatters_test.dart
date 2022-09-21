import 'package:flutter/material.dart';
import 'package:flutter3x/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test formatters', () {
    TextEditingController? controller;
    tearDown(() {
      controller?.dispose();
    });

    test('replaceArabicNumeralsFromEastToWest test', () {
      const input = '٠١٢٣٤٥٦٧٨٩'; //
      const expectedOutput = '0123456789';

      final output = replaceArabicNumeralsFromEastToWest(input);

      expect(output, expectedOutput);
    });

    testWidgets('Flutter3xFormatters.digitsOnlyWithReplacingArabicNumeralsFromEastToWest test', (tester) async {
      controller = TextEditingController();
      await tester.pumpWidget(SampleWidget(controller: controller!));

      await tester.enterText(find.byType(TextField), '٠١٢٣');
      expect(controller!.text, '0123');
      await tester.enterText(find.byType(TextField), '٠١٢٣456');
      expect(controller!.text, '0123456');
      await tester.enterText(find.byType(TextField), '٠١٢٣456٧٨٩');
      expect(controller!.text, '0123456789');
    });
  });
}

class SampleWidget extends StatelessWidget {
  const SampleWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(
          child: TextField(
            controller: controller,
            inputFormatters: Flutter3xFormatters.digitsOnlyWithReplacingArabicNumeralsFromEastToWest,
          ),
        ),
      ),
    );
  }
}
