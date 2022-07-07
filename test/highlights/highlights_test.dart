import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:visual_editor/documents/models/attribute-scope.enum.dart';
import 'package:visual_editor/documents/models/document.model.dart';

var SIMPLE_TEXT_MOCK = '''[
  {
    "insert": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \\n",
  }
]''';

void main() {
  late DocumentM document;

  setUp(() {
    document = DocumentM.fromJson(jsonDecode(SIMPLE_TEXT_MOCK));
  });

  group('Highlights', () {
    test('Adds highlights', () { // +++
      // final markerStyle = document.root.children.first.style.attributes['marker'];
      // expect(markerStyle?.key, 'marker');
      // expect(markerStyle?.scope, AttributeScope.INLINE);
      // expect(markerStyle?.value['type'], 'expert');
      // expect(markerStyle?.value['id'], 'b53d8d53');
    });
    test('Removes highlights', () { // +++
      // final markerStyle = document.root.children.first.style.attributes['marker'];
      // expect(markerStyle?.key, 'marker');
      // expect(markerStyle?.scope, AttributeScope.INLINE);
      // expect(markerStyle?.value['type'], 'expert');
      // expect(markerStyle?.value['id'], 'b53d8d53');
    });
    test('Hovers highlights', () { // +++
      // final markerStyle = document.root.children.first.style.attributes['marker'];
      // expect(markerStyle?.key, 'marker');
      // expect(markerStyle?.scope, AttributeScope.INLINE);
      // expect(markerStyle?.value['type'], 'expert');
      // expect(markerStyle?.value['id'], 'b53d8d53');
    });
  });
}
