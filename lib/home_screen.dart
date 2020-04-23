
import 'package:app/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/constants.dart';

import 'model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  InfoBloc countriesBloc = InfoBloc();
  InfoBloc countryBloc = InfoBloc();
  CountryHeader selectedCountry;

  @override
  void initState() {
    countriesBloc.add(LoadCountriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            cBackgroundColor1,
                            cBackgroundColor2
                          ]
                        )
                      ),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 150),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: Colors.grey
                            )
                        ),
                        child: BlocBuilder<InfoBloc, InfoState>(
                          bloc: countriesBloc,
                          builder: (context, state){
                            if(state is LoadingCountriesState){
                              return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 125, vertical: 5),
                                  child: CircularProgressIndicator()
                              );
                            }
                            if(state is CountriesLoadedState){
                              if(state.countries[0].message != null){
                                return Text("Ocorreu um erro na API");
                              } else {
                                return buildCountriesList(context, state.countries);
                              }
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 260,
                    child: BlocBuilder<InfoBloc, InfoState>(
                      bloc: countryBloc,
                      builder: (context, state){
                        if(state is LoadingCountryInfoState){
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: ListTile(
                              title: Text("Caso demore, selecione outro país.", textAlign: TextAlign.center,),
                              subtitle: Container(
                                margin: EdgeInsets.symmetric(horizontal: 155, vertical: 5),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                        if(state is CountryInfoLoadedState){
                          return buildCountryInfo(context, state.countryInfo);
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              )
            )
          ),
        ),
      ),
    );
  }
  
  Widget buildCountryInfo(BuildContext context, CountryInfo countryInfo){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            child: infoCard("Total de casos em ${countryInfo.Country} (${countryInfo.CountryCode})",
                countryInfo.Confirmed
            ),
          ),
          Container(
            height: 120,
            child: Row(
              children: <Widget>[
                infoCard("Ativos", countryInfo.Active, color: Colors.orange),
                infoCard("Mortes", countryInfo.Deaths, color: Colors.redAccent),
                infoCard("Curados", countryInfo.Recovered, color: Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCountriesList(BuildContext context, List<CountryHeader> countries){
    return DropdownButton(
      isExpanded: true,
      underline: SizedBox(),
      value: selectedCountry ?? countries[0],
      items: countries.map<DropdownMenuItem<CountryHeader>>((CountryHeader value) {
        return DropdownMenuItem<CountryHeader>(
          value: value,
          child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(value.Country)
          ),
        );
      }).toList(),
      onChanged: (CountryHeader value){
        selectedCountry = value;
        countryBloc.add(LoadCountryEvent(country: selectedCountry));
        setState(() {});
      },
    );
  }
  
  Widget infoCard(String title, int value, {Color color}){
    return Expanded(
      child: Card(
        elevation: 4,
        child: ListTile(
          dense: true,
          title: Text(value.toString(), style: cInfoCardStyle.copyWith(color: color),),
          subtitle: Text(title),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 80
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}