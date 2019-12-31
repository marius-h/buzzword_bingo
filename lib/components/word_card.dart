import 'package:buzzword_bingo/cross_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordCard extends StatefulWidget {
  const WordCard(
    this.word, {
    Key key,
  }) : super(key: key);

  final String word;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with TickerProviderStateMixin {
  bool checked = false;

  double lineOneFraction = 0, lineTwoFraction = 0;

  Animation<double> lineOneAnimation, lineTwoAnimation;

  AnimationController _controllerOne, _controllerTwo;

  @override
  void initState() {
    super.initState();
    _controllerOne = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _controllerTwo = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    lineOneAnimation = Tween(begin: 0.0, end: 1.0).animate(_controllerOne)
      ..addListener(() {
        setState(() {
          lineOneFraction = lineOneAnimation.value;
        });
        if (lineOneAnimation.isCompleted || lineOneAnimation.isDismissed) {
          checked ? _controllerTwo.forward() : _controllerTwo.reverse();
        }
      });
    lineTwoAnimation = Tween(begin: 0.0, end: 1.0).animate(_controllerTwo)
      ..addListener(() {
        setState(() {
          lineTwoFraction = lineTwoAnimation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;

          checked ? _controllerOne.forward() : _controllerOne.reverse();
        });
      },
      child: CustomPaint(
        foregroundPainter: CrossPainter(lineOneFraction, lineTwoFraction),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            //boxShadow: shadows,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.word,
                style: Theme.of(context).textTheme.body2.copyWith(),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerOne.dispose();
    super.dispose();
  }
}
