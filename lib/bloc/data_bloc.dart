import 'dart:async';
import 'dart:convert';
import 'package:flutter_task/models/users_data.dart';
import 'package:flutter_task/utils/constants.dart';
import 'package:http/http.dart' as http;

enum DataAction {
  Fetch,
}

class DataBloc {
  List<UsersData> urlList = [];
  int counter;
  final _stateStreamController =
      StreamController<List<UsersData>>(); 
  StreamSink<List<UsersData>> get _dataSink => _stateStreamController.sink;
  Stream<List<UsersData>> get dataStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<DataAction>();
  StreamSink<DataAction> get eventSink => _eventStreamController.sink;
  Stream<DataAction> get _eventStream => _eventStreamController.stream;

  DataBloc() {
    _eventStream.listen((event) async {
      if (event == DataAction.Fetch) {
        try {
          var userData = await getData();
          _dataSink.add(userData);
        } on Exception catch (e) {
          _dataSink.addError('Something went wrong');
        }
      }
    });
  }

  Future<List<UsersData>> getData() async {
    var client = http.Client();
    try {
      var response = await client.get(Constants.BASE_URL);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        for (Map i in jsonMap) {
          urlList.add(UsersData.fromJson(i));
        }
      }
    } catch (Exception) {
      return urlList;
    }

    print(urlList.length);

    return urlList;
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
