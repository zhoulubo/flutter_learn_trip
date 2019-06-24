import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_learn/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      var utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Faild to load url');
    }
  }
}
