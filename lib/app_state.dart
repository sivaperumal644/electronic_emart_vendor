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
  String panFrontUrl;
  String panBackUrl;
  String shopPhotoUrl;
  String combinedPanImagesUrl = "";
  String searchText = "";

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

  void setPanFrontUrl(String text) {
    panFrontUrl = text;
    notifyListeners();
  }

  void setPanBackUrl(String text) {
    panBackUrl = text;
    notifyListeners();
  }

  void setShopPhotoUrl(String text) {
    shopPhotoUrl = text;
    notifyListeners();
  }

  void setCombinedPanImagesUrl(String text) {
    combinedPanImagesUrl = text;
    notifyListeners();
  }

  void setSearchText(String text){
    searchText = text;
    notifyListeners();
  }

  get getJwtToken => jwtToken;
  get getVendorAddressLine => vendorAddressLine;
  get getVendorCity => vendorCity;
  get getPanFrontUrl => panFrontUrl;
  get getPanBackUrl => panBackUrl;
  get getShopPhotoUrl => shopPhotoUrl;
  get getCombinedPanImagesUrl => combinedPanImagesUrl;
  get getSearchText => searchText;
}
