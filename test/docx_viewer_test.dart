import 'package:flutter_test/flutter_test.dart';

// Import all test suites
import 'src/extract_text_from_docx_test.dart' as extract_text_tests;
import 'src/docx_view_test.dart' as docx_view_tests;
import 'src/file_io_stub_test.dart' as file_io_stub_tests;
import 'src/file_io_web_test.dart' as file_io_web_tests;
import 'utils/support_type_test.dart' as support_type_tests;

/// Main test file that runs all test suites for the docx_viewer package
///
/// This ensures comprehensive test coverage across all components:
/// - Text extraction from DOCX files
/// - DocxView widget functionality
/// - Platform-specific file I/O implementations
/// - Utility classes
void main() {
  group('Extract Text from DOCX Tests', extract_text_tests.main);
  group('DocxView Widget Tests', docx_view_tests.main);
  group('FileIO Stub Tests', file_io_stub_tests.main);
  group('FileIO Web Tests', file_io_web_tests.main);
  group('Support Type Tests', support_type_tests.main);
}
