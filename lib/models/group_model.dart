class GroupModel {

  int ?accessLevel;
  String ?category;
  String ?name;
  String ?ownerId;
  String ?pin;

  GroupModel({
    this.accessLevel,
    this.category,
    this.name,
    this.ownerId,
    this.pin,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      accessLevel: int.parse(json["accessLevel"].toString()),
      category: json["category"],
      name: json["name"],
      ownerId: json["ownerId"],
      pin: json["pin"],);
  }

}

class MembersModel {
  String ?id;

  MembersModel({
    this.id,
  });

  factory MembersModel.fromJson(Map<String, dynamic> json) {
    return MembersModel(id: json["id"],);
  }
}



