
import 'dart:convert';

import 'package:app/model.dart';
import 'package:http/http.dart' as http;

//Postman Covid19 API
class Covid19Api{

  final String baseRoute = "https://api.covid19api.com";

  Map<String, String> get defaultHeaders => {
    "Content-Type": "application/json"
  };

  Future<List<CountryHeader>> getCountryHeaders() async{
    final response = await http.get(
      baseRoute + "/countries",
      headers: defaultHeaders
    );
    List<Map<String, dynamic>> aux = json.decode(response.body) as List<Map<String, dynamic>>;
    List<CountryHeader> data = List();
    aux.forEach((element) => data.add(CountryHeader.fromJson(element)));
    return data;
  }

  ///live/country/brazil/status/confirmed/date/2020-04-21T13:13:30Z
  Future<CountryInfo> getCountryInfo({String country}) async{
    DateTime dateTime = DateTime.now();
    final response = await http.get(
      baseRoute + "/live/country/$country/status/confirmed/date/${dateTime.toString()}",
      headers: defaultHeaders
    );
    return CountryInfo.fromJson(json.decode(response.body) as Map<String, dynamic>);
  }
}