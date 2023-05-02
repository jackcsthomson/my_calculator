import 'package:flutter/material.dart';

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

  void _changeText(String s) {
    setState(() {
      _calcText = _calcText + s;
    });
  }

  static const List<List<String>> lon = [
    ['7', '8', '9', '÷'],
    ['4', '5', '6', 'x'],
    ['1', '2', '3', '-'],
    ['0', '.', '=', '+']
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
    double height = pheight - (pheight / 8);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: pheight / 8,
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    _calcText,
                    style: const TextStyle(color: Colors.black, fontSize: 48),
                  ),
                ),
              ),
            ),
            for (List<String> L in lon)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (String s in L)
                    buttonBuilder(
                        s, Colors.grey, Colors.white, height / 4, width / 4),
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
