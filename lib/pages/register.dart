import 'dart:convert';
import 'dart:math';
import 'dart:developer' hide log;
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/req/customer_register_post_req.dart';
import 'package:flutter_application_1/response/customer_register_post_res.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String text = '';
  var _userCCtr = TextEditingController();
  var _passCCtr = TextEditingController();
  var _passwordConfirmCtr = TextEditingController();
  var _emailCtr = TextEditingController();
  var _phoneCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register New")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  "ชื่อ-นามสกุล ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _userCCtr,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: ("ชื่อ-นามสกุล"),
                    labelText: 'ชื่อ-นามสกุล',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "หมายเลขโทรศัพท์ ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _phoneCtr,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: ("หมายเลขโทรศัพท์"),
                    labelText: 'หมายเลขโทรศัพท์',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "อีเมล์ ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailCtr,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: ("อีเมล์"),
                    labelText: 'อีเมล์',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  "รหัสผ่าน ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passCCtr,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: ("รหัสผ่าน"),
                    labelText: 'รหัสผ่าน',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  "ยืนยันรหัสผ่าน ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordConfirmCtr,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: ("ยืนยันรหัสผ่าน"),
                    labelText: 'ยืนยันรหัสผ่าน',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: createID,
                          child: const Text("Register"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(onPressed: login, child: const Text("Login")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    Navigator.pop(context);
  }

  void createID() {
    if (_userCCtr.text.isEmpty ||
        _phoneCtr.text.isEmpty ||
        _emailCtr.text.isEmpty ||
        _passCCtr.text.isEmpty ||
        _passwordConfirmCtr.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบทุกช่อง")),
      );
    } else if (_passCCtr.text != _passwordConfirmCtr.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("รหัสผ่านไม่ตรงกัน")));
    } else {
      CustomerRegisterPostResponse
      customerRegisterPostResponse = CustomerRegisterPostResponse(
        fullname: _userCCtr.text,
        phone: _phoneCtr.text,
        email: _emailCtr.text,
        image:
            'http://202.28.34.197:8888/contents/4a00cead-afb3-45db-a37a-c8bebe08fe0d.png',
        password: _passCCtr.text,
      );

      http
          .post(
            Uri.parse("http://10.160.87.99:3000/customers"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: customerRegisterPostResponseToJson(
              customerRegisterPostResponse,
            ),
          )
          .then((response) {
            if (response.statusCode == 200 || response.statusCode == 201) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("สมัครสมาชิกสำเร็จ!")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("เกิดข้อผิดพลาด: ${response.body}")),
              );
            }
          })
          .catchError((error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("เกิดข้อผิดพลาด: $error")));
          });
    }
  }
}
