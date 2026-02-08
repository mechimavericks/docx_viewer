#!/bin/bash

# Test runner script for docx_viewer package
# This script helps run tests locally and in CI/CD

set -e

echo "🧪 Running tests for docx_viewer package..."
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "   Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Print Flutter version
echo "📱 Flutter version:"
flutter --version
echo ""

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get
echo ""

# Run analyzer
echo "🔍 Running analyzer..."
flutter analyze
echo ""

# Run tests with coverage
echo "🧪 Running tests with coverage..."
flutter test --coverage
echo ""

# Check if lcov is available for coverage report
if command -v lcov &> /dev/null; then
    echo "📊 Generating coverage report..."
    
    # Generate summary
    lcov --summary coverage/lcov.info
    
    # Generate HTML report
    genhtml coverage/lcov.info -o coverage/html
    
    echo ""
    echo "✅ Coverage report generated at: coverage/html/index.html"
    echo "   Open with: open coverage/html/index.html (macOS) or xdg-open coverage/html/index.html (Linux)"
else
    echo "ℹ️  lcov not installed. Skipping HTML coverage report generation."
    echo "   Install with: sudo apt-get install lcov (Ubuntu/Debian) or brew install lcov (macOS)"
fi

echo ""
echo "✅ All tests completed successfully!"
