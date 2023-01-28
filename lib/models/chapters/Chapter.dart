/// _id : "63a40871bf0dc9a0a1c6394e"
/// course_id : 1
/// chapter_id : 1
/// chapter_name : "Number Series"
/// chapter_image : ""
/// material_url : "https://firebasestorage.googleapis.com/v0/b/material-aa4f1.appspot.com/o/Reasoning%2FNumber%20Series.pdf?alt=media&token=93b1e374-9eac-4a75-9922-8864efad7ded"
/// video_url : "https://youtu.be/gXBuL_FyahE?list=PLpyc33gOcbVADMKqylI__O_O_RMeHTyNK"
/// video_duration : "60 mins"

class Chapter {
  Chapter({
    String? id,
    num? courseId,
    num? chapterId,
    String? chapterName,
    String? chapterImage,
    String? materialUrl,
    String? videoUrl,
    String? videoDuration,
  }) {
    _id = id;
    _courseId = courseId;
    _chapterId = chapterId;
    _chapterName = chapterName;
    _chapterImage = chapterImage;
    _materialUrl = materialUrl;
    _videoUrl = videoUrl;
    _videoDuration = videoDuration;
  }

  Chapter.fromJson(dynamic json) {
    _id = json['_id'];
    _courseId = json['course_id'];
    _chapterId = json['chapter_id'];
    _chapterName = json['chapter_name'];
    _chapterImage = json['chapter_image'];
    _materialUrl = json['material_url'];
    _videoUrl = json['video_url'];
    _videoDuration = json['video_duration'];
  }
  String? _id;
  num? _courseId;
  num? _chapterId;
  String? _chapterName;
  String? _chapterImage;
  String? _materialUrl;
  String? _videoUrl;
  String? _videoDuration;
  Chapter copyWith({
    String? id,
    num? courseId,
    num? chapterId,
    String? chapterName,
    String? chapterImage,
    String? materialUrl,
    String? videoUrl,
    String? videoDuration,
  }) =>
      Chapter(
        id: id ?? _id,
        courseId: courseId ?? _courseId,
        chapterId: chapterId ?? _chapterId,
        chapterName: chapterName ?? _chapterName,
        chapterImage: chapterImage ?? _chapterImage,
        materialUrl: materialUrl ?? _materialUrl,
        videoUrl: videoUrl ?? _videoUrl,
        videoDuration: videoDuration ?? _videoDuration,
      );
  String? get id => _id;
  num? get courseId => _courseId;
  num? get chapterId => _chapterId;
  String? get chapterName => _chapterName;
  String? get chapterImage => _chapterImage;
  String? get materialUrl => _materialUrl;
  String? get videoUrl => _videoUrl;
  String? get videoDuration => _videoDuration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['course_id'] = _courseId;
    map['chapter_id'] = _chapterId;
    map['chapter_name'] = _chapterName;
    map['chapter_image'] = _chapterImage;
    map['material_url'] = _materialUrl;
    map['video_url'] = _videoUrl;
    map['video_duration'] = _videoDuration;
    return map;
  }
}
