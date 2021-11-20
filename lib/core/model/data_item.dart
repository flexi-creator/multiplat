import 'dart:convert';

import 'package:multiplat/core/model/history_item.dart';

// Consider the use of pub.dev/packages/json_serializable if you want code generated de/serialization

int _counter = 0;

class DataItem {
  int id;
  String title;
  String description;
  double value;
  String imageUrl;
  String bio;
  int groupColor;
  List<List<HistoryItem>> histories;

  DataItem(this.id, this.title, this.description, this.value, this.imageUrl,
      this.bio, this.groupColor, this.histories);

  static List<DataItem> fromJsonResponse(String response) {
    // print('$response');
    final json = jsonDecode(response);

    final dataItems = (json as List)
        .map(((dataItemJson) => DataItem.fromJson(dataItemJson)))
        .toList();

    return dataItems;
  }

  factory DataItem.fromJson(Map<String, dynamic> json) {
    final histories = (json['histories'] as List)
        .map(((historyTypeListJson) =>
            _historyTypeListFromJson(historyTypeListJson)))
        .toList();
    return DataItem(
        ++_counter,
        json['title'],
        json['desc'],
        json['value'].toDouble(),
        json['image'],
        json['bio'],
        int.parse(json['groupColor'], radix: 16),
        histories);
  }

  static List<HistoryItem> _historyTypeListFromJson(
      List<dynamic> typeListJson) {
    return typeListJson
        .map((historyItemJson) => HistoryItem.fromJson(historyItemJson))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": description,
        "value": value,
        "image": imageUrl,
        "bio": bio,
        "groupColor": groupColor.toRadixString(16),
        "histories": histories
      };
}
