/// 视频章节
class VideoChapterModel {
  int _id;
  String _title;
  String _chapterUrl;
  String _videoId;
  String _creationTime;
  int _videoVariableId;

  VideoChapterModel(
      {int id,
      String title,
      String chapterUrl,
      String videoId,
      String creationTime,
      int videoVariableId}) {
    this._id = id;
    this._title = title;
    this._chapterUrl = chapterUrl;
    this._videoId = videoId;
    this._creationTime = creationTime;
    this._videoVariableId = videoVariableId;
  }

  int get id => _id;

  set id(int id) => _id = id;

  String get title => _title;

  set title(String title) => _title = title;

  String get chapterUrl => _chapterUrl;

  set chapterUrl(String chapterUrl) => _chapterUrl = chapterUrl;

  String get videoId => _videoId;

  set videoId(String videoId) => _videoId = videoId;

  String get creationTime => _creationTime;

  set creationTime(String creationTime) => _creationTime = creationTime;

  int get videoVariableId => _videoVariableId;

  set videoVariableId(int videoVariableId) =>
      _videoVariableId = videoVariableId;

  VideoChapterModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _chapterUrl = json['chapterUrl'];
    _videoId = json['videoId'];
    _creationTime = json['creationTime'];
    _videoVariableId = json['videoVariableId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['chapterUrl'] = this._chapterUrl;
    data['videoId'] = this._videoId;
    data['creationTime'] = this._creationTime;
    data['videoVariableId'] = this._videoVariableId;
    return data;
  }
}
