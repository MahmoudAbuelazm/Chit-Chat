import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number, required this.countrycode});
  final String number;
  final String countrycode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Verify +${widget.countrycode} ${widget.number}",
          style: TextStyle(
            color: Colors.teal[800],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.teal),
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "we have sent a SMS with a code to ",
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontSize: 14.5,
                  ),
                  children: [
                    TextSpan(
                      text: "+${widget.countrycode} ${widget.number}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "wrong number?",
                      style: TextStyle(
                        color: Colors.cyan[800],
                        fontSize: 14.5,
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 5,
            ),
            OTPTextField(
              length: 5,
              width: width,
              fieldWidth: 80,
              style: const TextStyle(
                fontSize: 17,
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {},
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter 6-digit code",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const BottomButton(
              text: "Resend SMS",
              icon: Icons.message,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 10,
            ),
            const BottomButton(
              text: "Call me",
              icon: Icons.call,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: 24,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.teal,
            fontSize: 14.5,
          ),
        )
      ],
    );
  }
}
