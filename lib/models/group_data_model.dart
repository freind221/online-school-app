import 'dart:convert';

import '../CreateGroup.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupDataModel {
  final int accessLevel;
  final String category;
  final String image;
  final String name;
  final String ownerId;
  final String pin;
  final String numberOfMembers;
  GroupDataModel({
    required this.accessLevel,
    required this.category,
    required this.image,
    required this.name,
    required this.ownerId,
    required this.pin,
    required this.numberOfMembers,
  });

  factory GroupDataModel.fromRequest(Request req) {
    return GroupDataModel(
      accessLevel: req.accessLevel,
      category: req.category,
      image: req.imgUrl,
      name: req.name,
      ownerId: req.uid,
      pin: req.pin,
      numberOfMembers: "0",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessLevel': accessLevel,
      'category': category,
      'img': image,
      'name': name,
      'ownerId': ownerId,
      'pin': pin,
      'numberOfMembers': numberOfMembers,
    };
  }

  factory GroupDataModel.fromMap(Map<String, dynamic> map) {
    return GroupDataModel(
      accessLevel: (map['accessLevel'] ?? 0) as int,
      category: (map['category'] ?? "") as String,
      image: (map['img'] ?? "") as String,
      name: (map['name'] ?? "") as String,
      ownerId: (map['ownerId'] ?? "") as String,
      pin: (map['pin'] ?? "") as String,
      numberOfMembers: (map['numberOfMembers'] ?? '0') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupDataModel.fromJson(String source) =>
      GroupDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
