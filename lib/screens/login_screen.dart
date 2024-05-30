import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
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
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Text(
              "WhatsApp will send an SMS message to verify your phone number.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "What's my number?",
              style: TextStyle(
                fontSize: 13,
                color: Colors.cyan[800],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget countrycard() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
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
                  child: Text("India"),
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.teal)
          ],
        ),
      ),
    );
  }
}
