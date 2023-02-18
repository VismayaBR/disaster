import 'package:disaster/welcome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'constant.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var user = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var password = TextEditingController();
  Future<void> getData() async {
    var data = {
      "user": user.text,

      "email":email.text,
      "mobile": mobile.text,
      "password":password.text
    };
    print('data>>>>>>>>>>>>>>>>$data');
    var response = await post(Uri.parse('${Con.url}register.php'),body: data);

    print(response.body);
    Fluttertoast.showToast(msg: 'Successfully Registered...');
    Navigator.push(context as BuildContext, MaterialPageRoute(
      builder: (context) {
        return LoginPage();
      },
    ));  }
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
              padding: const EdgeInsets.only(top: 1,right: 28,left: 28,bottom: 10),
              child: TextFormField(
                controller: user,
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
              padding: const EdgeInsets.only(top: 1,right: 28,left: 28,bottom: 10),
              child: TextFormField(
                controller:mobile,

                decoration: InputDecoration(
                  hintText: 'mobile',
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
              padding: const EdgeInsets.only(top: 1,right: 28,left: 28,bottom: 10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'email',
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
                child: Center(child: Text('Register')),
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
