import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/whether_provider.dart';

class DropdownWidget extends StatelessWidget {
  var reloadApi;
  DropdownWidget({super.key, this.reloadApi});
  // String statename = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, cityProvider, _) => DropdownButton<String>(
        value: cityProvider.selectedCity ??
            cityProvider.selectedCitys[0], // Default value
        onChanged: (String? newValue) {
          cityProvider.setSelectedCity(newValue);
          cityProvider.statename = cityProvider.statename == ""
              ? cityProvider.selectedCitys[0]
              : newValue.toString();
          reloadApi();
        },
        items: cityProvider.selectedCitys
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
