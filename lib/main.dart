import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mysql1/utils/constants.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  final _uhid = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  Future sendData(String uhid, String username, String password) async {
    try {
      var url = "http://192.168.2.119/flutter/login_flutter/db_insert.php";

      final response = await http.post(Uri.parse(url),
          body: {"uhid": uhid, "username": username, "password": password});

      var data = json.decode(response.body);

      // print(response.body);
      print(data.toString());

      // var res = jsonDecode(source)
      // var res = await json.decode(json.encode(response.body));

/*       if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
 */
    } catch (e) {
      print('In Catch block');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Athulya Senior Care'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          // padding: const EdgeInsets.all(24),
/*           decoration: BoxDecoration(
              // border: Border.all(color: secondaryColor),
              // borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
 */
          child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Login Form',
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: TextFormField(
                        controller: _uhid,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter UHid'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "UHid cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: secondaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: _username,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter password'),
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Please enter a valid password";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final str1 = _uhid.text;
                            final str2 = _username.text;
                            final str3 = _password.text;

/*                             _uhid.clear();
                            _username.clear();
                            _password.clear();
 */
                            sendData(str1, str2, str3);
                            print(str1);
                            print(str2);
                            print(str3);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Data Submitted')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            minimumSize: const Size.fromHeight(50)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
