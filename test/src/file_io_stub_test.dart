import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:docx_viewer/src/file_io_stub.dart';

void main() {
  group('FileIO Stub Implementation', () {
    test('readFileBytes should throw UnsupportedError', () async {
      // Act & Assert
      expect(
        () async => await FileIO.readFileBytes('test.docx'),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('fileExists should throw UnsupportedError', () async {
      // Act & Assert
      expect(
        () async => await FileIO.fileExists('test.docx'),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('readFileBytes error message should be descriptive', () async {
      // Act & Assert
      try {
        await FileIO.readFileBytes('test.docx');
        fail('Should have thrown UnsupportedError');
      } catch (e) {
        expect(e, isA<UnsupportedError>());
        expect(
          e.toString(),
          contains('Cannot read files without platform-specific implementation'),
        );
      }
    });

    test('fileExists error message should be descriptive', () async {
      // Act & Assert
      try {
        await FileIO.fileExists('test.docx');
        fail('Should have thrown UnsupportedError');
      } catch (e) {
        expect(e, isA<UnsupportedError>());
        expect(
          e.toString(),
          contains('Cannot check file existence without platform-specific implementation'),
        );
      }
    });
  });
}
