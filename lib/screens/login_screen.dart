import 'package:chitchat/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'country_page.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String countryname = "Egypt";
  String countrycode = "+20";
  TextEditingController numberController = TextEditingController();
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
      body: SizedBox(
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
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (numberController.text.length < 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter your phone number correctly"),
                    ),
                  );
                } else {
                  _showMyDialog();
                }
              },
              child: Container(
                color: Colors.tealAccent[400],
                height: 40,
                width: 70,
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
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
              child: Center(
                child: Text(countryname),
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
        padding: const EdgeInsets.symmetric(vertical: 5),
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
                  const SizedBox(width: 10),
                  const Text("+", style: TextStyle(fontSize: 15)),
                  const SizedBox(width: 15),
                  Text(countrycode.substring(1),
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(width: 20),
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
                  controller: numberController,
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "We will be verifying the phone number:",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  "$countrycode ${numberController.text}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Text(
                  "Is this OK, or would you like to edit the number?",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  OtpScreen(
                    number:numberController.text, 
                    countrycode:countrycode
                  );
                }));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
