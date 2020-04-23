
import 'dart:convert';

import 'package:app/model.dart';
import 'package:http/http.dart' as http;

//Postman Covid19 API
class Covid19Api{

  final String baseRoute = "https://api.covid19api.com";

  Map<String, String> get defaultHeaders => {
    "Content-Type": "application/json"
  };

  Future<List<CountryHeader>> getCountries() async{
    final response = await http.get(
      baseRoute + "/countries",
      headers: defaultHeaders
    );
    List<dynamic> aux = json.decode(response.body);
    List<CountryHeader> data = List();
    aux.forEach((element) => data.add(CountryHeader.fromJson(element)));
    return data;
  }

  ///live/country/brazil/status/confirmed/date/2020-04-21T13:13:30Z
  Future<CountryInfo> getCountryInfo({String country}) async{
    DateTime nowTime = DateTime.now();
    DateTime auxTime = DateTime(nowTime.year, nowTime.month, nowTime.day - 1);
    String dateTime = auxTime.toIso8601String();
    dateTime = dateTime.substring(0, dateTime.length - 4);
    dateTime = dateTime + "Z";
    print(dateTime);
    final response = await http.get(
      baseRoute + "/live/country/$country/status/confirmed/date/$dateTime",
      headers: defaultHeaders
    );
    List<dynamic> aux = json.decode(response.body);
    return CountryInfo.fromJson(aux[0]);
  }
}