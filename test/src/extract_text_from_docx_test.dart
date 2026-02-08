import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:docx_viewer/src/extract_text_from_docx.dart';
import '../fixtures/test_docx_generator.dart';

void main() {
  group('extractTextFromDocxBytes', () {
    test('should extract text from simple DOCX with single paragraph', () {
      // Arrange
      final docxBytes = TestDocxGenerator.createSimpleDocx('Hello World');

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, equals('Hello World'));
    });

    test('should extract text from DOCX with multiple paragraphs', () {
      // Arrange
      final paragraphs = [
        'First paragraph',
        'Second paragraph',
        'Third paragraph'
      ];
      final docxBytes =
          TestDocxGenerator.createDocxWithMultipleParagraphs(paragraphs);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(
          result, equals('First paragraph\nSecond paragraph\nThird paragraph'));
    });

    test('should handle empty DOCX document', () {
      // Arrange
      final docxBytes = TestDocxGenerator.createEmptyDocx();

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, equals(''));
    });

    test('should extract and number items from DOCX with numbering', () {
      // Arrange
      final items = ['First item', 'Second item', 'Third item'];
      final docxBytes = TestDocxGenerator.createDocxWithNumbering(items);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, contains('1. First item'));
      expect(result, contains('2. Second item'));
      expect(result, contains('3. Third item'));
    });

    test('should handle DOCX with special characters', () {
      // Arrange
      final text = 'Special chars: @#\$%^&*()';
      final docxBytes = TestDocxGenerator.createSimpleDocx(text);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, equals(text));
    });

    test('should handle DOCX with unicode characters', () {
      // Arrange
      final text = 'Unicode: 你好 مرحبا שלום';
      final docxBytes = TestDocxGenerator.createSimpleDocx(text);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, equals(text));
    });

    test('should throw exception when document.xml is not found', () {
      // Arrange
      final invalidBytes =
          Uint8List.fromList([80, 75, 3, 4]); // ZIP header but invalid DOCX

      // Act & Assert
      expect(
        () => extractTextFromDocxBytes(invalidBytes),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw exception when bytes are not valid ZIP', () {
      // Arrange
      final invalidBytes = Uint8List.fromList([1, 2, 3, 4, 5]);

      // Act & Assert
      expect(
        () => extractTextFromDocxBytes(invalidBytes),
        throwsException,
      );
    });

    test('should handle DOCX with empty paragraphs between text', () {
      // Arrange
      final paragraphs = ['First', '', 'Third'];
      final docxBytes =
          TestDocxGenerator.createDocxWithMultipleParagraphs(paragraphs);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, equals('First\n\nThird'));
    });

    test('should handle DOCX with only whitespace', () {
      // Arrange
      final docxBytes = TestDocxGenerator.createSimpleDocx('   ');

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, equals('   '));
    });

    test('should handle DOCX with long text', () {
      // Arrange
      final longText = 'A' * 1000;
      final docxBytes = TestDocxGenerator.createSimpleDocx(longText);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result.length, equals(1000));
      expect(result, equals(longText));
    });

    test('should handle DOCX with newline characters in text', () {
      // Arrange
      final text = 'Line 1\nLine 2';
      final docxBytes = TestDocxGenerator.createSimpleDocx(text);

      // Act
      final result = extractTextFromDocxBytes(docxBytes);

      // Assert
      expect(result, contains('Line 1'));
      expect(result, contains('Line 2'));
    });
  });

  group('FirstOrNullExtension', () {
    test('should return first element when iterable is not empty', () {
      // Arrange
      final list = [1, 2, 3];

      // Act
      final result = list.firstOrNull;

      // Assert
      expect(result, equals(1));
    });

    test('should return null when iterable is empty', () {
      // Arrange
      final list = <int>[];

      // Act
      final result = list.firstOrNull;

      // Assert
      expect(result, isNull);
    });
  });
}
