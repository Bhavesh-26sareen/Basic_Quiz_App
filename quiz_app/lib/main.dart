import 'package:flutter/material.dart';

import 'package:quiz_app/quiz_brain.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(Phoenix(
    child: MaterialApp(
      title: "Quiz_App",
      home: Quiz(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class Quiz extends StatefulWidget {
  const Quiz({Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Icon> scoreKeeper = [];
  int score = 1;
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Your Score is $score"),
      onPressed: () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        Phoenix.rebirth(context);
        quizBrain.set();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Quiz End!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void checkAnswer(bool userans) {
    bool a;
    setState(() {
      bool ca = quizBrain.getCorrectAnswer();
      a = quizBrain.next();
      if (a == false) {
        showAlertDialog(context);
        return;
      }
      if (userans == ca) {
        score++;
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Quiz_App"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: Text(
                    'True',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text(
                    'False',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ),
    );
  }
}
