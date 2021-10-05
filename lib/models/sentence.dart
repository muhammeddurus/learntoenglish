class Sentence {
  String? en;
  String? tr;
  String? soundSrc;

  Sentence();

  Sentence.fromJson(dynamic json) {
    en = json['en'];
    tr = json['tr'];
    soundSrc = json['soundSrc'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['en'] = en;
    map['tr'] = tr;
    map['soundSrc'] = soundSrc;
    return map;
  }
}
