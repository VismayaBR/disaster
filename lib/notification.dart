import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'constant.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  Future<dynamic> getData() async {
    var response = await get(Uri.parse('${Con.url}view-notification.php'));
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF5F9EA0),actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap:(){
              Fluttertoast.showToast(msg: 'Logout');
              SystemNavigator.pop();
            },
            child: Icon(Icons.logout)),
      )],),
      body:  FutureBuilder(

          future: getData(),
          builder: (context,snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['title']),
                    subtitle: Text(snapshot.data![index]['content']),
                    // trailing: Text('date'),
                  );
                },

              );
            }
            else if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return Center(child: Text('No Notifications'));
            }

          }
      ),
    );
  }
}
