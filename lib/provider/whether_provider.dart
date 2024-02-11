import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier {
  List<String> selectedCitys = [];
  String statename = "";
  String? selectedCity;
  String get getselectCity => selectedCity.toString();

  // City get selectedCity => _selectedCity;

  void selectCity(String city) {
    selectedCitys.add(city);
    notifyListeners();
  }

  void removeCity(String city) {
    selectedCitys.remove(city);
    notifyListeners();
  }

  void setSelectedCity(city) {
    statename = city;
    selectedCity = city;
    notifyListeners();
  }
}
