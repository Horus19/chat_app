// To parse this JSON data, do
//
//     final changePasswordDto = changePasswordDtoFromJson(jsonString);

import 'dart:convert';

class ChangePasswordDto {
  String? password;
  String? newPassword;

  ChangePasswordDto({
    this.password,
    this.newPassword,
  });

  ChangePasswordDto copyWith({
    String? password,
    String? newPassword,
  }) =>
      ChangePasswordDto(
        password: password ?? this.password,
        newPassword: newPassword ?? this.newPassword,
      );

  factory ChangePasswordDto.fromRawJson(String str) =>
      ChangePasswordDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordDto.fromJson(Map<String, dynamic> json) =>
      ChangePasswordDto(
        password: json["password"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "newPassword": newPassword,
      };
}
