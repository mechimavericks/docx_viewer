# Test Suite Documentation

This directory contains comprehensive test coverage for the `docx_viewer` package.

## Test Structure

```
test/
├── docx_viewer_test.dart          # Main test entry point
├── fixtures/
│   └── test_docx_generator.dart   # Helper to generate test DOCX files
├── src/
│   ├── docx_view_test.dart        # Widget tests for DocxView
│   ├── extract_text_from_docx_test.dart  # Tests for text extraction
│   ├── file_io_stub_test.dart     # Tests for stub implementation
│   └── file_io_web_test.dart      # Tests for web implementation
└── utils/
    └── support_type_test.dart     # Tests for utility classes
```

## Test Coverage

### 1. Text Extraction Tests (`src/extract_text_from_docx_test.dart`)
- ✅ Extract text from simple DOCX files
- ✅ Extract text from DOCX with multiple paragraphs
- ✅ Handle empty DOCX documents
- ✅ Extract and number items from DOCX with numbering
- ✅ Handle special characters and unicode
- ✅ Handle invalid ZIP/DOCX data
- ✅ Handle empty paragraphs and whitespace
- ✅ Handle long text content
- ✅ Test FirstOrNullExtension utility

### 2. DocxView Widget Tests (`src/docx_view_test.dart`)
- ✅ Display loading indicator during content load
- ✅ Display content after loading with bytes parameter
- ✅ Apply custom font size
- ✅ Use default font size when not specified
- ✅ Display multiple paragraphs with newlines
- ✅ Handle empty documents
- ✅ Call onError callback when no input provided
- ✅ Display error messages without callback
- ✅ Validate error when both filePath and bytes provided
- ✅ Handle invalid bytes gracefully
- ✅ Render content in scrollable view
- ✅ Handle numbered lists
- ✅ Apply correct padding

### 3. Platform-Specific File I/O Tests
- ✅ Stub implementation tests (`src/file_io_stub_test.dart`)
- ✅ Web implementation tests (`src/file_io_web_test.dart`)
- ✅ Verify proper error messages for unsupported operations

### 4. Utility Tests (`utils/support_type_test.dart`)
- ✅ Validate Supporttype constants

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Specific Test File
```bash
flutter test test/src/docx_view_test.dart
```

### View Coverage Report
After running tests with coverage, you can generate an HTML report:

```bash
# Install lcov (Ubuntu/Debian)
sudo apt-get install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser
open coverage/html/index.html
```

## Test Fixtures

The `fixtures/test_docx_generator.dart` file provides helper methods to generate test DOCX files:

- `createSimpleDocx(String text)` - Creates a simple DOCX with given text
- `createDocxWithNumbering(List<String> items)` - Creates DOCX with numbered list
- `createEmptyDocx()` - Creates an empty DOCX file
- `createDocxWithMultipleParagraphs(List<String> paragraphs)` - Creates DOCX with multiple paragraphs

These helpers create proper DOCX files (ZIP archives) with the correct XML structure for testing.

## Continuous Integration

Tests are automatically run on every pull request through GitHub Actions (`.github/workflows/ci.yml`):

1. **Analyze Job**: Runs static analysis and formatting checks
2. **Test Job**: Runs all tests with coverage
   - Generates coverage report
   - Posts coverage summary as PR comment
   - Uploads coverage artifacts

The CI workflow:
- ✅ Runs on pull requests to `main` and `dev` branches
- ✅ Runs on push to `main` and `dev` branches
- ✅ Generates test coverage reports
- ✅ Comments on PRs with coverage information
- ✅ Provides coverage badges

## Adding New Tests

When adding new tests:

1. Create test files in appropriate directories (`src/`, `utils/`, etc.)
2. Follow the existing test structure and naming conventions
3. Use descriptive test names that explain what is being tested
4. Include arrange-act-assert comments in tests for clarity
5. Import the test file in `docx_viewer_test.dart` to include in the main test suite
6. Run tests locally before committing

Example:
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeatureName', () {
    test('should do something specific', () {
      // Arrange
      final input = 'test';
      
      // Act
      final result = functionUnderTest(input);
      
      // Assert
      expect(result, equals('expected'));
    });
  });
}
```

## Test Best Practices

1. **Isolation**: Each test should be independent and not rely on other tests
2. **Clarity**: Use descriptive test names that explain the scenario
3. **Coverage**: Aim for high coverage but focus on meaningful tests
4. **Edge Cases**: Test boundary conditions, error cases, and edge cases
5. **Maintainability**: Keep tests simple and maintainable
6. **Performance**: Tests should run quickly to support rapid development

## Coverage Goals

The package aims for:
- **Minimum**: 80% code coverage
- **Target**: 90%+ code coverage
- **Focus**: All critical paths and error handling must be tested

Current coverage is tracked automatically in CI and reported on pull requests.
