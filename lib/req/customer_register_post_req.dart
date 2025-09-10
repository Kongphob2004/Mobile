// To parse this JSON data, do
//
//     final customerLoginPostRequest = customerLoginPostRequestFromJson(jsonString);

import 'dart:convert';

CustomerRegisterPostRequest customerRegisterPostRequestFromJson(String str) =>
    CustomerRegisterPostRequest.fromJson(json.decode(str));

String customerRegisterPostRequestToJson(CustomerRegisterPostRequest data) =>
    json.encode(data.toJson());

class CustomerRegisterPostRequest {
  String phone;
  String password;
  String fullname;
  String email;
  String image;

  CustomerRegisterPostRequest({
    required this.phone,
    required this.password,
    required this.fullname,
    required this.email,
    required this.image,
  });

  factory CustomerRegisterPostRequest.fromJson(Map<String, dynamic> json) =>
      CustomerRegisterPostRequest(
        phone: json["phone"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
      };
}