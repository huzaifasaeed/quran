class VerseModel {
  int? id;
  int? verseNumber;
  int? surahId;
  String? verseKey;
  int? juzNumber;
  int? hizbNumber;
  int? rubElHizbNumber;
  int? sajdahNumber;
  int? pageNumber;
  int? rukuNumber;
  int? manzilNumber;
  String? text;
  String? textIndoPak;
  String? textUthmaniTajweed;
  String? audioUrl;
  String? surahNameArabic;
  String? surahNameTranslated;
  String? surahNameSimple;

  VerseModel(
      {this.id,
      this.verseNumber,
      this.surahId,
      this.verseKey,
      this.juzNumber,
      this.hizbNumber,
      this.rubElHizbNumber,
      this.sajdahNumber,
      this.pageNumber,
      this.rukuNumber,
      this.manzilNumber,
      this.text,
      this.textIndoPak,
      this.textUthmaniTajweed,
      this.audioUrl,
      this.surahNameArabic,
      this.surahNameSimple,
      this.surahNameTranslated});

  @override
  String toString() {
    return 'VerseModel{id: $id, verseNumber: $verseNumber, surahId: $surahId, verseKey: $verseKey, juzNumber: $juzNumber, hizbNumber: $hizbNumber, rubElHizbNumber: $rubElHizbNumber, sajdahNumber: $sajdahNumber, pageNumber: $pageNumber, rukuNumber: $rukuNumber, manzilNumber: $manzilNumber text: $text, textIndoPak: $textIndoPak, textUthmaniTajweed: $textUthmaniTajweed, audioUrl: $audioUrl, surahNameArabic: $surahNameArabic, surahNameTranslated: $surahNameTranslated, surahNameSimple: $surahNameSimple}';
  }

  VerseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verseNumber = json['verse_number'];
    surahId = json['surah_id'];
    verseKey = json['verse_key'];
    juzNumber = json['juz_number'];
    hizbNumber = json['hizb_number'];
    rubElHizbNumber = json['rub_el_hizb_number'];
    sajdahNumber = json['sajdah_number'];
    pageNumber = json['page_number'];
    rukuNumber = json['ruku_number'];
    manzilNumber = json['manzil_number'];
    text = json['text'];
    textIndoPak = json['text_indopak'];
    textUthmaniTajweed = json['text_uthmani_tajweed'];
    audioUrl = json['audio_url'];
    surahNameTranslated = json['surah_name_translated'];
    surahNameArabic = json['surah_name_arabic'];
    surahNameSimple = json['surah_name_simple'];
  }

  VerseModel.fromJsonForQuranApi(Map<String, dynamic> json) {
    id = json['id'];
    verseNumber = json['verse_number'];
    surahId = json['chapter_id'];
    verseKey = json['verse_key'];
    juzNumber = json['juz_number'];
    hizbNumber = json['hizb_number'];
    rubElHizbNumber = json['rub_el_hizb_number'];
    sajdahNumber = json['sajdah_number'];
    pageNumber = json['page_number'];
    rukuNumber = json['ruku_number'];
    textIndoPak = json['text_indopak'];
    textUthmaniTajweed = json['text_uthmani_tajweed'];
    manzilNumber = json['manzil_number'];
    text = json['text_madani'];
    audioUrl = json['audio']['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['verse_number'] = verseNumber;
    data['surah_id'] = surahId;
    data['verse_key'] = verseKey;
    data['juz_number'] = juzNumber;
    data['hizb_number'] = hizbNumber;
    data['rub_el_hizb_number'] = rubElHizbNumber;
    data['sajdah_number'] = sajdahNumber;
    data['page_number'] = pageNumber;
    data['ruku_number'] = rukuNumber;
    data['manzil_number'] = manzilNumber;
    data['text'] = text;
    data['text_indopak'] = textIndoPak;
    data['text_uthmani_tajweed'] = textUthmaniTajweed;
    data['audio_url'] = audioUrl;
    data['surah_name_translated'] = surahNameTranslated;
    data['surah_name_arabic'] = surahNameArabic;
    data['surah_name_simple'] = surahNameSimple;
    return data;
  }
}
