import 'package:flutter_test/flutter_test.dart';
import 'package:docx_viewer/src/file_io_web.dart';

void main() {
  group('FileIO Web Implementation', () {
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

    test('readFileBytes error message should mention web platform limitation',
        () async {
      // Act & Assert
      try {
        await FileIO.readFileBytes('test.docx');
        fail('Should have thrown UnsupportedError');
      } catch (e) {
        expect(e, isA<UnsupportedError>());
        expect(
          e.toString(),
          contains('Direct file path access is not supported on web'),
        );
        expect(
          e.toString(),
          contains('bytes'),
        );
      }
    });

    test('fileExists error message should mention web platform limitation',
        () async {
      // Act & Assert
      try {
        await FileIO.fileExists('test.docx');
        fail('Should have thrown UnsupportedError');
      } catch (e) {
        expect(e, isA<UnsupportedError>());
        expect(
          e.toString(),
          contains('File system access is not supported on web'),
        );
      }
    });

    test('readFileBytes should provide alternative solution in error',
        () async {
      // Act & Assert
      try {
        await FileIO.readFileBytes('test.docx');
        fail('Should have thrown UnsupportedError');
      } catch (e) {
        expect(
          e.toString(),
          contains('file picker'),
        );
        expect(
          e.toString(),
          contains('network URL'),
        );
      }
    });
  });
}
