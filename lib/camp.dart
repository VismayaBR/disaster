import 'dart:convert';

import 'package:disaster/viewcamp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

class Camp extends StatefulWidget {
  const Camp({Key? key}) : super(key: key);

  @override
  State<Camp> createState() => _CampState();
}

class _CampState extends State<Camp> {
  Future<dynamic> getData() async {
    var res = await get(Uri.parse('${Con.url}camp-list.php'));
    print(res.body);
    return jsonDecode(res.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF5F9EA0),
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap:(){
              Fluttertoast.showToast(msg: 'Logout');
              SystemNavigator.pop();
            },
            child: Icon(Icons.logout)),
      )],),
      body: Column(
        children: [
          FutureBuilder(
              future: getData(),
              builder: (context,snapshot) {
                if(!snapshot.hasData){
                  return Center(child: const CircularProgressIndicator());
                }
                else if(snapshot.data[0]['message']=='failed') {
                  return Center(child: Text('No camp added'));
                }
                else{

                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },

                      itemCount: snapshot.data.length,

                      itemBuilder: (context, index) {

                        return  ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              // print(snapshot.data![index]['camp_id']);
                              return ViewCamp(id: snapshot.data![index]['camp_id']);
                            },));
                          },
                          title: Text(snapshot.data![index]['camp_name']),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(snapshot.data![index]['area']),
                          ),
                          // trailing: Text(snapshot.data![index]['date']),
                        );
                      },

                    ),
                  );
                }

              }
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: InkWell(
                 onTap: (){
                   showDialog(
                     context: context,
                     builder: (ctx) => AlertDialog(
                       title: const Text("Donate Here"),
                       content: SizedBox(
                         height: 60,
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
                               children: [
                                 Text('Gpay  :          1234567890'),
                               ],
                             ),
         
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text('Bank A/C  :  SBI000123456790'),
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text('IFSC  :           SBI0000XX'),
                               ],
                             ),
         
                           ],
                         ),
                       ),
         
                       actions: <Widget>[
                         TextButton(
                           onPressed: () {
                             Navigator.of(ctx).pop();
                           },
                           child: Container(
                             color: Colors.teal,
                             padding: const EdgeInsets.all(14),
                             child: const Text("OK",style: TextStyle(color: Colors.black),),
                           ),
                         ),
                       ],
                     ),
                   );
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(50),
                     color: Colors.teal,
                   ),
                   height: 35,width: 120,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('Donate  '),
                       Icon(Icons.account_balance)
                     ],
                   ),
         
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: InkWell(
                 onTap: (){
         
         
         
                   print('object');
                   launchUrl(Uri.parse('tel:1234567890'),
                   );
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(50),
                     color: Colors.teal,
                   ),
                   height: 35,width: 120,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('Contact  '),
                       Icon(Icons.phone)
                     ],
                   ),
         
                 ),
               ),
             ),
           ],
         )
        ],
      ),
    );
  }
}
