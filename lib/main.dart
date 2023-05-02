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

  void _changeText(String s) {
    setState(() {
      if (s == 'C') {
        _calcText = '';
        _solutionText = '';
      } else if (s == '=') {
        _solutionText = _calcText
            .replaceAll('x', '*')
            .replaceAll('÷', '/')
            .interpret()
            .toString();
      } else {
        _calcText = _calcText + s;
      }
    });
  }

  static const List<String> lon = [
    'C',
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
                style: TextStyle(color: textColor, fontSize: 48),
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
                    children: [
                      Text(
                        _calcText,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 48),
                      ),
                      Text(
                        (_solutionText == '') ? '' : '= $_solutionText',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttonBuilder(
                    lon[0], Colors.red, Colors.white, height / 5, width / 4),
                buttonBuilder(
                    lon[1], Colors.blue, Colors.white, height / 5, width / 4),
                buttonBuilder(
                    lon[2], Colors.blue, Colors.white, height / 5, width / 4),
                buttonBuilder(
                    lon[3], Colors.blue, Colors.white, height / 5, width / 4),
              ],
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttonBuilder(
                    '0', Colors.grey, Colors.white, height / 4, width / 2),
                buttonBuilder(
                    '.', Colors.grey, Colors.white, height / 4, width / 4)
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
