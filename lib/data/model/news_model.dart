import 'dart:convert';

/// source : {"id":null,"name":"NPR"}
/// author : "The Associated Press"
/// title : "Timmy the humpback whale found dead off Danish coast - NPR"
/// description : "A humpback whale found dead this week off a Danish island has been identified as the animal released two weeks ago in a spectacular and controversial rescue effort after repeatedly becoming stranded off Germany's Baltic Sea coast, Danish authorities said Satu…"
/// url : "https://www.npr.org/2026/05/16/g-s1-122490/timmy-humpback-whale-dead-stranded-rescue-denmark"
/// urlToImage : "https://npr.brightspotcdn.com/dims3/default/strip/false/crop/6347x3570+0+330/resize/1400/quality/85/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F98%2F4c%2F0f92730941b0bbe59636ed3c3f2e%2Fap26119320944064.jpg"
/// publishedAt : "2026-05-16T15:12:44Z"
/// content : "BERLIN (AP) A humpback whale found dead this week off a Danish island has been identified as the animal released two weeks ago in a spectacular and controversial rescue effort after repeatedly becomi… [+1043 chars]"

Article newsModelFromJson(String str) => Article.fromJson(json.decode(str));
String newsModelToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    bool isBookMarked = false,
  }) {
    _source = source;
    _author = author;
    _title = title;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
    _isBookMarked = isBookMarked;
  }

  Article.fromJson(dynamic json) {
    _source = json['source'] != null ? Source.fromJson(json['source']) : null;
    _author = json['author'];
    _title = json['title'];
    _description = json['description'];
    _url = json['url'];
    _urlToImage = json['urlToImage'];
    _publishedAt = json['publishedAt'];
    _content = json['content'];
    _isBookMarked = false;
  }
  Source? _source;
  String? _author;
  String? _title;
  String? _description;
  String? _url;
  String? _urlToImage;
  String? _publishedAt;
  String? _content;
  bool _isBookMarked = false;
  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    bool? isBookMarked,
  }) => Article(
    source: source ?? _source,
    author: author ?? _author,
    title: title ?? _title,
    description: description ?? _description,
    url: url ?? _url,
    urlToImage: urlToImage ?? _urlToImage,
    publishedAt: publishedAt ?? _publishedAt,
    content: content ?? _content,
  );
  Source? get source => _source;
  String? get author => _author;
  String? get title => _title;
  String? get description => _description;
  String? get url => _url;
  String? get urlToImage => _urlToImage;
  String? get publishedAt => _publishedAt;
  String? get content => _content;
  bool get isBookMarked => _isBookMarked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_source != null) {
      map['source'] = _source?.toJson();
    }
    map['author'] = _author;
    map['title'] = _title;
    map['description'] = _description;
    map['url'] = _url;
    map['urlToImage'] = _urlToImage;
    map['publishedAt'] = _publishedAt;
    map['content'] = _content;
    return map;
  }
}

/// id : null
/// name : "NPR"

Source sourceFromJson(String str) => Source.fromJson(json.decode(str));
String sourceToJson(Source data) => json.encode(data.toJson());

class Source {
  Source({dynamic id, String? name}) {
    _id = id;
    _name = name;
  }

  Source.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  dynamic _id;
  String? _name;
  Source copyWith({dynamic id, String? name}) =>
      Source(id: id ?? _id, name: name ?? _name);
  dynamic get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
