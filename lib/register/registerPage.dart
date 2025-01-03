import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';
import "package:intl/intl.dart";
import 'package:tcbapp/otp/OtpPage.dart';
import 'package:tcbapp/register/registerService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController idCard = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController phone = TextEditingController();

  // final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  String device_no = '';
  String dateSentApi = '';
  String notify_token = '';
  String ios_id = '';

  void getdeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device_no = androidInfo.id;
    } else if (Platform.isIOS) {
      // ดึงข้อมูล Identifier for Vendor (iOS)
      final iosInfo = await deviceInfo.iosInfo;
      device_no = iosInfo.identifierForVendor ?? '';
      // ios_id = iosInfo;
      // print('iOS Identifier: ${iosInfo.identifierForVendor}');
    }
  }

  void getToken() async {
    var playerId = OneSignal.User.pushSubscription.id;
    inspect(playerId);
    notify_token = playerId!;
  }

  Future<void> _afterselectDate(BuildContext context) async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: kBackgroundColor,
        dayTextStylePredicate: ({required DateTime date}) {
          return TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          );
        },
        yearBuilder: ({required int year, TextStyle? textStyle, bool? isDisabled, bool? isSelected, bool? isCurrentYear, BoxDecoration? decoration}) {
          final buddhistYear = year + 543; // แปลงปี ค.ศ. เป็น พ.ศ.
          return Center(
            child: Text(
              '$buddhistYear',
              style: textStyle,
            ),
          );
        },
        // ปรับแต่งข้อความสำหรับตัวเลือกเดือน/ปี
        modePickerTextHandler: ({required DateTime monthDate}) {
          final buddhistYear = monthDate.year + 543; // แปลงปี ค.ศ. เป็น พ.ศ.
          final monthNames = [
            "มกราคม",
            "กุมภาพันธ์",
            "มีนาคม",
            "เมษายน",
            "พฤษภาคม",
            "มิถุนายน",
            "กรกฎาคม",
            "สิงหาคม",
            "กันยายน",
            "ตุลาคม",
            "พฤศจิกายน",
            "ธันวาคม"
          ];
          final monthName = monthNames[monthDate.month - 1];
          return "$monthName พ.ศ. $buddhistYear";
        },
        firstDate: DateTime(1959),
        lastDate: DateTime.now());

    final selectedDates = await showCalendarDatePicker2Dialog(
      dialogBackgroundColor: Colors.white,
      context: context,
      config: config,
      dialogSize: const Size(325, 400),
      value: [],
    );

    if (selectedDates != null && selectedDates.isNotEmpty) {
      final selectedDate = selectedDates.first;
      final formattedDate = _convertToBuddhistEra(selectedDate ?? DateTime.now());
      final formatttedDateapi = _convertToapi(selectedDate ?? DateTime.now());
      birthDate.text = formattedDate;
      dateSentApi = formatttedDateapi;
    }
  }

  // String _convertToBuddhistEra(DateTime date) {
  //   final buddhistYear = date.year + 543;
  //   return '${date.day}/${date.month}/$buddhistYear'; // รูปแบบ: วัน/เดือน/ปีพ.ศ.
  // }

  String _convertToBuddhistEra(DateTime date) {
    final buddhistYear = date.year + 543;
    final day = date.day.toString().padLeft(2, '0'); // เติม 0 ให้เป็นเลข 2 หลัก
    final month = date.month.toString().padLeft(2, '0'); // เติม 0 ให้เป็นเลข 2 หลัก
    return '$day-$month-$buddhistYear';
  }

  String _convertToapi(DateTime date) {
    final day = date.day.toString().padLeft(2, '0'); // เติม 0 ให้เป็นเลข 2 หลัก
    final month = date.month.toString().padLeft(2, '0'); // เติม 0 ให้เป็นเลข 2 หลัก
    return '${date.year}-$month-$day';
  }

  // String _convertToBuddhistEra(DateTime date) {
  //   final buddhistYear = date.year + 543;
  //   final formattedDate = DateFormat('yyyy-dd-MM').format(date);
  //   return formattedDate.replaceFirst(date.year.toString(), buddhistYear.toString());
  // }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getdeviceId();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 1,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kBackgroundColor, Color(0xFF00E0D0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'ลงทะเบียน',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'กรุณาระบุข้อมูลเบื้องต้นเพื่อลงทะเบียนเข้าใช้ระบบ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  buildInputField(
                    controller: name,
                    icon: Icons.person,
                    hint: 'ชื่อ (ไม่ต้องใส่คำนำหน้า เช่น นาย,นาง,นางสาว***)',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกชื่อ';
                      }
                    },
                    status: false,
                  ),
                  buildInputField(
                    controller: surname,
                    icon: Icons.person,
                    hint: 'นามสกุล',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกนามสกุล';
                      }
                    },
                    status: false,
                  ),
                  buildInputField(
                    controller: idCard,
                    icon: Icons.credit_card,
                    hint: 'เลขบัตรประชาชน 13 หลัก',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกเลขบัตรประชาชน 13 หลัก';
                      }
                    },
                    status: false,
                  ),
                  buildInputField(
                    controller: birthDate,
                    icon: Icons.calendar_today,
                    hint: 'วว-ดด-ปปปป',
                    keyboardType: TextInputType.none,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกวันเดือนปี';
                      }
                      return null;
                    },
                    status: true,
                  ),
                  buildInputField(
                    controller: phone,
                    icon: Icons.phone,
                    hint: 'เบอร์โทร',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกเบอร์โทร';
                      }
                    },
                    keyboardType: TextInputType.phone,
                    status: false,
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                  // Container(
                  //   color: kBackgroundColor,
                  //   width: double.infinity,
                  //   child: OutlinedButton(
                  //     onPressed: () async {
                  //       if (_formKey.currentState!.validate()) {
                  //         try {
                  //           LoadingDialog.open(context);
                  //           final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                  //           final SharedPreferences prefs = await _prefs;
                  //           await prefs.setString('domain', publicUrl);
                  //           await prefs.setString('cid', idCard.text);
                  //           final refno = await RegisterService.register(name.text, surname.text, idCard.text, dateSentApi, phone.text, device_no);
                  //           print(refno['data']);
                  //           if (!mounted) return;
                  //           LoadingDialog.close(context);
                  //           Navigator.pushAndRemoveUntil(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => Otppage(
                  //                       fname: name.text,
                  //                       lname: surname.text,
                  //                       cid: idCard.text,
                  //                       date: dateSentApi,
                  //                       phone: phone.text,
                  //                       device_no: device_no,
                  //                       notify_token: notify_token,
                  //                       refno: refno['data'],
                  //                     )),
                  //             (route) => true,
                  //           );
                  //         } on Exception catch (e) {
                  //           if (!mounted) return;
                  //           LoadingDialog.close(context);
                  //           showDialog(
                  //             context: context,
                  //             builder: (context) => Dialogyes(
                  //               title: 'แจ้งเตือน',
                  //               description: '$e',
                  //               pressYes: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               bottomNameYes: 'ตกลง',
                  //             ),
                  //           );
                  //         }
                  //         // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Otppage()));
                  //       }
                  //     },
                  //     style: OutlinedButton.styleFrom(
                  //       side: BorderSide(color: Colors.white),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       padding: EdgeInsets.symmetric(vertical: 16.0),
                  //     ),
                  //     child: Text(
                  //       'ลงทะเบียน/รับรหัส OTP',
                  //       style: TextStyle(color: Colors.white, fontSize: 16.0),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kBackgroundColor,
          ),
          margin: EdgeInsets.all(8),
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  LoadingDialog.open(context);
                  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                  final SharedPreferences prefs = await _prefs;
                  await prefs.setString('domain', publicUrl);
                  await prefs.setString('cid', idCard.text);
                  final refno = await RegisterService.register(name.text, surname.text, idCard.text, dateSentApi, phone.text, device_no);
                  // print(refno['data']);
                  if (!mounted) return;
                  LoadingDialog.close(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Otppage(
                              fname: name.text,
                              lname: surname.text,
                              cid: idCard.text,
                              date: dateSentApi,
                              phone: phone.text,
                              device_no: device_no,
                              notify_token: notify_token,
                              refno: refno,
                            )),
                    (route) => true,
                  );
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
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Otppage()));
              }
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text(
              'ลงทะเบียน/รับรหัส OTP',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    // required String label,
    required IconData icon,
    String? hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    required bool status,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: status,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint ?? '',
          prefixIcon: controller == birthDate
              ? GestureDetector(
                  onTap: () {
                    _afterselectDate(context);
                  },
                  child: Icon(icon, color: Colors.grey))
              : Icon(icon, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
            fontSize: 15,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 0),
                blurRadius: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              Shadow(
                offset: Offset(0, 0),
                blurRadius: 20,
                color: Color.fromARGB(149, 255, 255, 255),
              ),
            ],
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: controller == idCard
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(13),
                IdCardFormatter(),
              ]
            : controller == birthDate
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(10),
                    DateFormatter(),
                  ]
                : controller == phone
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                        PhoneNumberFormatter(),
                      ]
                    : [],
      ),
    );
  }
}

class IdCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 13) text = text.substring(0, 13);

    String formattedText = '';
    if (text.isNotEmpty) {
      final buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);

        if (i == 0 || i == 4 || i == 9 || i == 11) {
          if (i != text.length - 1) buffer.write('-');
        }
      }
      formattedText = buffer.toString();
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length), // เลื่อนตำแหน่งเคอร์เซอร์ไปท้ายสุด
    );
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) formatted += '-';
      formatted += text[i];
    }
    if (formatted.length > 10) formatted = formatted.substring(0, 10);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 10) text = text.substring(0, 10);

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
