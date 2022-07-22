import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visual_editor/visual-editor.dart';

import '../widgets/demo-scaffold.dart';

class DeltaSandbox extends StatefulWidget {
  const DeltaSandbox({Key? key}) : super(key: key);

  @override
  State<DeltaSandbox> createState() => _DeltaSandboxState();
}

class _DeltaSandboxState extends State<DeltaSandbox> {
  late EditorController _editorController;
  late TextEditingController _jsonInputController;
  // final _documentJson$ = StreamController<String>.broadcast();
  late final StreamSubscription _docChangesListener;
  late final StreamSubscription _docListener;
  String _jsonDocument = LOREM_LIPSUM_DOC_JSON;

  @override
  void initState() {
    _setupVisualEditorController();
    _setupDeltaEditor();

    // +++ DELETE
    Timer(Duration(seconds: 3), () {
      setState(_setupVisualEditorController);
    });

    // _subscribeToDocumentJson();
    // _subscribeToEditorDocumentChanges();
    // _loadDocument();
    super.initState();
  }

  @override
  void dispose() {
    _jsonInputController.dispose();
    _docChangesListener.cancel();
    _docListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _scaffold(
        children: [
          _stack(
            children: [
              _visualEditor(),
              _toolbar(),
            ],
          ),
          _deltaEditor(),
        ],
      );

  Widget _scaffold({required List<Widget> children}) => DemoScaffold(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      );

  Widget _stack({required List<Widget> children}) => Expanded(
        child: Stack(
          children: children,
        ),
      );

  Widget _visualEditor() => SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: VisualEditor(
            controller: _editorController,
            scrollController: ScrollController(),
            focusNode: FocusNode(),
            config: EditorConfigM(
              placeholder: 'Enter text',
            ),
          ),
        ),
      );

  Widget _deltaEditor() => Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _jsonInputController,
              maxLines: null,
              minLines: 1,
            ),
          ),
        ),
      );

  Widget _toolbar() => Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: EditorToolbar.basic(
            controller: _editorController,
          ),
        ),
      );

  void _setupVisualEditorController() {
    _editorController = EditorController(
      // TODO just init, no need to double check for empty. The update will be done by a separate method. +++
      document: _jsonDocument != ''
          ? DocumentM.fromJson(jsonDecode(_jsonDocument))
          : DocumentM(),
    );
  }

  void _setupDeltaEditor() => _jsonInputController = TextEditingController(
        text: _formatJson(
          json: _jsonDocument,
        ),
      );

  // Future<void> _loadDocument() async {
  //   final result = await rootBundle.loadString(
  //     'assets/docs/delta-sandbox.json',
  //   );
  //   _documentJson$.sink.add(result);
  // }

  // +++ REVIEW AND IMPROVE - SO FAR WE LOOK FOR THE late init bug
  // void _subscribeToDocumentJson() {
  //   _docListener = _documentJson$.stream.listen((document) {
  //     setState(() {
  //       print('+++ SETSTATE');
  //       // --> +++ THE PERF ISSUE WE DISCUSSED ON THE HIGHLIGHTS EXAMPLE
  //       _jsonDocument = document;
  //       _setupVisualEditorController(); // +++ I DON'T THINK THIS IS THE WAY
  //       _setupDeltaEditor();
  //     });
  //   });
  // }
  //
  // // +++ REVIEW AND IMPROVE - SO FAR WE LOOK FOR THE late init bug
  // void _subscribeToEditorDocumentChanges() {
  //   _docChangesListener = _editorController.document.changes.listen((_) {
  //     setState(() {
  //       _jsonDocument = jsonEncode(
  //         _editorController.document.toDelta().toJson(),
  //       );
  //       _setupVisualEditorController();
  //       _setupDeltaEditor();
  //     });
  //   });
  // }

  String _formatJson({required String json}) =>
      JsonEncoder.withIndent('    ').convert(jsonDecode(json));
}
