import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  Future<List> getData() async {
    Uri myUrl = Uri.parse('https://jsonplaceholder.typicode.com/users');
    http.Response response = await http.get(myUrl);
    return json.decode(response.body);
  }

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  var myHome = home();
  TextEditingController _userIdController = TextEditingController();
  int userId = 0; String userName = ''; String userEmail = '';
  String userStreet = ''; String userSuite = ''; String userCity = '';

  void getUserInfo() async {
    List data = await myHome.getData();
      int index = int.parse(_userIdController.text) - 1 ;
     setState(() {
       userId = data[index]['id'];
       userName = data[index]['username'];
       userEmail = data[index]['email'];
       userStreet = data[index]['address']['street'];
       userSuite = data[index]['address']['suite'];
       userCity = data[index]['address']['city'];
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Data'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 15),
              child: TextField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'User ID',
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                    hintText: 'Enter the user ID from 1 to 10.',
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: getUserInfo, child: const Text('Submit'),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple.shade500)),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Padding(
              padding: const EdgeInsets.only(left: 65.0, top: 8),
              child: Row(
                children: [
                  const Center(child: Text('User ID: ',style: TextStyle(color: Colors.grey,fontSize: 14.0),)),
                  Center(child: Text('$userId',style: const TextStyle(fontSize: 16.0),)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 65.0, top: 8),
              child: Row(
                children: [
                  const Center(child: Text('User Name: ',style: TextStyle(color: Colors.grey,fontSize: 14.0),)),
                  Center(child: Text('$userName',style: TextStyle(fontSize: 16.0),)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 65.0, top: 8),
              child: Row(
                children: [
                  const Center(child: Text('Email: ',style: TextStyle(color: Colors.grey,fontSize: 14.0),)),
                  Center(child: Text('$userEmail',style: TextStyle(fontSize: 16.0))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 65.0, top: 8),
              child: Row(
                children: [
                  const Center(child: Text('Address: ',style: TextStyle(color: Colors.grey,fontSize: 14.0),)),
                  Center(child: Text('$userStreet,\n$userSuite,\n$userCity',style: TextStyle(fontSize: 16.0))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
