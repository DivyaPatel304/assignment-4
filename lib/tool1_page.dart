import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tool1Page extends StatefulWidget {
  @override
  _Tool1PageState createState() => _Tool1PageState();
}

class _Tool1PageState extends State<Tool1Page> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _removeDuplicateLines() {
    final lines = _controller.text.split('\n');
    final uniqueLines = lines.toSet().toList().join('\n');

    setState(() {
      _result = uniqueLines;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Duplicate Line Remover')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Input:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter text with duplicate lines...',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(onPressed: _removeDuplicateLines, child: Text('Remove Duplicates')),
            SizedBox(height: 16.0),
            Text('Result:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Stack(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SingleChildScrollView(
                      child: SelectableText(_result, style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: _copyToClipboard,
                    child: Text('Copy'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
