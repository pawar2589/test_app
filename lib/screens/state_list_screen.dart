import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/state.dart';
import 'package:test_app/provider/whether_provider.dart';
import 'package:test_app/screens/homepage.dart';
import 'package:test_app/utility/logger.dart';

class StateSelectionPage extends StatefulWidget {
  const StateSelectionPage({super.key});

  @override
  State<StateSelectionPage> createState() => _StateSelectionPageState();
}

class _StateSelectionPageState extends State<StateSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (ctx, weatherProvider, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent.shade100,
          title: const Text("Selected Cities"),
        ),
        body: ListView.builder(
          itemCount: DataHelper().cityData().length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  if (weatherProvider.selectedCitys
                      .contains(DataHelper().cityData()[index])) {
                    weatherProvider.removeCity(DataHelper().cityData()[index]);
                  } else {
                    weatherProvider.selectCity(DataHelper().cityData()[index]);
                  }
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.blueGrey.shade100,
                        border: weatherProvider.selectedCitys
                                .contains(DataHelper().cityData()[index])
                            ? Border.all(color: Colors.blue, width: 1.6)
                            : Border.all(color: Colors.blueGrey)),
                    padding: const EdgeInsets.all(16),
                    child: Text(DataHelper().cityData()[index])));
          },
        ),
        bottomNavigationBar:
            Consumer<WeatherProvider>(builder: (context, cityProvider, _) {
          return InkWell(
            onTap: () {
              cityProvider.selectedCity = null;
              cityProvider.statename = cityProvider.selectedCitys[0];
              loger.i(
                  'slected cirthsdfisdhdfgrfhi-->>>r${weatherProvider.selectedCitys}');

              print(
                  'slected cirthsdfisdhdfgrfhi-->>>r${weatherProvider.selectedCitys}');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Homepage();
                },
              ));
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(color: Colors.blueAccent.shade100),
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 21),
              ),
            ),
          );
        }),
      );
    });
  }
}
