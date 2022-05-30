import 'dart:async';

import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<dynamic> httpGetRequest(
      {Map<String, dynamic>? queryParameters}) async {
    var client = http.Client();

    try {
      var header = {
        'accept': 'application/json',
      };

      final response = await client
          .get(Uri.http('192.168.50.4:3000', '/push', queryParameters),
              headers: header)
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'error';
      }
    } on TimeoutException catch (_) {
      return 'error';
    } catch (e) {
      return 'error';
    } finally {
      client.close();
    }
  }
}
