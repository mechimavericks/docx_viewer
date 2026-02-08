import 'package:flutter_test/flutter_test.dart';
import 'package:docx_viewer/utils/support_type.dart';

void main() {
  group('Supporttype', () {
    test('should have docx constant defined', () {
      // Assert
      expect(Supporttype.docx, equals('docx'));
    });

    test('docx constant should be lowercase', () {
      // Assert
      expect(Supporttype.docx, equals(Supporttype.docx.toLowerCase()));
    });

    test('docx constant should be a String', () {
      // Assert
      expect(Supporttype.docx, isA<String>());
    });

    test('docx constant should not be empty', () {
      // Assert
      expect(Supporttype.docx.isNotEmpty, isTrue);
    });
  });
}
