class Word {
  String? en;
  String? tr;
  String? soundSrc;

  Word();

  Word.fromJson(dynamic json) {
    en = json['en'];
    tr = json['tr'];
    soundSrc = json['sound_src'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['en'] = en;
    map['tr'] = tr;
    map['sound_src'] = soundSrc;
    return map;
  }
}
