import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:tcbapp/utils/apiException.dart';

class RegisterService {
  const RegisterService();

  static Future register(
    String fname,
    String lname,
    String cid,
    String date,
    String phone,
    String device_no,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final domain = prefs.getString('domain');
    final url = Uri.https(domain!, '/api/login_mobile_app');
    final response = await http.post(
      url,
      body: {
        'fname': fname,
        'lname': lname,
        'cid': cid,
        'date': date,
        'phone': phone,
        'device_no': device_no,
      },
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return data['data'];
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

//ยืนยัน otp
  static Future verifyOTP(
    final String pin,
    final String refno,
    final String fname,
    final String lname,
    final String cid,
    final String date,
    final String phone,
    final String device_no,
    final String notify_token,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final domain = prefs.getString('domain');
    final url = Uri.https(domain!, '/api/Verify_OTP');
    final response = await http.post(url, body: {
      'pin': pin,
      'refno': refno,
      'fname': fname,
      'lname': lname,
      'cid': cid,
      'date': date,
      'phone': phone,
      'device_no': device_no,
      'notify_token': notify_token,
    });
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return data;
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  // ส่ง otp
  static Future requestOTP(
    String phone,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final domain = prefs.getString('domain');
    final url = Uri.https(domain!, '/api/Request_OTP');
    final response = await http.post(url, body: {"phone": phone});
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return data;
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }
}
