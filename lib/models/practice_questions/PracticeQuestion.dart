/// _id : "63aa946427d2978ba539b4a8"
/// course_id : "2"
/// chapter_id : "2"
/// question_id : 33
/// question : "From a group of 7 men and 6 women, five persons are to be selected to form a committee so that at least 3 men are there on the committee. In how many ways can it be done?"
/// solution_image_url : "https://firebasestorage.googleapis.com/v0/b/material-aa4f1.appspot.com/o/Image%20Solution%2FQuantitative%2F2.%20Permutation%20%26%20Combination%2F1.png?alt=media&token=5dd85024-576b-490b-a77c-de2c3549b305"
/// options : [{"text":"564","isCorrect":false},{"text":"645","isCorrect":false},{"text":"735","isCorrect":false},{"text":"756","isCorrect":true}]

class PracticeQuestion {
  bool isLocked = false;
  Options? selectedOption;

  PracticeQuestion({
    String? id,
    String? courseId,
    String? chapterId,
    num? questionId,
    String? question,
    String? solutionImageUrl,
    List<Options>? options,
  }) {
    _id = id;
    _courseId = courseId;
    _chapterId = chapterId;
    _questionId = questionId;
    _question = question;
    _solutionImageUrl = solutionImageUrl;
    _options = options;
  }

  PracticeQuestion.fromJson(dynamic json) {
    _id = json['_id'];
    _courseId = json['course_id'];
    _chapterId = json['chapter_id'];
    _questionId = json['question_id'];
    _question = json['question'];
    _solutionImageUrl = json['solution_image_url'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }
  String? _id;
  String? _courseId;
  String? _chapterId;
  num? _questionId;
  String? _question;
  String? _solutionImageUrl;
  List<Options>? _options;
  PracticeQuestion copyWith({
    String? id,
    String? courseId,
    String? chapterId,
    num? questionId,
    String? question,
    String? solutionImageUrl,
    List<Options>? options,
  }) =>
      PracticeQuestion(
        id: id ?? _id,
        courseId: courseId ?? _courseId,
        chapterId: chapterId ?? _chapterId,
        questionId: questionId ?? _questionId,
        question: question ?? _question,
        solutionImageUrl: solutionImageUrl ?? _solutionImageUrl,
        options: options ?? _options,
      );
  String? get id => _id;
  String? get courseId => _courseId;
  String? get chapterId => _chapterId;
  num? get questionId => _questionId;
  String? get question => _question;
  String? get solutionImageUrl => _solutionImageUrl;
  List<Options>? get options => _options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['course_id'] = _courseId;
    map['chapter_id'] = _chapterId;
    map['question_id'] = _questionId;
    map['question'] = _question;
    map['solution_image_url'] = _solutionImageUrl;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "564"
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
