// To parse this JSON data, do
//
//     final dataModel = dataModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DataModel {
  DataModel({
    required this.data,
  });

  List<Datum> data;

  factory DataModel.fromJson(String str) => DataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    required this.pName,
    required this.pId,
    required this.pCost,
    required this.pAvailability,
    required this.pDetails,
    required this.pCategory,
  });

  String pName;
  int pId;
  int pCost;
  int pAvailability;
  String pDetails;
  String pCategory;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    pName: json["p_name"],
    pId: json["p_id"],
    pCost: json["p_cost"],
    pAvailability: json["p_availability"],
    pDetails: json["p_details"],
    pCategory: json["p_category"],
  );

  Map<String, dynamic> toMap() => {
    "p_name": pName,
    "p_id": pId,
    "p_cost": pCost,
    "p_availability": pAvailability,
    "p_details": pDetails == null ? null : pDetails,
    "p_category": pCategory == null ? null : pCategory,
  };
}
