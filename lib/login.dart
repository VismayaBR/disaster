import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'bottomnavigation.dart';
import 'constant.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = TextEditingController();
  var password = TextEditingController();
  Future<void> getData() async {
    var data = {
      "username":username.text,
      "password":password.text,
    };

    var response = await post(Uri.parse('${Con.url}login.php'),body: data);
    var res = jsonDecode(response.body);
    print(res);

    if(response.statusCode==200){
      if(res['message']=='User Successfully LoggedIn'){

        if(res['type']=='user'){
          Fluttertoast.showToast(msg: 'Successfully Login...');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return MyNavigationBar();
            },
          ));
        }


      }
      else{
        Fluttertoast.showToast(msg: 'Invalid username or password');

      }

    }
    else {
      Fluttertoast.showToast(msg: 'Something went wrong!');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign In'),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/log.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22,right: 28,left: 28,bottom: 10),
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Color(0xFF96DED1),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28,left: 28,bottom: 10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color(0xFF96DED1),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
               getData();
              },
              child: Container(
                child: Center(child: Text('Login')),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF5F9EA0),
                ),
                height: 50,
                width: 300,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
