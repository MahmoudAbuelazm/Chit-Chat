import 'package:flutter/material.dart';

import '../model/country_model.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key, required this.setCountryData});

  final Function setCountryData;
  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries = [
    CountryModel(name: "Egypt", code: "+20", flag: "🇪🇬"),
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Australia", code: "+61", flag: "🇦🇺"),
    CountryModel(name: "Canada", code: "+1", flag: "🇨🇦"),
    CountryModel(name: "France", code: "+33", flag: "🇫🇷"),
    CountryModel(name: "Germany", code: "+49", flag: "🇩🇪"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    CountryModel(name: "Japan", code: "+81", flag: "🇯🇵"),
    CountryModel(name: "Russia", code: "+7", flag: "🇷🇺"),
    CountryModel(name: "South Korea", code: "+82", flag: "🇰🇷"),
    CountryModel(name: "Spain", code: "+34", flag: "🇪🇸"),
    CountryModel(name: "Brazil", code: "+55", flag: "🇧🇷"),
    CountryModel(name: "Mexico", code: "+52", flag: "🇲🇽"),
    CountryModel(name: "Nigeria", code: "+234", flag: "🇳🇬"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Choose a country",
            style: TextStyle(
                color: Colors.teal,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                wordSpacing: 1),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.teal),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.teal),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return countrycard(countries[index]);
          },
        ));
  }

  Widget countrycard(
    CountryModel country,
  ) {
    return InkWell(
      onTap: () {
        widget.setCountryData(country.name, country.code);
      },
      child: Card(
        margin: const EdgeInsets.all(.15),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(
                country.flag,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                country.name,
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        country.code,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
