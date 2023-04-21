// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.email,
    this.password,
    this.fullName,
    this.validationToken,
    this.id,
    this.isActivate,
    this.roles,
    this.token,
    this.message,
    this.statusCode,
    this.error,
  });

  String? email;
  String? password;
  String? fullName;
  String? validationToken;
  String? id;
  bool? isActivate;
  List<String>? roles;
  String? token;
  String? message;
  int? statusCode;
  String? error;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        email: json["email"],
        password: json["password"],
        fullName: json["fullName"],
        validationToken: json["validationToken"],
        id: json["id"],
        isActivate: json["isActivate"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        token: json["token"],
        message: json["message"],
        statusCode: json["statusCode"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fullName": fullName,
        "validationToken": validationToken,
        "id": id,
        "isActivate": isActivate,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "token": token,
        "message": message,
        "statusCode": statusCode,
        "error": error,
      };
}
