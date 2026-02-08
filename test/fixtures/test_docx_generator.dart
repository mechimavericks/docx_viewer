import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'dart:convert';

/// Helper class to generate test DOCX files for testing purposes
class TestDocxGenerator {
  /// Creates a simple DOCX file with the given text content
  static Uint8List createSimpleDocx(String text) {
    final archive = Archive();

    // Create the required DOCX structure
    _addContentTypes(archive);
    _addRels(archive);
    _addDocument(archive, text);

    // Encode the archive as a ZIP file
    final zipEncoder = ZipEncoder();
    final zipBytes = zipEncoder.encode(archive);
    return Uint8List.fromList(zipBytes!);
  }

  /// Creates a DOCX file with numbered list
  static Uint8List createDocxWithNumbering(List<String> items) {
    final archive = Archive();

    // Create the required DOCX structure
    _addContentTypes(archive);
    _addRels(archive);
    _addDocumentWithNumbering(archive, items);

    // Encode the archive as a ZIP file
    final zipEncoder = ZipEncoder();
    final zipBytes = zipEncoder.encode(archive);
    return Uint8List.fromList(zipBytes!);
  }

  /// Creates an empty DOCX file
  static Uint8List createEmptyDocx() {
    return createSimpleDocx('');
  }

  /// Creates a DOCX file with multiple paragraphs
  static Uint8List createDocxWithMultipleParagraphs(List<String> paragraphs) {
    final archive = Archive();

    // Create the required DOCX structure
    _addContentTypes(archive);
    _addRels(archive);
    _addDocumentWithParagraphs(archive, paragraphs);

    // Encode the archive as a ZIP file
    final zipEncoder = ZipEncoder();
    final zipBytes = zipEncoder.encode(archive);
    return Uint8List.fromList(zipBytes!);
  }

  static void _addContentTypes(Archive archive) {
    const contentTypesXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>''';

    final file = ArchiveFile('[Content_Types].xml', contentTypesXml.length,
        utf8.encode(contentTypesXml));
    archive.addFile(file);
  }

  static void _addRels(Archive archive) {
    const relsXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>''';

    final file =
        ArchiveFile('_rels/.rels', relsXml.length, utf8.encode(relsXml));
    archive.addFile(file);
  }

  static void _addDocument(Archive archive, String text) {
    final documentXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:p>
      <w:r>
        <w:t>$text</w:t>
      </w:r>
    </w:p>
  </w:body>
</w:document>''';

    final file = ArchiveFile(
        'word/document.xml', documentXml.length, utf8.encode(documentXml));
    archive.addFile(file);
  }

  static void _addDocumentWithNumbering(Archive archive, List<String> items) {
    final paragraphs = items.asMap().entries.map((entry) {
      return '''
    <w:p>
      <w:pPr>
        <w:numPr>
          <w:ilvl w:val="0"/>
          <w:numId w:val="1"/>
        </w:numPr>
      </w:pPr>
      <w:r>
        <w:t>${entry.value}</w:t>
      </w:r>
    </w:p>''';
    }).join('\n');

    final documentXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
$paragraphs
  </w:body>
</w:document>''';

    final file = ArchiveFile(
        'word/document.xml', documentXml.length, utf8.encode(documentXml));
    archive.addFile(file);
  }

  static void _addDocumentWithParagraphs(
      Archive archive, List<String> paragraphs) {
    final paragraphsXml = paragraphs.map((text) {
      return '''
    <w:p>
      <w:r>
        <w:t>$text</w:t>
      </w:r>
    </w:p>''';
    }).join('\n');

    final documentXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
$paragraphsXml
  </w:body>
</w:document>''';

    final file = ArchiveFile(
        'word/document.xml', documentXml.length, utf8.encode(documentXml));
    archive.addFile(file);
  }
}
