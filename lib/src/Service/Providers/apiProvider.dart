import 'package:flutter/material.dart';
import 'package:spacex/src/Model/apiModel.dart';
import 'package:spacex/src/Service/WebService/webService.dart';

class ApiProvider with ChangeNotifier {
  //model of Api Model
  ApiModel apiModel;
  //a variable to check loading
  bool loading = true;
  //a variable to check error
  bool error = false;

  getDataFromApi() async {
    await WebService().getData().then((value) {
      if (value != null) {
        //if getting data is succeed
        apiModel = value;
        loading = false;
      } else {
        //if getting data is failed
        loading = false;
        error = true;
      }
    });
    notifyListeners();
  }
}
