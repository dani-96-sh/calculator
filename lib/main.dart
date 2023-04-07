import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var inputUser = '';
  var Result = '';
  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 2.0, color: Colors.transparent),
              ),
              backgroundColor: getbackgroundcolor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                Result = '';
              });
            } else {
              buttonPressed(text1);
            }
            ;
          },
          child: Text(
            text1,
            style: TextStyle(fontSize: 29, color: getTextColor(text1)),
          )),
      TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 2.0, color: Colors.transparent),
              ),
              backgroundColor: getbackgroundcolor(text2)),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                inputUser = inputUser.substring(0, inputUser.length - 1);
              });
            } else {
              buttonPressed(text2);
            }
            ;
          },
          child: Text(
            text2,
            style: TextStyle(fontSize: 29, color: getTextColor(text2)),
          )),
      TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 2.0, color: Colors.transparent),
              ),
              backgroundColor: getbackgroundcolor(text3)),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Text(
            text3,
            style: TextStyle(fontSize: 29, color: getTextColor(text3)),
          )),
      TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 2.0, color: Colors.transparent),
              ),
              backgroundColor: getbackgroundcolor(text4)),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                Result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
            ;
          },
          child: Text(
            text4,
            style: TextStyle(fontSize: 29, color: getTextColor(text4)),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: textGreen,
                              fontSize: 40,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          Result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: textGrey,
                              fontSize: 60,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    color: backgroundGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getRow('ac', 'ce', '%', '/'),
                        getRow('9', '8', '7', '*'),
                        getRow('4', '5', '6', '+'),
                        getRow('1', '2', '3', '-'),
                        getRow('00', '0', '.', '=')
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isAction(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '+', '-', '='];

    for (var item in list) {
      if (item == text) {
        return true;
      }
    }
    return false;
  }

  Color getbackgroundcolor(String text) {
    if (isAction(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isAction(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
