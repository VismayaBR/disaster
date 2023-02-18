import 'package:disaster/login.dart';
import 'package:disaster/signup.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('WELCOME'),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset('assets/images/fld.jpg'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              },));
            },
            child: Container(
              child: Center(child: Text('LOGIN')),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFF5F9EA0),
              ),
              height: 50,
              width: 250,

            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              },));
            },
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUp();
                },));
              },
              child: Container(
                child: Center(child: Text('SIGN UP')),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF96DED1),
                ),
                height: 50,
                width: 250,

              ),
            ),
          )
        ],
      ),
    );
  }
}
