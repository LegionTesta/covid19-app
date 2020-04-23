// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryInfo _$CountryInfoFromJson(Map<String, dynamic> json) {
  return CountryInfo(
    Country: json['Country'] as String,
    CountryCode: json['CountryCode'] as String,
    Confirmed: json['Confirmed'] as int,
    Deaths: json['Deaths'] as int,
    Recovered: json['Recovered'] as int,
    Active: json['Active'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CountryInfoToJson(CountryInfo instance) =>
    <String, dynamic>{
      'Country': instance.Country,
      'CountryCode': instance.CountryCode,
      'Confirmed': instance.Confirmed,
      'Deaths': instance.Deaths,
      'Recovered': instance.Recovered,
      'Active': instance.Active,
      'message': instance.message,
    };

CountryHeader _$CountryHeaderFromJson(Map<String, dynamic> json) {
  return CountryHeader(
    Country: json['Country'] as String,
    Slug: json['Slug'] as String,
    ISO2: json['ISO2'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CountryHeaderToJson(CountryHeader instance) =>
    <String, dynamic>{
      'Country': instance.Country,
      'Slug': instance.Slug,
      'ISO2': instance.ISO2,
      'message': instance.message,
    };
