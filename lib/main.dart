import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Laboratory 3')),
        body: const NounGrid(),
      ),
    );
  }
}

class NounGrid extends StatefulWidget {
  const NounGrid({super.key});

  @override
  _NounGridState createState() => _NounGridState();
}

class _NounGridState extends State<NounGrid> {
  final FlutterTts _flutterTts = FlutterTts();
  final List<String> _nouns = [];
  final int _numRows = 5;

  @override
  void initState() {
    super.initState();
    _generateNouns();
  }

  void _generateNouns() {
    final randomWords = generateWordPairs().take(_numRows * 2).toList();
    setState(() {
      _nouns.clear();
      _nouns.addAll(randomWords.map((pair) => pair.first));
    });
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> column1 = _nouns.take(_numRows).toList();
    final List<String> column2 = _nouns.skip(_numRows).take(_numRows).toList();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var noun in column1)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.blue,
                    child: GestureDetector(
                      onTap: () => _speak(noun),
                      child: Text(
                        noun,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var noun in column2)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.blue,
                    child: GestureDetector(
                      onTap: () => _speak(noun),
                      child: Text(
                        noun,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: _generateNouns,
                child: const Text(
                  'Randomize Nouns',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
