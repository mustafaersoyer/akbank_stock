// To parse this JSON data, do
//
//     final stock = stockFromJson(jsonString);

import 'dart:convert';

Stock stockFromJson(String str) => Stock.fromJson(json.decode(str));

String stockToJson(Stock data) => json.encode(data.toJson());

class Stock {
  Stock({
    this.oneDayList,
    this.oneWeekList,
    this.oneMounthList,
    this.treeMounthList,
    this.oneYearList,
    this.fiveYearList,
    this.code,
    this.symbol,
  });

  List<Data> oneDayList;
  List<Data> oneWeekList;
  List<Data> oneMounthList;
  List<Data> treeMounthList;
  List<Data> oneYearList;
  List<Data> fiveYearList;
  String code;
  String symbol;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        oneDayList: List<Data>.from(json["1G"].map((x) => Data.fromJson(x))),
        oneWeekList: List<Data>.from(json["1H"].map((x) => Data.fromJson(x))),
        oneMounthList: List<Data>.from(json["1A"].map((x) => Data.fromJson(x))),
        treeMounthList: List<Data>.from(json["3A"].map((x) => Data.fromJson(x))),
        oneYearList: List<Data>.from(json["1Y"].map((x) => Data.fromJson(x))),
        fiveYearList: List<Data>.from(json["5Y"].map((x) => Data.fromJson(x))),
        code: json["Code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "1G": List<dynamic>.from(oneDayList.map((x) => x.toJson())),
        "1H": List<dynamic>.from(oneWeekList.map((x) => x.toJson())),
        "1A": List<dynamic>.from(oneMounthList.map((x) => x.toJson())),
        "3A": List<dynamic>.from(treeMounthList.map((x) => x.toJson())),
        "1Y": List<dynamic>.from(oneYearList.map((x) => x.toJson())),
        "5Y": List<dynamic>.from(fiveYearList.map((x) => x.toJson())),
        "Code": code,
        "symbol": symbol,
      };
}

class Data {
  Data({
    this.dateEpoch,
    this.currentPrice,
    this.o,
    this.h,
    this.l,
    this.v,
  });

  int dateEpoch;
  double currentPrice;
  double o;
  double h;
  double l;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dateEpoch: json["d"],
        currentPrice: json["c"].toDouble(),
        o: json["o"] == null ? null : json["o"].toDouble(),
        h: json["h"] == null ? null : json["h"].toDouble(),
        l: json["l"] == null ? null : json["l"].toDouble(),
        v: json["v"] == null ? null : json["v"],
      );

  Map<String, dynamic> toJson() => {
        "d": dateEpoch,
        "c": currentPrice,
        "o": o == null ? null : o,
        "h": h == null ? null : h,
        "l": l == null ? null : l,
        "v": v == null ? null : v,
      };
}
