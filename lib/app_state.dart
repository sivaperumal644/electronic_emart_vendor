import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  AppState() {
    getFromMemory();
  }

  String jwtToken = "";
  String vendorId = "";
  String vendorAddressLine = "";
  String vendorCity = "";
  String panFrontUrl;
  String panBackUrl;
  String shopPhotoUrl;
  String combinedPanImagesUrl = "";
  String searchText = "";
  String posterSearchText = "";

  static final HttpLink httpLink =
      HttpLink(uri: 'http://cezhop.herokuapp.com/graphql');

  GraphQLClient client = GraphQLClient(
    cache: InMemoryCache(),
    link: httpLink as Link,
  );

  Future<QueryResult> updatePhoneNumberMutation(String phoneNumber) async {
    final result = await client.mutate(
      MutationOptions(
        document: updateVendorAccountMutation,
        variables: {'phoneNumber': phoneNumber},
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer $jwtToken',
          },
        },
      ),
    );
    return result;
  }

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
    jwtToken = text;
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

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  void setVendorId(String id) {
    vendorId = id;
    notifyListeners();
  }

  void setPosterSearchText(String text) {
    posterSearchText = text;
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
  get getVendorId => vendorId;
  get getPosterSearchText => posterSearchText;
}
