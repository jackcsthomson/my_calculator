import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _calcText = '';
  String _solutionText = '';
  List<String> _prevCalcText = [''];
  String _prevSolutionText = '';
  int prevHits = 1;

  void _changeText(String s) {
    setState(
      () {
        s = s.replaceAll('x', '*').replaceAll('÷', '/');
        if (s == 'Del') {
          _calcText = _calcText.substring(0, _calcText.length - 1);
        } else if (s == 'AC') {
          _calcText = '';
          _solutionText = '';
        } else if (s == '=') {
          try {
            _solutionText = '= ${_calcText.interpret().toString()}';
            _prevSolutionText = _solutionText.substring(2);
            _prevCalcText = _prevCalcText + [_calcText];
          } catch (e) {
            _solutionText = 'Bad expression. Please check your input';
          }
        } else if ((_solutionText != '') &&
            (_calcText == _prevCalcText[_prevCalcText.length - 1])) {
          _calcText = '';
          _solutionText = '';
          if (s == 'Prev') {
            if (_prevCalcText[_prevCalcText.length - 1] != '') {
              _calcText = _prevCalcText[_prevCalcText.length - 1];
              _solutionText = '';
            }
          } else if (s == 'Ans') {
            _calcText = _calcText + _prevSolutionText;
          } else if (s == '^' || s == '-' || s == '+' || s == '/' || s == '*') {
            _calcText = _prevSolutionText + s;
            if (_calcText.length > 13) {
              _calcText = s;
            }
          } else {
            _calcText = _calcText + s;
          }
        } else if (s == 'Prev') {
          if (_prevCalcText[_prevCalcText.length - 1] != '') {
            _calcText = _prevCalcText[_prevCalcText.length - (1 * prevHits)];
            _solutionText = '';
          }
        } else if (s == 'Ans') {
          String tempCalcText = _calcText + _prevSolutionText;
          if (tempCalcText.length < 13) {
            _calcText = tempCalcText;
          } else {
            _solutionText = 'Too long';
          }
        } else {
          if (_calcText.length < 13) {
            _calcText = _calcText + s;
          }
        }

        if (s == 'Prev') {
          prevHits++;
        } else {
          prevHits = 1;
        }
      },
    );
  }

  static const List<String> lon = [
    'AC',
    '^',
    '÷',
    'x',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '=',
    '0',
    '.',
    'Prev',
    'Ans',
    'Del',
    '(',
    ')'
  ];

  Widget buttonBuilder(
      String title, Color buttonColor, Color textColor, double h, double w) {
    return Container(
      height: h,
      width: w,
      color: buttonColor,
      child: Center(
        child: TextButton(
          onPressed: () {
            _changeText(title);
          },
          child: SizedBox(
            height: h,
            width: w,
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: textColor, fontSize: 42),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double pheight = MediaQuery.of(context).size.height;
    double height = pheight - (pheight / 7);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: pheight / 7,
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _calcText,
                        style: TextStyle(
                            color: (_solutionText == '')
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 48),
                        maxLines: 1,
                      ),
                      Text(
                        (_solutionText == '') ? '' : _solutionText,
                        style: TextStyle(
                            color: (_solutionText.contains('='))
                                ? Colors.black
                                : Colors.red,
                            fontSize: 48),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buttonBuilder(lon[0], Colors.red, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[18], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[19], Colors.grey, Colors.white,
                            height / 6, width / 4),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buttonBuilder(lon[1], Colors.blue, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[2], Colors.blue, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[3], Colors.blue, Colors.white,
                            height / 6, width / 4),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buttonBuilder(lon[4], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[5], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[6], Colors.grey, Colors.white,
                            height / 6, width / 4),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buttonBuilder(lon[8], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[9], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[10], Colors.grey, Colors.white,
                            height / 6, width / 4),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buttonBuilder(lon[12], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[13], Colors.grey, Colors.white,
                            height / 6, width / 4),
                        buttonBuilder(lon[14], Colors.grey, Colors.white,
                            height / 6, width / 4),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buttonBuilder(lon[16], Colors.grey, Colors.white,
                            height / 6, width * 2 / 4),
                        buttonBuilder(lon[17], Colors.grey, Colors.white,
                            height / 6, width / 4),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonBuilder(lon[20], Colors.grey, Colors.white,
                        height / 6, width / 4),
                    buttonBuilder(lon[7], Colors.blue, Colors.white, height / 6,
                        width / 4),
                    buttonBuilder(lon[11], Colors.blue, Colors.white,
                        height / 6, width / 4),
                    buttonBuilder(lon[21], Colors.blue, Colors.white,
                        height / 6, width / 4),
                    buttonBuilder(lon[22], Colors.blue, Colors.white,
                        height / 6, width / 4),
                    buttonBuilder(lon[15], Colors.red, Colors.white, height / 6,
                        width / 4),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
