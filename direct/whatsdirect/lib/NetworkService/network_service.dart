import 'dart:convert';
import 'dart:io';
import 'package:direct_message/Model/quotes_api_model.dart';
import 'package:http/http.dart' as http;

class NetWorkService{
 static Future<List<dynamic>> fetchData() async{
    final response = await http.post(Uri.parse(
        "http://phpstack-165541-2007025.cloudwaysapps.com/public/api/4k-gallery/list"),
        headers: {"Api-key":"LgrAf151ebCfSzN5BlZKyByH470a42"},
        body: {"category_id": "89"});
    final jsonResponse = jsonDecode(response.body);
     return jsonResponse['data'] as List;

  }
}
