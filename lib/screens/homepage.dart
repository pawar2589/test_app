import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/wetherResponseModel.dart';
import 'package:test_app/provider/whether_provider.dart';
import 'package:test_app/utility/api_config.dart';
import 'package:test_app/utility/apimanager.dart';
import 'package:test_app/utility/assets.dart';
import 'package:test_app/widget/dropdownWidget.dart';

import '../utility/logger.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Current currentResponce = Current();
  Forecast forecastResponce = Forecast();
  bool isLoading = false;
  List<Forecastday> forcastDayListResponce = <Forecastday>[];
  Day dayForcast = Day();

  void tempapidata() async {
    isLoading = true;
    var df = Provider.of<WeatherProvider>(context, listen: false);

    var key = "4b3170f9ca8849f89f993626241102%20";
    var decodedKey = key.replaceAll("%20", " ");
    Map<String, dynamic> request = <String, dynamic>{};
    request["q"] = df.statename;
    request["days"] = "7";
    request["key"] = decodedKey;

    loger.i("message :${df.statename} ");
    WetherResponseModel wetherResponseModel = WetherResponseModel.fromJson(
        await apimanager().getapi(request, ApiConfig.todayforcastUrl));
    loger.i("wetherResponseModel : $wetherResponseModel");
    if (wetherResponseModel.current != null) {
      currentResponce = wetherResponseModel.current!;
      forecastResponce = wetherResponseModel.forecast!;
      if (forecastResponce.forecastday!.isNotEmpty) {
        forcastDayListResponce = forecastResponce.forecastday!;
      }
    }
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempapidata();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<DateTime> nextSevenDays =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    String formattedDate = DateFormat("EEEE, d MMMM").format(now);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade100,
        actions: [
          DropdownWidget(
            reloadApi: tempapidata,
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<WeatherProvider>(
                              builder: (context, cityProvider, _) {
                            return Text(
                              cityProvider.statename,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            );
                          }),
                          Text(formattedDate),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 8, right: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppAssets.sun,
                                  scale: 16,
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "${currentResponce.tempF}",
                                  style: const TextStyle(
                                    color: Colors.black26,
                                    fontSize: 45,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Row(
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Next 7 days",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent.shade100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 125,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nextSevenDays.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 18),
                          width: 90,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                )
                              ],
                              color: Colors.blueAccent.shade100,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  index == 0
                                      ? "${currentResponce.tempF}"
                                      : "${forcastDayListResponce[index].day!.mintempF}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Text(
                                DateFormat('EEEE').format(nextSevenDays[index]),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
