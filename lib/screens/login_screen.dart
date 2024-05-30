import 'package:chitchat/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'country_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String countryname = "Egypt";
  String countrycode = "+20";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Enter your phone number",
          style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              wordSpacing: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Text(
              "WhatsApp will send an SMS message to verify your phone number.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "What's my number?",
              style: TextStyle(
                fontSize: 13,
                color: Colors.cyan[800],
              ),
            ),
            const SizedBox(height: 15),
            countrycard(),
            const SizedBox(height: 5),
            number(),
          ],
        ),
      ),
    );
  }

  Widget countrycard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryPage(
              setCountryData: setCountryData,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.teal,
              width: 1.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(countryname),
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.teal)
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 38,
        child: Row(
          children: [
            Container(
              width: 70,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.teal,
                    width: 1.8,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text("+", style: const TextStyle(fontSize: 15)),
                  SizedBox(width: 10),
                  Text(countrycode.substring(1),
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5 - 100,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.teal,
                      width: 1.8,
                    ),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: "Phone number",
                    hintStyle: TextStyle(fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryname = countryModel.name;
      countrycode = countryModel.code;
    });
    Navigator.pop(context);
  }
}
