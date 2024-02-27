import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Hadeeth {
  int id;
  int chapterId;
  int bookId;
  int idInBook;
  String hadeeth;
  String chapterAr;
  String chapterEn;
  String matinAr;
  String matinEn;
  String sanadAr;
  String sanadEn;
  String titlesArGpt3;
  String titleArGpt4;
  String titleEn;

  // Convert the object to a map for serialization

  Hadeeth({
    required this.id,
    required this.chapterId,
    required this.bookId,
    required this.idInBook,
    required this.hadeeth,
    required this.chapterAr,
    required this.chapterEn,
    required this.matinAr,
    required this.matinEn,
    required this.sanadAr,
    required this.sanadEn,
    required this.titlesArGpt3,
    required this.titleArGpt4,
    required this.titleEn,
  });

  factory Hadeeth.fromJson(Map<String, dynamic> json) {
    return Hadeeth(
      id: json['id'],
      chapterId: json['chapterId'],
      bookId: json['bookId'],
      idInBook: json['idInBook'],
      hadeeth: json['hadeeth'],
      chapterAr: json['chapter_ar'],
      chapterEn: json['chapter_en'],
      matinAr: json['matin_ar'],
      matinEn: json['matin_en'],
      sanadAr: json['sanad_ar'],
      sanadEn: json['sanad_en'],
      titlesArGpt3: json['titles_ar_gpt3'],
      titleArGpt4: json['title_ar_gpt4'],
      titleEn: json['title_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapterId': chapterId,
      'bookId': bookId,
      'idInBook': idInBook,
      'hadeeth': hadeeth,
      'chapter_ar': chapterAr,
      'chapter_en': chapterEn,
      'matin_ar': matinAr,
      'matin_en': matinEn,
      'sanad_ar': sanadAr,
      'sanad_en': sanadEn,
      'titles_ar_gpt3': titlesArGpt3,
      'title_ar_gpt4': titleArGpt4,
      'title_en': titleEn,
    };
  }
}

class AhadeethProvider {
  List<Hadeeth> _guitarList = [];

  List<Hadeeth> get guitarList => _guitarList;
  int lastIdInBook = 0; // to keep track of the last loaded item idInBook

  Future<List<Hadeeth>> fetchAhadeeth(
      {required int chapterId, lastIdInBook = 0}) async {
    String url =
        "https://whilelearn.onrender.com/getAhadeeth?lastHadeethIdInBook=$lastIdInBook&chapter_id=$chapterId";
    // await Future.delayed(Duration(seconds: 5),(){});
    print(url);
    final response =
        await http.get(Uri.parse(url), headers: {'accept': 'application/json'});

    // print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
      _guitarList
          .addAll(jsonData.map((item) => Hadeeth.fromJson(item)).toList());

      // Update the last item idInBook
      if (_guitarList.isNotEmpty) {
        lastIdInBook = _guitarList.last.idInBook;
      }
      return _guitarList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Hadeeth>> searchAhadeeth(
      {required String query, number = 5, bool isRelevance = false}) async {
    String url =
        "https://whilelearn.onrender.com/searchAhadeeth?query=$query&number=$number&is_mmr=$isRelevance";
    print(url);
    final response =
        await http.get(Uri.parse(url), headers: {'accept': 'application/json'});

    // print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
      _guitarList
          .addAll(jsonData.map((item) => Hadeeth.fromJson(item)).toList());

      // Update the last item idInBook
      if (_guitarList.isNotEmpty) {
        lastIdInBook = _guitarList.last.idInBook;
      }
      return _guitarList;
    } else {
      return [];
    }
  }
}
