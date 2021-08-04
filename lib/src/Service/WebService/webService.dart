import 'dart:convert';
import 'package:spacex/src/Model/apiModel.dart';
import 'package:http/http.dart';

class WebService {
  //model of Api Model
  ApiModel apiModel;
  //to save url authority
  final String authority = "api.spacexdata.com";
  //to save url unencodedPath
  final String unencodedPath = "v4/launches/latest";

  //to get datas from api
  Future getData() async {
    try {
      Response response = await get(Uri.https(authority, unencodedPath));
      //if getting data is succeed
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        apiModel = ApiModel.fromJson(decodeJson);
        return apiModel;
      } else {
        print("API Error");
        return;
      }
    } catch (e) {
      print(e);
      print("API Fatal Error");
      return;
    }
  }
}
