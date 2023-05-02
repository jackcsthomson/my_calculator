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
  /*void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }*/

  static const List<List<String>> lon = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3']
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
            print(title);
          },
          child: SizedBox(
            height: h,
            width: w,
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: textColor),
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
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (List<String> L in lon)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (String s in L)
                    buttonBuilder(
                        s, Colors.grey, Colors.white, height / 4, width / 3)
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttonBuilder(
                    '0', Colors.grey, Colors.white, height / 4, width * 2 / 3),
                buttonBuilder(
                    '=', Colors.grey, Colors.white, height / 4, width / 3)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
