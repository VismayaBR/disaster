import 'dart:convert';

// import 'package:disaster/needs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';
import 'needs.dart';

class Requirement extends StatefulWidget {
  const Requirement({Key? key}) : super(key: key);

  @override
  State<Requirement> createState() => _RequirementState();
}

class _RequirementState extends State<Requirement> {
  Future<dynamic> getData() async {
    var response = await get(Uri.parse('${Con.url}view-categories.php'));
    var res = jsonDecode(response.body);
    print('res>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$res');
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(backgroundColor: Color(0xFF5F9EA0),
       actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: InkWell(
               onTap:(){
                 Fluttertoast.showToast(msg: 'Logout successfully...');
                 SystemNavigator.pop();
               },
               child: Icon(Icons.logout)),
         )
       ],
        ),
      body: Column(
        children: [
          FutureBuilder(

              future: getData(),
              builder: (context,snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) {
                               return Needs(id: snapshot.data![index]['category_id']);
                             },));
                          },
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(snapshot.data![index]['category']),
                              // trailing: Text(snapshot.data![index]['quantity']),
                              // trailing: Text('date'),
                            ),
                          ),
                        );
                      },

                    ),
                  );
                }
                else if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                else{
                  return Center(child: Text('No Categories Added'));
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
