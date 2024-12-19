import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';
import "package:intl/intl.dart";
import 'package:tcbapp/otp/OtpPage.dart';

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

  Future<void> _afterselectDate(BuildContext context) async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Colors.blue,
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
    );

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
      birthDate.text = formattedDate;
    }
  }

  // String _convertToBuddhistEra(DateTime date) {
  //   final buddhistYear = date.year + 543;
  //   return '${date.day}/${date.month}/$buddhistYear'; // รูปแบบ: วัน/เดือน/ปีพ.ศ.
  // }

  String _convertToBuddhistEra(DateTime date) {
    final buddhistYear = date.year + 543;
    return '${date.day}-${date.month}-${buddhistYear}';
  }

  // String _convertToBuddhistEra(DateTime date) {
  //   final buddhistYear = date.year + 543;
  //   final formattedDate = DateFormat('yyyy-dd-MM').format(date);
  //   return formattedDate.replaceFirst(date.year.toString(), buddhistYear.toString());
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 1,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kBackgroundColor, Color(0xFF00E0D0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
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
                    hint: 'ชื่อ',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกชื่อ';
                      }
                    },
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
                  ),
                  buildInputField(
                    controller: birthDate,
                    icon: Icons.calendar_today,
                    hint: 'ปปปป-ดด-วว',
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'กรุณากรอกวันเดือนปี';
                      }
                      return null;
                    },
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
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    color: kBackgroundColor,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Otppage()));
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
                ],
              ),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
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
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 4 || i == 6) formatted += '-';
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
    String text = newValue.text.replaceAll(RegExp(r'\D'), ''); // ลบตัวที่ไม่ใช่ตัวเลข
    String formatted = '';

    for (int i = 0; i < text.length; i++) {
      if (i == 3) {
        formatted += '-';
      } else if (i == 6) {
        formatted += '-';
      }
      formatted += text[i];
    }

    if (formatted.length > 13) formatted = formatted.substring(0, 13);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
