import 'dart:convert';

import 'package:buzzword_bingo/components/word_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class GameScreen extends StatefulWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadAsset(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            final text = json.decode(snapshot.data) as List<String>;
            text.shuffle();

            return _buildBody(text);
          }
          return Center(
            child: Text('${snapshot.data}...'),
          );
        },
      ),
    );
  }

  Padding _buildBody(List<String> text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 25,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.3,
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return WordCard(text[index]);
          },
        ),
      ),
    );
  }

  Future<String> loadAsset() async {
    return rootBundle.loadString('assets/hda.json');
  }
}
