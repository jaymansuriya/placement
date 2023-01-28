/// difficulty : "easy"
/// question_id : 40
/// question : "A can finish a work in 24 days, B in 9 days and C in 12 days. B and C start the work but are forced to leave after 3 days. The remaining work was done by A in?"
/// options : [{"text":"5","isCorrect":false},{"text":"6","isCorrect":false},{"text":"10","isCorrect":true},{"text":"11","isCorrect":false}]

class TestQuestion {
  bool isLocked = false;
  Options? selectedOption;
  TestQuestion({
    String? difficulty,
    num? questionId,
    String? question,
    List<Options>? options,
  }) {
    _difficulty = difficulty;
    _questionId = questionId;
    _question = question;
    _options = options;
  }

  TestQuestion.fromJson(dynamic json) {
    _difficulty = json['difficulty'];
    _questionId = json['question_id'];
    _question = json['question'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }
  String? _difficulty;
  num? _questionId;
  String? _question;
  List<Options>? _options;
  TestQuestion copyWith({
    String? difficulty,
    num? questionId,
    String? question,
    List<Options>? options,
  }) =>
      TestQuestion(
        difficulty: difficulty ?? _difficulty,
        questionId: questionId ?? _questionId,
        question: question ?? _question,
        options: options ?? _options,
      );
  String? get difficulty => _difficulty;
  num? get questionId => _questionId;
  String? get question => _question;
  List<Options>? get options => _options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['difficulty'] = _difficulty;
    map['question_id'] = _questionId;
    map['question'] = _question;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "5"
/// isCorrect : false

class Options {
  Options({
    String? text,
    bool? isCorrect,
  }) {
    _text = text;
    _isCorrect = isCorrect;
  }

  Options.fromJson(dynamic json) {
    _text = json['text'];
    _isCorrect = json['isCorrect'];
  }
  String? _text;
  bool? _isCorrect;
  Options copyWith({
    String? text,
    bool? isCorrect,
  }) =>
      Options(
        text: text ?? _text,
        isCorrect: isCorrect ?? _isCorrect,
      );
  String? get text => _text;
  bool? get isCorrect => _isCorrect;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['isCorrect'] = _isCorrect;
    return map;
  }
}
