import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';

class Confirmpin extends StatefulWidget {
  Confirmpin({super.key, required this.pin});

  @override
  State<Confirmpin> createState() => _ConfirmpinState();
  String pin;
}

class _ConfirmpinState extends State<Confirmpin> {
  String _pin = "";
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final errorPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red),
      ),
    );

    // PinTheme ปกติ
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
    );

    // PinTheme เมื่อ Focus
    final focusedPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent),
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff10497A), Color(0xFF00E0D0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ยืนยันรหัสพินอีกครั้ง",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Enter PIN",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 4,
                    showCursor: true,
                    onChanged: (value) {
                      setState(() {
                        _pin = value;
                        _hasError = false;
                      });
                    },
                    onCompleted: (pin) {
                      setState(() {
                        _pin = pin;
                      });
                    },
                    defaultPinTheme: _hasError ? errorPinTheme : defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _hasError = true; // เกิดข้อผิดพลาด
                        });
                        return 'โปรดกรอกรหัสพิน';
                      }
                      return null;
                    },
                  ),
                ])),
            SizedBox(height: 40),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_pin.isNotEmpty && _pin.length == 4) {
                    if (_pin == widget.pin) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => FirstPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('รหัสพินไม่ตรงกัน')),
                      );
                    }
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('PIN Entered: $_pin')),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid PIN')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "ตกลง",
                style: TextStyle(fontSize: 18, color: textColor2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
