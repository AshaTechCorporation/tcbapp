import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';
import 'package:tcbapp/pin/pinPage.dart';
import 'package:tcbapp/register/registerService.dart';

class Otppage extends StatefulWidget {
  Otppage({
    super.key,
    required this.fname,
    required this.lname,
    required this.cid,
    required this.date,
    required this.phone,
    required this.device_no,
    required this.notify_token,
    required this.refno,
  });

  @override
  State<Otppage> createState() => _OtppageState();
  String fname;
  String lname;
  String cid;
  String date;
  String phone;
  String device_no;
  String notify_token;
  String refno;
}

class _OtppageState extends State<Otppage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        LoadingDialog.open(context);
        String otpCode = _otpControllers.map((controller) => controller.text).join();
        await RegisterService.verifyOTP(
            otpCode, widget.refno, widget.fname, widget.lname, widget.cid, widget.date, widget.phone, widget.device_no, widget.notify_token);
        LoadingDialog.close(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PinPage(
                check: false,
              );
            },
          ),
        );
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PinPage(
        //             check: false,
        //           )),
        //   (route) => true,
        // );
      } on Exception catch (e) {
        if (!mounted) return;
        LoadingDialog.close(context);
        showDialog(
          context: context,
          builder: (context) => Dialogyes(
            title: 'แจ้งเตือน',
            description: '$e',
            pressYes: () {
              Navigator.pop(context);
            },
            bottomNameYes: 'ตกลง',
          ),
        );
      }
      // ถ้าข้อมูลครบถ้วน
    } else {
      print("กรุณากรอก OTP ให้ครบ");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff10497A), Color(0xFF00E0D0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.05),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'รหัส OTP จะส่งไปที่เบอร์โทร ${formatPhoneNumber(widget.phone)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Refno(${widget.refno})',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.1),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    6,
                    (index) {
                      return SizedBox(
                        height: size.height * 0.1,
                        width: size.height * 0.05,
                        child: TextFormField(
                          controller: _otpControllers[index],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorStyle: TextStyle(height: 0), // ซ่อนข้อความ error
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ''; // ส่งค่ากลับเพื่อแสดง errorBorder
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.length == 1 && index < 5) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: textColor),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ส่งใหม่',
                    style: TextStyle(color: kBackgroundColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBackgroundColor,
                    // side: BorderSide(color: textColor),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _validateAndSubmit,
                  child: Text(
                    'ตกลง',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatPhoneNumber(String phone) {
  if (phone.length >= 7) {
    String prefix = '***';
    //  phone.substring(0, 3); // +99
    String suffix = phone.substring(phone.length - 3);
    return '+99$prefix****$suffix';
  }
  return phone;
}
