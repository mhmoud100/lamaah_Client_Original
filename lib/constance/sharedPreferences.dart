// import 'package:my_cab/constance/constance.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MySharedPreferences {
//   Future<bool> getIsFirstTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getBool(ConstanceData.IsFirstTime) == null) {
//       await prefs.setBool(ConstanceData.IsFirstTime, false);
//     }
//     return prefs.getBool(ConstanceData.IsFirstTime);
//   }

//   Future setIsFirstTime(bool isFirstTime) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(ConstanceData.IsFirstTime, isFirstTime);
//   }

//   Future<int> getMapType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getInt(ConstanceData.IsMapType) == null) {
//       await prefs.setInt(ConstanceData.IsMapType, 0);
//     }
//     return prefs.getInt(ConstanceData.IsMapType);
//   }

//   Future setgetMapType(int maptype) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt(ConstanceData.IsMapType, maptype);
//   }

//   Future<int> getUserLoginTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getInt(ConstanceData.User_Login_Time) == null) {
//       prefs.setInt(ConstanceData.User_Login_Time, DateTime.now().toUtc().millisecondsSinceEpoch);
//     }
//     return prefs.getInt(ConstanceData.User_Login_Time);
//   }

//   Future setUsergetUserLoginTime(int time) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt(ConstanceData.User_Login_Time, time);
//   }

//   Future<int> getLastPDFTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getInt(ConstanceData.LAST_PDF_Time) == null) {
//       prefs.setInt(ConstanceData.LAST_PDF_Time, 0);
//     }
//     return prefs.getInt(ConstanceData.LAST_PDF_Time);
//   }

//   Future setLastPDFTime(int time) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt(ConstanceData.LAST_PDF_Time, time);
//   }
// }
