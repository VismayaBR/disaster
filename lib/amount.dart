import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'constant.dart';

class Amount extends StatefulWidget {
  const Amount({super.key});

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  Future<dynamic> getData() async {
    var responase = await post(Uri.parse('${Con.url}view-amount.php'));
    print(responase.body);
    return jsonDecode(responase.body);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
             return ListView.separated(
          itemCount: snapshot.data.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data[index]['amount']),
              subtitle: Text(snapshot.data[index]['date']),
              trailing: Text('Total Donation  :  ${snapshot.data[index]['total']}'),
      
            );
          },
          
        );
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Center(
              child: Text('No Amount Added'),
            );
          }
         
        },
       
      ),
    );
  }
}