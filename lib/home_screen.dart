
import 'package:app/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  InfoBloc infoBloc = InfoBloc();
  CountryHeader selectedCountry;

  @override
  void initState() {
    infoBloc.add(LoadCountriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("COVID19 App")
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: BlocBuilder<InfoBloc, InfoState>(
                bloc: infoBloc,
                builder: (context, state){
                  if(state is LoadingCountriesState)
                    return CircularProgressIndicator();
                  if(state is CountriesLoadedState)
                    return buildCountriesList(context, state.countries);
                  if(state is LoadingCountryInfoState){
                    return Column(
                      children: <Widget>[
                        buildCountriesList(context, state.countries),
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                  if(state is CountryInfoLoadedState){
                    return Column(
                      children: <Widget>[
                       buildCountriesList(context, state.countries),
                       buildCountryInfo(context, state.countryInfo)
                      ],
                    );
                  }
                  return Text("a");
                },
              ),
            )
          ),
        ),
      ),
    );
  }
  
  Widget buildCountryInfo(BuildContext context, CountryInfo countryInfo){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            child: Row(
              children: <Widget>[
                infoCard("Total de casos:", countryInfo.Confirmed),
              ],
            )
          ),
          Container(
            height: 120,
            child: Row(
              children: <Widget>[
                infoCard("Ativos:", countryInfo.Active),
                infoCard("Mortes:", countryInfo.Deaths),
                infoCard("Curados:", countryInfo.Recovered),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCountriesList(BuildContext context, List<CountryHeader> countries){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey
        )
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: SizedBox(),
        value: selectedCountry ?? countries[0],
        items: countries.map<DropdownMenuItem<CountryHeader>>((CountryHeader value) {
          return DropdownMenuItem<CountryHeader>(
            value: value,
            child: Text(value.Country),
          );
        }).toList(),
        onChanged: (CountryHeader value){
          selectedCountry = value;
          infoBloc.add(LoadCountryEvent(country: selectedCountry.Slug));
        },
      ),
    );
  }
  
  Widget infoCard(String title, int value){
    return Expanded(
      child: Card(
        child: ListTile(
          dense: true,
          title: Text(title),
          subtitle: Text(value.toString()),
        ),
      ),
    );
  }
}
