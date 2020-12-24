import 'dart:convert';
import 'package:flutter_task/models/users_data.dart';
import 'package:flutter_task/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<UsersData> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Constants.BASE_URL);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = UsersData.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}