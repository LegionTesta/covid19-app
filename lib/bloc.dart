

import 'package:app/covid_api.dart';
import 'package:app/model.dart';
import 'package:bloc/bloc.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState>{

  Covid19Api api = Covid19Api();
  List<CountryHeader> countries = List();
  CountryInfo countryInfo;

  @override
  InfoState get initialState => LoadingCountriesState();

  @override
  Stream<InfoState> mapEventToState(InfoEvent event) async*{
    if(event is LoadCountriesEvent){
      yield LoadingCountriesState();
      countries = await api.getCountries();
      yield CountriesLoadedState(countries: countries);
    }
    if(event is LoadCountryEvent){
      yield LoadingCountryInfoState();
      countryInfo = await api.getCountryInfo(country: event.country.Slug);
      yield CountryInfoLoadedState(countries: countries, countryInfo: countryInfo);
    }
  }
}

abstract class InfoEvent{}

class LoadCountryEvent extends InfoEvent{
  final CountryHeader country;
  LoadCountryEvent({this.country});
}

class LoadCountriesEvent extends InfoEvent{}

abstract class InfoState{}

class LoadingCountryInfoState extends InfoState{

  final List<CountryHeader> countries;

  LoadingCountryInfoState({this.countries});
}

class LoadingCountriesState extends InfoState{}

class CountryInfoLoadedState extends InfoState{

  final List<CountryHeader> countries;
  final CountryInfo countryInfo;

  CountryInfoLoadedState({this.countries, this.countryInfo});
}

class CountriesLoadedState extends InfoState{

  final List<CountryHeader> countries;

  CountriesLoadedState({this.countries});
}