import 'package:front_test/api/apiRequest.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FcmTestPage extends StatefulWidget {
  const FcmTestPage({Key? key}) : super(key: key);

  @override
  State<FcmTestPage> createState() => _FcmTestPageState();
}

class _FcmTestPageState extends State<FcmTestPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String? token;

  @override
  void initState() {
    loadToken();
    super.initState();
  }

  loadToken() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final SharedPreferences prefs = await _prefs;
    token = prefs.getString('token');
    print('token : $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FCM TEST'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'title',
              ),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                hintText: 'content',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var parameter = {
                  'title': titleController.text,
                  'content': contentController.text,
                  'token': token,
                };

                await ApiRequest.httpGetRequest(queryParameters: parameter);
              },
              child: Text('알림받기'),
            ),
          ],
        ),
      ),
    );
  }
}
