class HistoryItem {
  final int year;
  final int historicalValue;

  HistoryItem(this.year, this.historicalValue);

  Map<String, dynamic> toJson() => {
    "yr": year,
    "val": historicalValue
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(json['yr'], json['val']);
  }
}
