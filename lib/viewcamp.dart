import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'constant.dart';

class ViewCamp extends StatefulWidget {
  ViewCamp({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  State<ViewCamp> createState() => _ViewCampState();
}

class _ViewCampState extends State<ViewCamp> {
  Future<dynamic> getData() async {
    var data = {
      "id": widget.id,
    };
    // print(data);
    var response = await post(Uri.parse('${Con.url}view-camp.php'), body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: getData(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snap.data[0]['message'] == 'failed') {
                  return Center(child: Text('No camp added'));
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(snap.data![0]['camp_name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Text(snap.data![0]['area'],style: TextStyle(fontSize: 15)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_pin),
                            Text(snap.data![0]['land_mark'],style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email),
                          Text(snap.data![0]['email'],style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone),
                            Text(snap.data![0]['mobile'],style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
          height: 250,
          width: 300,
          color: Color(0xFF5F9EA0),
        ),
      ),
    );
  }
}
