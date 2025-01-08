import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pinput/pinput.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogYesNo.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';
import 'package:tcbapp/pin/confirmpin.dart';
import 'package:tcbapp/pin/pinPage.dart';

class Confirmpin extends StatefulWidget {
  Confirmpin({super.key, required this.pin, this.cid, this.checklogin});

  @override
  State<Confirmpin> createState() => _ConfirmpinState();
  String? pin;
  String? cid;
  bool? checklogin;
}

class _ConfirmpinState extends State<Confirmpin> {
  final _pinController = TextEditingController();
  String _pin = "";
  List<String> enteredPin = [];

  void _onSubmit() {
    if (_pinController.text.length == 6) {
      if (_pinController.text == widget.pin) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => FirstPage(
              cid: widget.cid,
            ),
          ),
          (route) => false,
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
            widget.checklogin == true
                ? Text(
                    "ยืนยันรหัส Pin อีกครั้ง",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  )
                : Text(
                    'กรอกรหัส Pin',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
            SizedBox(height: 20),

            Pinput(
              obscureText: true,
              // obscuringCharacter: '',
              defaultPinTheme: PinTheme(
                height: MediaQuery.of(context).size.width > 600 ? size.height * 0.04 : size.height * 0.05,
                width: MediaQuery.of(context).size.width > 600 ? size.width * 0.05 : size.width * 0.076,
                textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600
                      ? 40 // ขนาดฟอนต์สำหรับ iPad
                      : 30, // ขนาดฟอนต์สำหรับโทรศัพท์
                  color: Color(0xff10497A),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                ),
              ),
              controller: _pinController,
              length: 6,
              showCursor: false,
              onChanged: (value) {
                setState(() {
                  _pin = value;
                });
              },
              onCompleted: (pin) {
                setState(() {
                  _pin = pin;
                  if (_pinController.text.length == 6) {
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PinPage(
                            check: false,
                          )));
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
    double screenWidth = MediaQuery.of(context).size.width;

    // กำหนดขนาดปุ่มตามความกว้างหน้าจอ
    double buttonSize = screenWidth > 600
        ? screenWidth * 0.1 // ขนาดสำหรับ iPad (จอใหญ่กว่า 600px)
        : screenWidth * 0.18; // ขนาดสำหรับโทรศัพท์

    double spacing = MediaQuery.of(context).size.height * 0.02; // ระยะห่างระหว่างแถว

    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // จัดกึ่งกลางแป้นตัวเลขในหน้าจอ
      children: [
        _buildNumpadRow(["1", "2", "3"], buttonSize),
        SizedBox(height: spacing),
        _buildNumpadRow(["4", "5", "6"], buttonSize),
        SizedBox(height: spacing),
        _buildNumpadRow(["7", "8", "9"], buttonSize),
        SizedBox(height: spacing),
        _buildNumpadRow(['', "0", "<"], buttonSize),
      ],
    );
  }

  Widget _buildNumpadRow(List<String> values, double buttonSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: values.map((value) {
        return GestureDetector(
          onTap: () => _handleNumpadTap(value),
          child: Container(
            margin: const EdgeInsets.all(8), // ขอบรอบปุ่ม
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value.isEmpty ? Colors.transparent : Colors.white,
              border: value.isNotEmpty ? Border.all(color: Colors.grey) : null,
            ),
            child: Center(
              child: value.isNotEmpty
                  ? Text(
                      value,
                      style: TextStyle(
                        fontSize: buttonSize * 0.4, // ปรับขนาดฟอนต์สัมพันธ์กับปุ่ม
                        fontWeight: FontWeight.bold,
                        color: value == "<" ? Colors.red : Colors.black,
                      ),
                    )
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleNumpadTap(String value) {
    if (value == "<") {
      // ลบตัวเลขตัวสุดท้าย
      if (_pinController.text.isNotEmpty) {
        setState(() {
          _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
        });
      }
    } else if (value.isNotEmpty) {
      // เพิ่มตัวเลข
      if (_pinController.text.length < 6) {
        setState(() {
          _pinController.text += value;
        });
      }
    }
  }
}
