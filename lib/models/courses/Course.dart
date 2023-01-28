/// _id : "6384424b24bf7848ef34c45d"
/// course_id : 1
/// course_name : "Reasoning"
/// course_image : "https://firebasestorage.googleapis.com/v0/b/placement-preparation-46e5f.appspot.com/o/Image%20used%20in%20app%2Freasoning.png?alt=media&token=d2d45d81-d7d9-438f-9dbe-295dbc23095a"
/// topics : 6

class Course {
  Course({
    String? id,
    num? courseId,
    String? courseName,
    String? courseImage,
    num? topics,
  }) {
    _id = id;
    _courseId = courseId;
    _courseName = courseName;
    _courseImage = courseImage;
    _topics = topics;
  }

  Course.fromJson(dynamic json) {
    _id = json['_id'];
    _courseId = json['course_id'];
    _courseName = json['course_name'];
    _courseImage = json['course_image'];
    _topics = json['topics'];
  }
  String? _id;
  num? _courseId;
  String? _courseName;
  String? _courseImage;
  num? _topics;
  Course copyWith({
    String? id,
    num? courseId,
    String? courseName,
    String? courseImage,
    num? topics,
  }) =>
      Course(
        id: id ?? _id,
        courseId: courseId ?? _courseId,
        courseName: courseName ?? _courseName,
        courseImage: courseImage ?? _courseImage,
        topics: topics ?? _topics,
      );
  String? get id => _id;
  num? get courseId => _courseId;
  String? get courseName => _courseName;
  String? get courseImage => _courseImage;
  num? get topics => _topics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['course_id'] = _courseId;
    map['course_name'] = _courseName;
    map['course_image'] = _courseImage;
    map['topics'] = _topics;
    return map;
  }
}
