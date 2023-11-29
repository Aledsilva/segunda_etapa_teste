class BookModel {
  int? _id;
  String? _title;
  String? _author;
  String? _coverUrl;
  String? _downloadUrl;

  BookModel(
      {int? id,
      String? title,
      String? author,
      String? coverUrl,
      String? downloadUrl}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (author != null) {
      this._author = author;
    }
    if (coverUrl != null) {
      this._coverUrl = coverUrl;
    }
    if (downloadUrl != null) {
      this._downloadUrl = downloadUrl;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get author => _author;
  set author(String? author) => _author = author;
  String? get coverUrl => _coverUrl;
  set coverUrl(String? coverUrl) => _coverUrl = coverUrl;
  String? get downloadUrl => _downloadUrl;
  set downloadUrl(String? downloadUrl) => _downloadUrl = downloadUrl;

  BookModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _author = json['author'];
    _coverUrl = json['cover_url'];
    _downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['author'] = this._author;
    data['cover_url'] = this._coverUrl;
    data['download_url'] = this._downloadUrl;
    return data;
  }
}
