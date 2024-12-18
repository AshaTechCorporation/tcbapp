import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pinput/pinput.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogYesNo.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';
import 'package:tcbapp/pin/confirmpin.dart';
import 'package:tcbapp/pin/pinPage.dart';

class Confirmpin extends StatefulWidget {
  Confirmpin({super.key, required this.pin});

  @override
  State<Confirmpin> createState() => _ConfirmpinState();
  String pin;
}

class _ConfirmpinState extends State<Confirmpin> {
  final _pinController = TextEditingController();
  String _pin = "";
  List<String> enteredPin = [];

  void _onSubmit() {
    if (_pinController.text.length == 4) {
      if (_pinController.text == widget.pin) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FirstPage(),
          ),
        );
      } else {
        _pinController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("รหัส PIN ไม่ตรงกัน")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("โปรดกรอก PIN 4 หลัก")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
              "ยืนยันรหัส Pin อีกครั้ง",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),

            Pinput(
              obscureText: true,
              // obscuringCharacter: '',
              defaultPinTheme: PinTheme(
                height: size.height * 0.05,
                width: size.width * 0.076,
                textStyle: const TextStyle(fontSize: 30, color: Color(0xff10497A)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                ),
              ),
              controller: _pinController,
              length: 4,
              showCursor: false,
              onChanged: (value) {
                setState(() {
                  _pin = value;
                });
              },
              onCompleted: (pin) {
                setState(() {
                  _pin = pin;
                  if (_pinController.text.length == 4) {
                    _onSubmit();
                  }
                });
              },
              readOnly: true,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final ok = await showDialog(
                    context: context,
                    builder: (context) => Dialogyesno(
                          title: 'แจ้งเตือน',
                          description: 'คุณต้องการเปลี่ยนรหัสพินใช่หรือไม่',
                          pressYes: () {
                            Navigator.pop(context, true);
                          },
                          pressNo: () {
                            Navigator.pop(context);
                          },
                          bottomNameYes: 'ตกลง',
                          bottomNameNo: 'ยกเลิก',
                        ));
                if (ok == true) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PinPage()));
                }
              },
              child: Text(
                "ลืมรหัส Pin",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 40),
            // Numpad
            _buildNumpad(),

            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _onSubmit,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: textColor,
            //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: Text(
            //     "ตกลง",
            //     style: TextStyle(fontSize: 18, color: kBackgroundColor2),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    return Column(
      children: [
        _buildNumpadRow(["1", "2", "3"]),
        _buildNumpadRow(["4", "5", "6"]),
        _buildNumpadRow(["7", "8", "9"]),
        _buildNumpadRow(['', "0", "<"]),
      ],
    );
  }

  Widget _buildNumpadRow(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        return GestureDetector(
            onTap: () {
              if (value == "<") {
                // ลบตัวเลขตัวสุดท้าย
                if (_pinController.text.isNotEmpty) {
                  setState(() {
                    _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
                  });
                }
              } else if (value.isNotEmpty) {
                // เพิ่มตัวเลขในช่อง
                if (_pinController.text.length < 4) {
                  setState(() {
                    _pinController.text += value;
                  });
                }
              }
            },
            child: value != ''
                ? Container(
                    margin: const EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all()),
                    child: Center(
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kBackgroundColor),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ));
      }).toList(),
    );
  }
}