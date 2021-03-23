import 'Question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questionbank = [
    Question(q: 'queation 1 ?', a: true),
    Question(q: 'question 2?', a: false),
    Question(q: 'question 3?', a: true),
    Question(q: 'question 4?', a: true),
    Question(q: 'queation 5?', a: true),
    Question(q: 'question 6?', a: false),
    Question(q: 'question 7?', a: true),
    Question(q: 'question 8?', a: true),
  ];
  bool next() {
    bool a = false;
    if (_questionNumber < _questionbank.length - 1) {
      _questionNumber++;
      a = true;
    }
    print(_questionNumber);
    return a;
  }

  void set() {
    _questionNumber = 0;
  }

  String getQuestionText() {
    return _questionbank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionbank[_questionNumber].questionAns;
  }
}
