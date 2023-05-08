import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    this.id,
    this.email,
    this.isActivate,
    this.token,
    this.roles,
    this.message,
  });

  bool ok;
  String? id;
  String? email;
  bool? isActivate;
  List<String>? roles;
  String? token;
  String? message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        id: json["id"],
        email: json["email"],
        isActivate: json["isActivate"],
        token: json["token"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "id": id,
        "email": email,
        "isActivate": isActivate,
        "token": token,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "message": message,
      };
}
