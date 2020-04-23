
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class CountryInfo{

  final String Country;
  final String CountryCode;
  final int Confirmed;
  final int Deaths;
  final int Recovered;
  final int Active;
  final String message;

  CountryInfo({this.Country, this.CountryCode, this.Confirmed, this.Deaths,
    this.Recovered, this.Active, this.message});

  factory CountryInfo.fromJson(Map<String, dynamic> json) => _$CountryInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CountryInfoToJson(this);
}

@JsonSerializable()
class CountryHeader{

  final String Country;
  final String Slug;
  final String ISO2;
  final String message;

  CountryHeader({this.Country, this.Slug, this.ISO2, this.message});

  factory CountryHeader.fromJson(Map<String, dynamic> json) => _$CountryHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$CountryHeaderToJson(this);
}