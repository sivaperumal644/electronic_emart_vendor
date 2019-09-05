import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  AppState() {
    getFromMemory();
  }

  String jwtToken = "";
  String vendorId = "";
  String jwtTokenHeader = "";
  String vendorAddressLine = "";
  String vendorCity = "";

  Future getFromMemory() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token") ?? "";
    final id = pref.getString("vendorId");
    vendorId = id;
    jwtToken = token;
  }

  void setVendorAddressLine(String text) {
    vendorAddressLine = text;
    notifyListeners();
  }

  void setVendorCity(String city) {
    vendorCity = city;
    notifyListeners();
  }

  void setJwtToken(String text) {
    jwtTokenHeader = text;
    notifyListeners();
  }

  get getJwtToken => jwtToken;
  get getVendorAddressLine => vendorAddressLine;
  get getVendorCity => vendorCity;
}
