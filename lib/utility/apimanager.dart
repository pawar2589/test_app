import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_app/utility/logger.dart';

class apimanager {
  Client client = Client();
  getapi(var request, String uri) async {
    var url = Uri.parse(uri);
    url = url.replace(queryParameters: request);
    loger.i("url link $url");
    Response responce = await client.get(url);
    loger.i(responce.statusCode);
    if (responce.statusCode == 200) {
      return await jsonDecode(responce.body);
    }
  }
}