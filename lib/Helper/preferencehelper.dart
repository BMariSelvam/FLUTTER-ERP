import 'dart:convert';

import 'package:erp/Helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Model/GetAllProductModel.dart';
import '../Model/LoginUserModel.dart';
import 'constant.dart';

class PreferenceHelper {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<LoginUserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    if (prefs.containsKey(key)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        PreferenceHelper.log('Get User Data: $value');
        return LoginUserModel.fromJson(value);
      }
    }
    return null;
  }

  static Future<bool> saveUserData(Map userData) async {
    print("2222222222");
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    final value = json.encode(userData);
    print("3333333333");
    PreferenceHelper.log('Save User Data $value');

    return prefs.setString(key, value);
  }

  static Future<bool> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }

  static Future<void> saveEmail(
      {required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getEmail({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //List<GetAllProductModel> cartItems
  static Future<void> saveCartData(List<GetAllProductModel> cartItems) async {
    String? email = await PreferenceHelper.getEmail(key: 'my_key');
    final prefs = await SharedPreferences.getInstance();
    final key = email; // Use a regular variable here
    final cartItemsJson = cartItems
        .map((item) => item.toJson(forSharedPreference: true))
        .toList();
    prefs.setString(key!, json.encode(cartItemsJson));
    PreferenceHelper.log('Saved cart_data: $cartItemsJson');
  }

  static Future<List<GetAllProductModel>> getCartData() async {
    String? email = await PreferenceHelper.getEmail(key: 'my_key');
    final prefs = await SharedPreferences.getInstance();
    final key = email;
    if (prefs.containsKey(key!)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        return (value as List)
            .map((item) =>
                GetAllProductModel.fromJson(item, forSharedPreference: true))
            .toList();
      }
    }
    return [];
  }

  static Future<void> removeCartData() async {
    String? email = await PreferenceHelper.getEmail(key: 'my_key');
    final prefs = await SharedPreferences.getInstance();
    final key = email;
    await prefs.remove(key!);
    log('Cart data removed.');
  }

  static showSnackBar(
      {required BuildContext? context, String? msg, Duration? duration}) {
    if (msg != null && msg.isNotEmpty) {
      final messenger = ScaffoldMessenger.of(context!);
      messenger.showSnackBar(SnackBar(
        // margin: EdgeInsets.all(20),
        backgroundColor: MyColors.red,
        content: Text(
          msg,
        ),
        duration: duration ?? const Duration(seconds: 2),
      ));
    }
  }

  static String dateToString(
      {required DateTime date, String dateFormat = 'dd-MM-yyyy'}) {
    var formatter = DateFormat(dateFormat);
    String formatted = formatter.format(date);
    return formatted;
  }

  static String timeToString(
      {required TimeOfDay tod, String dateFormat = 'hh:mm a'}) {
    final now = DateTime.now();
    final dt =
        DateTime(now.year, now.month, now.day, tod.hour, tod.periodOffset);
    final format = DateFormat(dateFormat);
    return format.format(dt);
  }

  static String getDateTime(
      {required DateTime date,
      required TimeOfDay tod,
      dateFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    final dt = DateTime(date.year, date.month, date.day, tod.hour,
        (tod.minute % 5 * 5).toInt());
    final format = DateFormat(dateFormat);
    return format.format(dt);
  }

  static String stringDateFormat(
      {required String date, dateFormat = 'dd-MM-yyyy hh:mm a'}) {
    var parsedDate = DateTime.parse(date);
    return PreferenceHelper.dateToString(
        date: parsedDate, dateFormat: dateFormat);
  }

  static Widget showLoader({Color? color}) {
    if (color == null) {
      return const CircularProgressIndicator();
    } else {
      return CircularProgressIndicator(backgroundColor: color);
    }
  }

  static void call(String number) => launchUrlString("tel:$number");

  static void sendSms(String number) => launchUrlString("sms:$number");

  static void sendEmail(String email) => launchUrlString("mailto:$email");

  static void log(dynamic value) {
    if (value != null && Constant.showLog) {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(value).forEach((match) => debugPrint(match.group(0)));
    }
  }

  static void print(dynamic value) {
    if (value != null && Constant.showLog) {
      debugPrint(value);
    }
  }

  static Future<DateTime?> showTimePopup(
      BuildContext context, DateTime? dateTime) async {
    return await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (_) {
          dateTime ??= DateTime.tryParse("2023-01-01 00:00");
          DateTime? selectedDateTime;
          return Container(
            height: 280,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    minuteInterval: 15,
                    // (tod.minute % 5 * 5).toInt()
                    initialDateTime: dateTime
                        ?.add(Duration(minutes: 15 - dateTime!.minute % 15)),
                    // initialDateTime: selectedDateTime.add(Duration(minutes: 15 - selectedDateTime.minute % 15)),
                    minimumDate: dateTime ?? DateTime.now(),
                    onDateTimeChanged: (picked) {
                      selectedDateTime = picked;
                    },
                    // minuteInterval: 15,
                  ),
                ),

                /// Close the modal
                CupertinoButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context)
                      .pop(selectedDateTime ?? DateTime.now()),
                )
              ],
            ),
          );
        });
  }

  static Future<void> saveBanchCodeString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "companyBranch";
    await prefs.setString(key, value);
  }

  static Future<String?> getBanchCodeString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "companyBranch";
    return prefs.getString(key);
  }

  static Future<void> saveBranchNameString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "companyBranchName";
    await prefs.setString(key, value);
  }

  static Future<void> clearBanchNameString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "companyBranchName";
    await prefs.remove(key);
  }

  static Future<String?> getBranchNameString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "companyBranchName";
    return prefs.getString(key);
  }

  static Future<void> saveOrgString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "OrgNo";
    await prefs.setString(key, value);
  }

  static Future<String?> getOrgString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "OrgNo";
    return prefs.getString(key);
  }

  static Future<void> clearOrgString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "OrgNo";
    await prefs.remove(key);
  }
}

String formatDate(String? dateString) {
  if (dateString == null) {
    return "";
  }
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat("dd-MM-yyyy").format(dateTime);
  return formattedDate;
}
