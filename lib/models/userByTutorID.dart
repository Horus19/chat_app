// To parse this JSON data, do
//
//     final userByTutorId = userByTutorIdFromJson(jsonString);

import 'dart:convert';

class UserByTutorId {
  String? id;
  String? email;
  String? fullName;
  bool? isActivate;
  List<String>? roles;
  dynamic validationToken;
  bool? isBlocked;

  UserByTutorId({
    this.id,
    this.email,
    this.fullName,
    this.isActivate,
    this.roles,
    this.validationToken,
    this.isBlocked,
  });

  UserByTutorId copyWith({
    String? id,
    String? email,
    String? fullName,
    bool? isActivate,
    List<String>? roles,
    dynamic validationToken,
    bool? isBlocked,
  }) =>
      UserByTutorId(
        id: id ?? this.id,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        isActivate: isActivate ?? this.isActivate,
        roles: roles ?? this.roles,
        validationToken: validationToken ?? this.validationToken,
        isBlocked: isBlocked ?? this.isBlocked,
      );

  factory UserByTutorId.fromRawJson(String str) => UserByTutorId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserByTutorId.fromJson(Map<String, dynamic> json) => UserByTutorId(
    id: json["id"],
    email: json["email"],
    fullName: json["fullName"],
    isActivate: json["isActivate"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    validationToken: json["validationToken"],
    isBlocked: json["isBlocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "fullName": fullName,
    "isActivate": isActivate,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "validationToken": validationToken,
    "isBlocked": isBlocked,
  };
}
